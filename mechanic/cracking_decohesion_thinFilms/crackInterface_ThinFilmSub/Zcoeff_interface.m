%% Copyright 2014 MERCIER David
function Z = Zcoeff_interface(Ef, Es, nuf, nus, varargin)
%% Calculation of decohesion number in film decohesion
% From A. G. Evans et al., "The cracking and decohesion of thin films", 
% Journal of Materials Research, 3(5), 1043-1049, 1988.

% Z: Adimensonnal parameter for toughness/released energy calculations in a
% plane strain problem (or OMEGA_c^(0.5))
% alpha and beta: Dimensionless Dundur's parameters
% Ef and Es: Young's modulus of coating and subtrate in GPa
% nuf and nus: Poisson's coefficient of coating and subtrate
% I: Moment of inertia
% S: Elastic moduli ratio
% l: Relative crack depth (l=1 means coating is fully cracked along the
% thickness)

% author: david9684@gmail.com

if nargin < 1
    Ef = 245;
    Es = 180;
    nuf = 0.3;
    nus = 0.3;
    l = 1;
end

a = alpha(Ef, Es, nuf, nus);
b = beta(nuf, nus);

Z = 0.5 * pi * g_alpha(a, b, Ef, Es, l);

end

function g = g_alpha(alpha, beta, Ef, Es, l)
if alpha ==0 && beta == 0
    g = (1.1215)^2;
else
    S = Ef/Es;
    D = ((l^2)+(2*l*S)+S)/(2*(l+S));
    I = (S*((3*(D-l)^2)-3*(D-l)+1)+(3*D*l*(D-l))+(l^3))/3;
    g = (1/(l+S))*(1+(((l^2)*((l+1)^2))/(4*(l+S)*I)));
end
end

function a = alpha(Ef, Es, nuf, nus)
Ef_red = Ef/(1-nuf^2);
Es_red = Es/(1-nus^2);
a = (Ef_red - Es_red) / (Ef_red + Es_red);
end

function b = beta(nuf, nus)
b = (nuf*(1-2*nus)-nus*(1-2*nuf))/(2*nuf*(1-nus)+2*nus*(1-nuf));
end