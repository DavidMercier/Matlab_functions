%% Copyright 2014 MERCIER David
function TK = Fahrenheit2Kelvin(TF, varargin)
%% Function to convert temperature in °F to temperature in K

% author: d.mercier@mpie.de

% TF: Temperature in °F
% TK: Temperature in K

if nargin < 1
    TF = 68;
end

TK = 273.15 + (TF - 32) / 1.8;

end