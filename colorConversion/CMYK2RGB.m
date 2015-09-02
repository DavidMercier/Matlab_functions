%% Copyright 2014 MERCIER David
function RGB = CMYK2RGB(CMYK, varargin)
%% Function to convert CMYK color to RGB color
% RGB for red, green and blue color levels (0..255)
% CMYK for cyan, magenta, yellow, black

% author: d.mercier@mpie.de

if nargin < 1
    CMYK = [rand rand rand rand];
end

R = 255 * (1-CMYK(1)) * (1-CMYK(4));
G = 255 * (1-CMYK(2)) * (1-CMYK(4));
B = 255 * (1-CMYK(3)) * (1-CMYK(4));

RGB = round([R G B]);

display(CMYK);
display(RGB);

end