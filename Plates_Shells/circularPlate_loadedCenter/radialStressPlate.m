%% Copyright 2014 MERCIER David
function radialStress = radialStressPlate(E_plate, t_plate, r_Plate, disp, varargin)
%% Function giving the expression of the radial tensil stress in the plate
% loaded at the center.

% See Timoshenko S.P. and Woinowsky-Krieger S., "Theory of plates and
% shells" (1987) - ISBN : 978-0-07-064779-4
% See Chapter 13 - Large deflections of plates

% radialStress: Radial tensile stress at the surface of the plate in GPa
% E_plate: Young's modulus of the plate in GPa
% t_plate: Thickness of the plate in microns
% r_Plate: Radius of the plate in microns
% disp: Deflection of the plate in microns

if nargin < 4
    disp = 1; % in microns
end

if nargin < 3
    r_Plate = 1; % in microns
end
if nargin < 2
    t_plate = 1; % in microns
end

if nargin < 1
    E_plate = 80; % in GPa
end

% Constants definition 
% ==> See Table 83 for Poisson's coefficient of the plate equal to 0.3

alphaTimo = 0.357;
betaTimo = 2.198;

radialStress = alphaTimo .* E_plate .* (disp / r_Plate).^2 + ...
    betaTimo .* E_plate .* t_plate .* (disp / r_Plate.^2);

end