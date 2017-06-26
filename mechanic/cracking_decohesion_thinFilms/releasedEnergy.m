%% Copyright 2014 MERCIER David
function Gc = releasedEnergy(Z, sigma, h, Ef, nuf, varargin)
%% Calculation of released energy during cracking
% From A. G. Evans et al., "The cracking and decohesion of thin films", 
% Journal of Materials Research, 3(5), 1043-1049, 1988.
% From J. W. Hutchinson and Z. Suo, "Mixed mode cracking in layered materials",
% Advances in applied mechanics, 29(63), 191, 1992.
% From A. Favache et al., "Fracture toughness measurement of ultra-thin hard
% films deposited on a polymer interlayer", Thin Solid Films, 550, 464-471, 2014.

% Gc: Energy released in J/m2 = 1 N/m = 1Pa.m = 1e-3 GPa.µm = 1e-6 MPa.m

% Z: Non-dimensional parameter function of the elastic mismatch between 
% the coating and the substrate through the Dundurs' coefficients (or OMEGA_c^(0.5))
% sigma: Internal tensile stress in GPa
% h: Thickness of the thin film in micron
% Ef: Elastic modulus of the thin film in GPa
% nuf: Poisson's coefficient of the thin film

% author: david9684@gmail.com

if nargin < 1
    Z = 1.46;
    sigma = 0.934;
    h = 0.1;
    Ef = 245;
    nuf = 0.3;
end

Gc = (Z * (sigma^2) * h ) / (Ef./(1-nuf^2)) * 1e3;

end
