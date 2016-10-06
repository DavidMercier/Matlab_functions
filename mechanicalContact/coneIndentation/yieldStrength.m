%% Copyright 2014 MERCIER David
function Y = yieldStrength(E, nu, beta, H, varargin)
%% Relationship between the dimensionless quantities H/Y and the indentation index.
% From "Nanostructured Thin Films and Coatings Mechanical Properties"
% Sam Zhang (2010) (ISBN:9781420094022)
% Equation is p.185

% author: david9684@gmail.com

% H: hardness (in GPa)
% E: elastic modulus (in GPa)
% nu: Poisson's coefficient (0 to 0.5)
% beta: angle between the indented surface and the face of the indenter (in
% degrees), comprised between 0° and 37.5°.
% Y: yield strength (in GPa)

close all;

if nargin > 0
    if nu <= 0 || nu > 0.5
        commandwindow;
        warning('Wrong input for the Poisson''s coefficient...');
    end
elseif nargin == 0
    E = 70.5; % in GPa
    nu = 0.18;
    beta = 19.7; % for a Berkovich indenter
    H = 10; % in GPa
end

%% Calculation of reduced modulus
Er = E / (1 - nu^2);

%% Calculation of Y
Y = Er * ((tand(beta)) / (6.57 - (0.054864*beta))) * atanh((1/Er) * ((2*H)/(tand(beta))));

end