%% Copyright 2014 MERCIER David
function RGB = Hex2RGB(Hex, varargin)
%% Function to convert Hex color to RGB color
% RGB for red, green and blue color levels (0..255)
% Hex for 6 digits hex color

% author: d.mercier@mpie.de

if nargin < 1
    Hex = RGB2Hex;
end

RGB(1) = base2dec(Hex(2:3), 16);
RGB(2) = base2dec(Hex(4:5), 16);
RGB(3) = base2dec(Hex(6:7), 16);

display(RGB);
display(Hex);

end