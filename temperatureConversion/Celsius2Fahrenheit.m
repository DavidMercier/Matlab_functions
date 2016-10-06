%% Copyright 2014 MERCIER David
function TF = Celsius2Fahrenheit(TC, varargin)
%% Function to convert temperature in °C to temperature in °F

% author: david9684@gmail.com

% TC: Temperature in °C
% TF: Temperature in °F

if nargin < 1
    TC = 20;
end

TF = 32 + 1.8*TC;

end