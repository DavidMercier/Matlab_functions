%% Copyright 2014 MERCIER David
function G = shear_modulus(C12, C44, varargin)
% E : Young's modulus in TPa
% nu: Poisson's coefficient
% G : Shear modulus in TPa

% author: david9684@gmail.com

if nargin < 2
    % Elastic constants of the Titanium (hcp)
    C12 = 0.0903;
    C44 = 0.0465;
end

E = C44*(3*C12 + 2*C44)/(C12 + C44);

nu = coeff_poisson(C12, C44);

G = E/(2*(1+nu));

end