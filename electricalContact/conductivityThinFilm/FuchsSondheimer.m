%% Copyright 2017 MERCIER David
function normCondFilm = FuchsSondheimer(s0, l0, t, p, varargin)
%% Calculation of the electical conductivity of a thin film
% From Fuchs, K., "The conductivity of thin metallic films according
% to the electron theory of metals", Cambridge Univ Press, 1983, pp. 100–108.
% and from Sondheimer, E.H., "The mean free path of electrons in metals",
% Advances in Physics 50, 2001, 499–537.

% s0: conductivity of the bulk material in Ohm.m
% l0: electron mean free path in the bulk material in nm
% t: film thickness in nm
% p: specularity parameter.
% If p = 0, electrons scatter inelastically at the surface (diffusion).
% If p = 1, electrons scatter elastically (reflection).

% author: david9684@gmail.com

if nargin == 0
    % Example with Ag thin film
    s0 = 1.61 * 1e-8; % From Kittel C., "Introduction to Solid State Physics", 8th ed. Wiley,New York (2005).
    l0 = 53; % From Boyer L. and Houzé F., "Résistance électrique de contact : Revue des différents modèles", L'onde électrique (1991).
    t = 1:100;
    p = 0:0.1:1;
end

%% Ratio of the film thickness to the electron mean free path in the bulk material
kappa = t/l0;

%% Calculation of the normalized film conductivity
normCondFilm = zeros(length(t),length(p));
for ii = 1:length(t)
    for jj = 1:length(p)
        if kappa < 1 % Only valid for kappa << 1 !
            normCondFilm(ii,jj) = (1 + ((3*l0)/(8*t(ii)))*(1-p(jj)))*s0;
        else % Only valid for kappa >> 1 !
            normCondFilm(ii,jj) = (-(4/3)*((1-p(jj))/(1+p(jj)))*((l0)/(t(ii)*log(kappa(ii)))))*s0;
            if t(ii) > 10*l0
                display('See Matthessien''s rule...');
            end
        end
    end
end

%% Plot
figure;
wid = logspace(0.1,0.7,length(p));
for ii = 1:length(p)
    h = semilogy(t, normCondFilm(:,ii));
    set(h,'linewidth',1+wid(ii));
    xlabel('Film thickness (nm)');
    ylabel('Film conductivity (Ohm.m)');
    grid on;
    hold on;
    xlim([0 max(t)]);
end
legend(strcat('p = ', num2str(p')));

end