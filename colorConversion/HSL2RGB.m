%% Copyright 2014 MERCIER David
function RGB = HSL2RGB(HSL, varargin)
%% Function to convert HSL color to RGB color
% RGB for red, green and blue color levels (0..255)
% Hue (H) in degrees (º), saturation (S) and lightness (L) (0..100%)
% 0 <= H < 360, 0 <= S <= 1 and 0 <= L <= 1

% author: david9684@gmail.com

if nargin < 1
    HSL = [randi(360) rand rand];
end

C = (1 - abs(2*HSL(3) - 1)) * HSL(2);
X = C * (1 - abs(mod(HSL(1)/60,2) - 1));
m = HSL(3) - C/2;

if HSL(1) >= 0 && HSL(1) < 60
    R = C; G = X; B = 0;
elseif HSL(1) >= 60 && HSL(1) < 120
    R = X; G = C; B = 0;
elseif HSL(1) >= 120 && HSL(1) < 180
    R = 0; G = C; B = X;
elseif HSL(1) >= 180 && HSL(1) < 240
    R = 0; G = X; B = C;
elseif HSL(1) >= 240 && HSL(1) < 300
    R = X; G = 0; B = C;
elseif HSL(1) >= 300 && HSL(1) < 360
    R = C; G = 0; B = X;
end

RGB = round([(R + m) (G + m) (B + m)]*255);

display(HSL);
display(RGB);

end