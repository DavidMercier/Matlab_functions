%% Copyright 2017 MERCIER David
function [wR, wR_approx] = wearRate(r, w, h, R, F, L, varargin)
%% Calculation of wear rate from pin-on-disk tribometer experiments
% From "Standard Test Method for Wear Testing with a Pin-on-Disk Apparatus", ASTM G99-05, 2010.
% From "Norme française pour la Détermination du taux d’usure selon la méthode pin-on-disk", NF EN 1071-13, AFNOR Normalisation, 2010.

% R: radius of the wear mark (m)
% w: width of the groove (m)
% h: depth of the groove (m)
% r: radius of the ball (m)
% F: applied load (N)
% L: sliding distance (m) L = N*2*pi*R with N the number of laps
% S: cross-sections (m^2)
% V: worn volume of the sample (m^3)
% wR: wear rate in (m^2/N)

% Only valid if assuming no significant pin wear !
% This  is  an approximate geometric relation that is correct to 1%
% for (w/r) < 0.3, and is correct to 5 % for (w/r) < 0.8.

if nargin == 0
    R = 10e-3;
    w = [1.2 1.2 1.1 1.1].*1e-4;
    h = [2.6 2.2 2.3 2.2].*1e-7;
    r = 3e-3;
    F = 5;
    L = 10000 * 2*pi*R;
end

if length(w) ~= 4 || length(h) ~= 4
    error('4 widths or lengths of groove are needed !');
end

if (mean(w)/r) < 0.3
   display('Correct to 1% !');
end

if (mean(w)/r) > 0.3 && (mean(w)/r) < 0.8
   display('Correct to 5% !'); 
end

% Calculation of cross-sections (S) in m^2
S = zeros(1,4);
for ii = 1:4
    S(ii) = ((r^2) * asin(w(ii)/(2*r))) - ((w(ii)/4)*(4*(r^2)-(w(ii)^2))^(0.5));
end

Stot = mean(S);

% Calculation of worn volume (V) in m^3
V = (2 * pi * R * Stot);

% Calculation of approximated worn volume (V) in m^3
V_approx = (pi * (R) * (mean(w))^3)/(6*r);

% Calculation of wear rate (wR) in (m^2/N) or un (m^3/(N.m))
wR = V / (F*L);
wR_approx = V_approx / (F*L);

% Calculation of wear rate (wR) in (mm^3/(N.m))
wR = (V * 1e9) / (F*L);
wR_approx = (V_approx * 1e9) / (F*L);

end