%% Copyright 2014 MERCIER David
function Hex = RGB2Hex(RGB, varargin)
%% Function to convert RGB color to Hex color
% RGB for red, green and blue color levels (0..255)
% Hex for 6 digits hex color

% author: d.mercier@mpie.de

if nargin < 1
    RGB = [randi(255) randi(255) randi(255)];
end

Hex_R = dec2base(RGB(1), 16);
Hex_G = dec2base(RGB(2), 16);
Hex_B = dec2base(RGB(3), 16);

Hex = strcat('#', Hex_R, Hex_G, Hex_B);

display(RGB);
display(Hex);

end