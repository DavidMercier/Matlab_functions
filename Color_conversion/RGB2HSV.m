%% Copyright 2014 MERCIER David
function HSV = RGB2HSV(RGB, varargin)
%% Function to convert HSV color to RGB color
% RGB for red, green and blue color levels (0..255)
% Hue (H) in degrees (º), saturation (S) and value (V) (0..100%)
% 0 <= H < 360, 0 <= S <= 1 and 0 <= V <= 1

% author: d.mercier@mpie.de

if nargin < 1
    RGB = [randi(255) randi(255) randi(255)];
end

R = RGB(1)/255;
G = RGB(2)/255;
B = RGB(3)/255;

Cmax = max([R, G, B]);
Cmin = min([R, G, B]);
Delta = Cmax - Cmin;

if Delta == 0
    H = 0;
elseif Cmax == R;
    H = 60*(mod(((G-B)/Delta),6));
elseif Cmax == G;
    H = 60*(((B-R)/Delta) + 2);
elseif Cmax == B;
    H = 60*(((R-G)/Delta) + 4);
end

V = Cmax;

if Delta == 0
    S = 0;
else
    S = Delta / Cmax;
end

HSV = [H S*100 V*100];

display(RGB);
display(HSV);

end