%% Copyright 2014 MERCIER David
function pValues = pressureFlatPunch_Jordan(Esub, Eind, load, ae, varargin)
%% Function giving the pressure at the interface between a flat punch
% and an elastic half-space

% author: david9684@gmail.com

% See PhD thesis of Diop M.D., "Contribution à l'étude mécanique et électrique
% du contact localisé : Adaptation de la nanoindentation à la microinsertion." (2009).
% ... and see Jordan E. H. et Urban M. R. (1999) - DOI: 10.1016/S0043-1648(99)00284-7

% Esub: Young's modulus of the substrate in GPa
% Eind: Young's modulus of the indenter in GPa
% load: Applied load in mN
% ae: Elastic radius in microns (~ radius of the flat punch)
% pValues: Values of the pressure in GPa between the flat punch and an elastic half-space

if nargin < 4
    ae = 6; % in microns
end

if nargin < 3
    load = 53; % in mN
end

if nargin < 2
    Eind = 261; % in GPa
end

if nargin < 1
    Esub = 53; % in GPa
end

radialPos = 0:ae/100:ae;

lambdaFit = lambda(Esub, Eind);

pValues = (load .* (1-lambdaFit)) ./ ...
    ((pi .* ae.^2) .* (ae.^2 - radialPos.^2).^lambdaFit);

xdata = radialPos./ ae;
ydata = pValues;

plot(xdata, ydata);
xlabel('Radial position / Elastic contact radius');
ylabel('Pressure (in GPa)');
ylim([0 max(ydata)]);
title('Jordan''s model');

end