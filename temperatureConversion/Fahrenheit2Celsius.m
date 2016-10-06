%% Copyright 2014 MERCIER David
function TC = Fahrenheit2Celsius(TF, varargin)
%% Function to convert temperature in °C to temperature in °F

% author: david9684@gmail.com

% TC: Temperature in °C
% TF: Temperature in °F

if nargin < 1
    TF = 20;
end

TC = (TF - 32) / 1.8;

end