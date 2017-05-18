%% Copyright 2014 MERCIER David
function Eint = interfacialElasticModulus(Ef, Es, varargin)
%% Calculation of interfacial elastic modulus
% From J. Malzbender et al., "Measuring mechanical properties of coatings: 
% a methodology applied to nano-particle-filled sol–gel coatings on glass",
% Materials Science and Engineering: R: Reports, 36(2), 47-103, 2002.

% Eint: Elastic modulus of the interface in GPa

% Ef: Elastic modulus of the coating in GPa
% Es: Elastic modulus of the substrate in GPa

% author: david9684@gmail.com

if nargin < 1
    Ef = 20; % in GPa
    Es = 100; % in GPa
    
end

display(Ef);
display(Es);

Eint = (0.5 * ((1/Ef)+(1/Es)))^(-1);

end