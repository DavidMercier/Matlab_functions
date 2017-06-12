%% Copyright 2017 MERCIER David
function condFilm = MayadasSchatzke(s0, l0, t, varargin)
%% Calculation of the electical conductivity of a thin film
% From Mayadas, A.F., "Electrical resistivity model for polycrystalline films: the case of specular reflection
% at external surfaces", App. Physics Letters 14, 345, 1969.
% and from Mayadas, A.F. and Shatzkes, M., "Electrical-resistivity model for polycrystalline films: the case of
% arbitrary reflection at external surfaces", Physical Review B 1, 1382, 1970.

% s0: conductivity of the bulk material in Ohm.m
% l0: electron mean free path in the bulk material in nm
% t: film thickness in nm
% p: specularity parameter.
% If p = 0, electrons scatter inelastically at the surface (diffusion).
% If p = 1, electrons scatter elastically (reflection).
% R: probability of electrons to either be reflected or transmitted to cross the potential barriers
% If R = 0, electrons are entirely transmitted through the potential barrier.
% If R = 1, electrons are fully reflected and the resistivity is maximum
% D: average grain size that describes the density of grain boundaries (nm)

% author: david9684@gmail.com

if nargin == 0
    % Example with Ag thin film
    s0 = 1.61 * 1e-8; % From Kittel C., "Introduction to Solid State Physics", 8th ed. Wiley,New York (2005).
    l0 = 53; % From Boyer L. and Houzé F., "Résistance électrique de contact : Revue des différents modèles", L'onde électrique (1991).
    t = 1:100;
    p = 0:0.1:1;
    R = 0:0.2:1;
    D = 50;
end

%% Calculation of the film conductivity
condSurf = zeros(length(t),length(p),length(R));
condGB = zeros(length(t),length(p),length(R));
condFilm = zeros(length(t),length(p),length(R));

for ii = 1:length(t)
    for jj = 1:length(p)
        for kk = 1:length(R)
            % Calculation of contribution of surface and grain boundary scattering
            condSurf(ii,jj,kk) = (3/8) * s0 * (1-p(jj)) * (l0/t(ii));
            condGB(ii,jj,kk) = 1.5 * s0 * (R(kk)/(1-R(kk))) * (l0/D);
            % Calculation of the film conductivity
            condFilm(ii,jj,kk) = s0 + condSurf(ii,jj,kk) + condGB(ii,jj,kk);
        end
    end
end

%% Plot
wid = logspace(0.1,0.7,length(p));
for ii = 1:length(p)
    figure(ii);
    for jj = 1:length(R)
    h = plot(t, condFilm(:,ii, jj));
    set(h,'linewidth',1+wid(ii));
    xlabel('Film thickness (nm)');
    ylabel('Film conductivity (Ohm.m)');
    title(strcat('p = ', num2str(p(ii))));
    grid on;
    hold on;
    xlim([0 max(t)]);
    ylim([0 50*1e-8]);
    end
end
legend(strcat('R = ', num2str(p')));

end