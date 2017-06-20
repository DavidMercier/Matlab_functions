%% Copyright 2014 MERCIER David
function Kc_int = interfacialToughness(Gamma, Eint, varargin)
%% Calculation of interfacial toughness
% From J. Malzbender et al., "Measuring mechanical properties of coatings: 
% a methodology applied to nano-particle-filled sol–gel coatings on glass",
% Materials Science and Engineering: R: Reports, 36(2), 47-103, 2002.

% Kc: fracture toughness in MPa.m^(0.5)

% Gamma: Fracture energy in J/m2 = 1 N/m = 1Pa.m = 1e-3 GPa.µm = 1e-6 MPa.m
% Eint: Interfacial elastic modulus in GPa

% author: david9684@gmail.com

if nargin < 1
    Gamma = 1;
    Eint = 20;
end

Kc_int = ((Gamma*1e-6) * (Eint*1e3))^(0.5);

end
