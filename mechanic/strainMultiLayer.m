%% Copyright 2016 MERCIER David
function strainML = strainMultiLayer(E, nu, t, z_ind, R, varargin)
%% Function giving the Reuss's average
% From S. Logothetidis, "Handbook of Flexible Organic Electronics: Materials,
% Manufacturing and Applications", Elsevier, Cambridge, 2014.
% Default values from Gerthoffer A. et al. - DOI:10.1016/j.solmat.2016.11.022

% author: david9684@gmail.com

% E: Young's modulus of a layer (GPa)
% E_red: Reduced Young's modulus of a layer (GPa)
% nu: Poisson's coefficient of a layer
% t: Thickness of a layer (mm)
% z: Position of the layer in the multilayer (integer between 1 and n)
% R: radius of curvature (mm)
% strainML: Strain induced in the structure (%)

colorPlot = {'b','r','k',[.5 .6 .7],[.8 .2 .6],'c','m','g','y'};

if nargin < 5
    R = 0:0.1:140;
end

if nargin < 4
    z_ind = 3;
end

if nargin < 3
    t = [100 0.55 2.3 0.45 ; 25 0.55 2.3 0.45]/1e3;
end

if nargin < 2
    nu = [0.208 0.3 0.3 0.3 ; 0.3 0.3 0.3 0.3];
end

if nargin < 1
    E = [72.9 289 70 100 ; 9.1 289 70 100];
end

E_red = E./(1 - nu.^2);

z_film = zeros(size(t,1),size(t,2));
z_film(:,1) = t(:,1)/2;
for ii = 2:length(t)
    for jj = 1:size(t,1)
        z_film(jj,ii) = t(jj,ii)/2 + sum(t(jj,1:ii-1));
    end
end

assert(size((E_red .* t .* z_film), 1) == size((E_red),1));
assert(size((E_red .* t), 1) == size((E_red),1));

z_na = zeros(size(t,1),1);
for jj = 1:size(t,1)
    z_na(jj) = sum(E_red(jj,:) .* t(jj,:) .* z_film(jj,:)) ./ ...
        sum(E_red(jj,:) .* t(jj,:));
end

figure;
strainML = zeros(size(t,1),length(R));
for jj = 1:size(t,1)
    strainML(jj,:) = (z_film(jj,z_ind) - z_na(jj)) ./ R;
    plot(R, strainML(jj,:)*100, 'LineWidth', 3, ...
        'Color', colorPlot{jj});
    hold on;
end

xlabel('Radius of curvature (in mm)');
ylabel('Strain induced (%)');
xlim([0 max(R)]);
ylim([0 0.35]);
title('Strain in a bent multilayer structure');
grid on;
legend({'100um glass', '25um polyimide'}, 'Location', 'NorthEast');

end