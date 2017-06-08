%% Copyright 2017 MERCIER David
function wR = wearRate(r, w, R, F, L, varargin)
%% Calculation of wear rate from pin-on-disk tribometer experiments
% From "Standard Test Method for Wear Testing with a Pin-on-Disk Apparatus", ASTM G99-05, 2010.
% From "Norme française pour la Détermination du taux d’usure selon la méthode pin-on-disk", NF EN 1071-13, AFNOR Normalisation, 2010.

% r: radius of the wear mark (m)
% w: width of the groove (m)
% R: radius of the ball (m)
% F: applied load (N)
% L: sliding distance (m) L = N*2*pi*r with N the number of laps
% S: cross-sections (m^2)
% V: worn volume of the sample (m^3)
% wR: wear rate in (m^2/N)

if nargin == 0
    r = 10e-3;
    w = [100 110 115 112].*1e-6;
    R = 6e-3;
    F = 5;
    L = 2000 * 2*pi*r;
end

% Calculation of cross-section (S) in m^2
for ii = 1:4
    S(ii) = ((R^2) * asind(w(ii)/(2*r))) - ((w(ii)/4)*(4*(r^2)-(w(ii)^2))^(0.5));
end

Stot = sum(S);

% Calculation of worn volume (V) in m^3
V = (pi * r * Stot) / 2;

% Calculation of wear rate (wR) in (m^2/N)
wR = V / (F*L);

end