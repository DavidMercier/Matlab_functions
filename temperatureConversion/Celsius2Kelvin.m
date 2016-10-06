%% Copyright 2014 MERCIER David
function TK = Celsius2Kelvin(TC, varargin)
%% Function to convert temperature in °C to temperature in K

% author: david9684@gmail.com

% TC: Temperature in °C
% TK: Temperature in K

if nargin < 1
    TC = 25;
end

TK = TC + 273.15;

end