%% Copyright 2014 MERCIER David
function radius = radiusPlate(E_plate, t_plate, nu_plate, load_Plate, disp, varargin)
%% Function giving the expression of the radius of a circular plate,
% loaded at the center in function of the applied load.

% author: david9684@gmail.com

% See Timoshenko S.P. and Woinowsky-Krieger S., "Theory of plates and
% shells" (1987) - ISBN : 978-0-07-064779-4
% See Chapter 13 - Large deflections of plates

% radius: Radius of the plate in microns
% E_plate: Young's modulus of the plate in GPa
% t_plate: Thickness of the plate in microns
% nu_plate: Poisson's coefficient of the plate
% load_Plate: Applied load in mN
% disp: Deflection of the plate in microns

if nargin < 5
    disp = 1; % in microns
end

if nargin < 4
    load_Plate = 1; % in mN
end

if nargin < 3
    nu_plate = 0.3;
end

if nargin < 2
    t_plate = 1; % in microns
end

if nargin < 1
    E_plate = 80; % in GPa
end

radius = (pi/load_Plate) .* ...
    (((16.*E_plate.*t_plate.^3.*disp)./(12*(1-nu_plate^2)) + ...
    ((191.*E_plate.*t_plate.*disp.^3)./648)))^0.5;

end