%% Copyright 2014 MERCIER David
function RGB = HSV2RGB(HSV, varargin)
%% Function to convert HSV color to RGB color
% RGB for red, green and blue color levels (0..255)
% Hue (H) in degrees (º), saturation (S) and value (V) (0..100%)
% 0 <= H < 360, 0 <= S <= 1 and 0 <= V <= 1

% author: david9684@gmail.com

if nargin < 1
    HSV = [randi(360) rand rand];
end

C = HSV(3) * HSV(2);
X = C * (1 - abs(mod(HSV(1)/60,2) - 1));
m = HSV(3) - C;

if HSV(1) >= 0 && HSV(1) < 60
    R = C; G = X; B = 0;
elseif HSV(1) >= 60 && HSV(1) < 120
    R = X; G = C; B = 0;
elseif HSV(1) >= 120 && HSV(1) < 180
    R = 0; G = C; B = X;
elseif HSV(1) >= 180 && HSV(1) < 240
    R = 0; G = X; B = C;
elseif HSV(1) >= 240 && HSV(1) < 300
    R = X; G = 0; B = C;
elseif HSV(1) >= 300 && HSV(1) < 360
    R = C; G = 0; B = X;
end

RGB = round([(R + m) (G + m) (B + m)]*255);

display(HSV);
display(RGB);

end