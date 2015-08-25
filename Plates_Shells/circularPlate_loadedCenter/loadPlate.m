%% Copyright 2014 MERCIER David
function load = loadPlate(E_plate, t_plate, nu_plate, r_Plate, disp, varargin)
%% Function giving the load function for large deflections of circular plates,
% loaded at the center

% author: d.mercier@mpie.de

% See Timoshenko S.P. and Woinowsky-Krieger S., "Theory of plates and
% shells" (1987) - ISBN : 978-0-07-064779-4
% See Chapter 13 - Large deflections of plates

% load: Applied load in mN
% E_plate: Young's modulus of the plate in GPa
% t_plate: Thickness of the plate in microns
% nu_plate: Poisson's coefficient of the plate
% r_Plate: Radius of the plate in microns
% disp: Deflection of the plate in microns

if nargin < 5
    disp = 1; % in microns
end

if nargin < 4
    r_Plate = 1; % in microns
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

load = (pi/r_Plate^2) .* ...
    (((16.*E_plate.*t_plate.^3.*disp)./(12*(1-nu_plate^2)) + ...
    ((191.*E_plate.*t_plate.*disp.^3)./648)));

end