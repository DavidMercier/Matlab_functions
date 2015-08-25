%% Copyright 2014 MERCIER David
function CMYK = RGB2CMYK(RGB, varargin)
%% Function to convert RGB color to CMYK color
% RGB for red, green and blue color levels (0..255)
% CMYK for cyan, magenta, yellow, black

% author: d.mercier@mpie.de

if nargin < 1
    RGB = [randi(255) randi(255) randi(255)];
end

R = RGB(1)/255;
G = RGB(2)/255;
B = RGB(3)/255;

K = 1- max(RGB/255);

C = (1-R-K) / (1-K);

M = (1-G-K) / (1-K);

Y = (1-B-K) / (1-K);

CMYK = [C M Y K];

display(RGB);
display(CMYK);

end