%% Copyright 2014 MERCIER David
function [ptc, handle_indax]  = preCPFE_3d_Berkovich_indenter(X_position, Y_position, Z_position, szFac, rotation_angle, varargin)
%% Function to plot a 3D Berkovich indenter
% X_position, Y_position, Z_position : Coordinates of the center of the indenter.
% szFac: Factor to scale indenter size.
% rotation_angle: Rotation angle of the 3D plot (from 0 to 360°) in degrees.

% author: d.mercier@mpie.de

if nargin < 5
    rotation_angle = 0; % in degrees
end

if nargin < 4
    szFac = 1;
end

if nargin < 3
    Z_position = 0;
end

if nargin < 2
    Y_position = 0;
end

if nargin < 1
    X_position = 0;
end

%% Plot of the Berkovich indenter
%
% Geometry of Berkovich indenter
% See A.C. Fischer-Cripps "Nanoindentation" - Springer 2nd Ed. (2004)
% It is a three-sided pyramid which is geometrically self-similar.
% The full angle at the apex is 142.3 degrees (from a ridge to a face) 
% and the half angle of the central axis to one of the pyramid flats is 65.35 degrees. 
% The equivalent cone angle is 70.32°.
% --> Scheme not scaled = cross section view
%
%   y2 = y3                     y1
%<--------------><------------------------------->
%-------------------------------------------------
%\               |                              /^
% \              |                            /  |
%  \             |                          /    |
%   \            |                        /      |
%    \           |                      /        |
%     \   angle  |                    /          |
%      \  theta  |    angle         /            |
%       \        |    alpha       /              |
%        \ 65.3° |              /                |  z1 = z2 = z3
%         \      |     77°    /                  |
%          \     |          /                    |
%           \    |        /                      |
%     25°    \   |      /   13°                  |
%             \  |    /                          |
%              \ |  /                            |
%               \|/     Surface of the sample    v
%---------------------------------------------------
%

theta = 65.3; % in degrees
alpha = 77; % in degrees
gamma = 30; % half angle of a corner of an isoscele triangle (top view of the Berkovich indenter)

x_ori = X_position;
y_ori = Y_position;
z_ori = Z_position;

z1 = 1.5 * szFac;
y1 = z1 * tand(alpha);
x1 = 0;

z2 = z1;
y2 = -(z1 * tand(theta));
x2 = y2 / tand(gamma);

z3 = z1;
y3 = y2;
x3 = -x2;

z1 = z1 + Z_position;
z2 = z2 + Z_position;
z3 = z3 + Z_position;

topo.X = [x1, x2, x3];
topo.Y = [y1, y2, y3];
topo.X_ori = topo.X;
topo.Y_ori = topo.Y;

topo = preCPFE_xy_rotation_3d_object(topo, rotation_angle);

x1 = topo.X(1);
x2 = topo.X(2);
x3 = topo.X(3);
y1 = topo.Y(1);
y2 = topo.Y(2);
y3 = topo.Y(3);

vts = [x_ori y_ori z_ori;...
    x1 y1 z1;...
    x2 y2 z2;...
    x3 y3 z3];

fcs = [1 2 3; ...
    1 3 4;...
    1 4 2;...
    2 3 4];

ptc = struct();
ptc.vertices = vts;
ptc.faces = fcs;
handle_indax = patch(ptc, 'FaceColor', 'w', 'FaceAlpha', 0.75);

if nargin == 0
    close all;
    patch(ptc, 'FaceColor', 'r', 'FaceAlpha', 0.75);
    rotate3d on;
    axis off;
    axis equal;
    view(0,0);
    hold on
    preCPFE_3d_polygon_indenter
end

end