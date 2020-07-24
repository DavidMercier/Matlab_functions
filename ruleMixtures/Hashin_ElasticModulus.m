%% Copyright 2014 MERCIER David
function HashinAverage = Hashin_ElasticModulus(E_M, E_F, Poisson_M, ...
    Poisson_F, volumeFraction, varargin)
%% Function giving the Hashin average
% From D.M. Karpinos, Composite Materials, Handbook. Kiev: Naukova Dumka 1985

% author: david9684@gmail.com

% Calculation of Young's modulus in the longitudinal direction E1 of a
% composite (transversely isotropic fibers and isotropic matrix)

if nargin < 5
    volumeFraction = 0.3; % in %
end

if nargin < 4
    Poisson_F = 0.3; % Poisson's ratio of the fibers
end

if nargin < 3
    Poisson_M = 0.3; % Poisson's ratio of the matrix
end

if nargin < 2
    E_F = 400; % Elastic modulus of the fibers (GPa)
end

if nargin < 1
    E_M = 100; % Elastic modulus of the matrix (GPa)
end

L_m = 1 - Poisson_M - 2.*Poisson_M.^2;
L_f = 1 - Poisson_F - 2.*Poisson_F.^2;

HashinAverage = E_F.*volumeFraction + E_M.*(1-volumeFraction) + ...
    (2.*(Poisson_F-Poisson_M).^2.*volumeFraction.*(1-Poisson_F)) ./ ...
    (E_M.*(1-Poisson_M).*L_f + (L_m.*(1-volumeFraction)+(1-Poisson_M).*E_F));

end