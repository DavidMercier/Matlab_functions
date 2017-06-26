%% Copyright 2014 MERCIER David
function Z = Zcoeff_film(Ef, Es, nuf, nus, varargin)
%% Calculation of critical film cracking number in film cracking
% From A. G. Evans et al., "The cracking and decohesion of thin films",
% Journal of Materials Research, 3(5), 1043-1049, 1988.
% From J. L. Beuth., "Cracking of thin bonded films in residual tension",
% International Journal of Solids and Structures, 29(13), 1657-1675, 1992.
% See also A. Favache et al., "Fracture toughness measurement of ultra-thin hard
% films deposited on a polymer interlayer", Thin Solid Films, 550, 464-471, 2014.

% Z: Adimensonnal parameter for toughness/released energy calculations in a
% plane strain problem (or OMEGA_c^(0.5))
% alpha and beta: Dimensionless Dundur's parameters
% Ef and Es: Young's modulus of coating and subtrate in GPa
% nuf and nus: Poisson's coefficient of coating and subtrate
% sigma_0: Residual stress in the film in GPa
% sigma_inf: Applied tension to the film in GPa
% Y: Substrate yield stress in GPa

% author: david9684@gmail.com

if nargin < 1
    Ef = 245;
    Es = 180;
    nuf = 0.3;
    nus = 0.3;
    sigma_0 = 0.1;
    sigma_inf = 2;
    Y = 1;
end

% a = alpha(Ef, Es, nuf, nus);
% b = beta(nuf, nus);
%Z = 0.5 * pi * g_alpha(a, b, Ef, Es, l);

Ef_red = Ef/(1-nuf^2);
Es_red = Es/(1-nus^2);
a = alpha(Ef, Es, nuf, nus)
b = beta(nuf, nus)

sigma_f = sigma_0 + sigma_inf*(Es_red/Ef_red);
Z = sigma_f / (Y * (3)^(1/3));

end

function g = g_alpha(alpha, beta, Ef, Es, l)
g_alpha = f(alpha, beta, Ef, Es, l);
end

function a = alpha(Ef, Es, nuf, nus)
Ef_red = Ef/(1-nuf^2);
Es_red = Es/(1-nus^2);
a = (Ef_red - Es_red) / (Ef_red + Es_red);
end

function b = beta(nuf, nus)
b = (nuf*(1-2*nus)-nus*(1-2*nuf))/(2*nuf*(1-nus)+2*nus*(1-nuf));
end