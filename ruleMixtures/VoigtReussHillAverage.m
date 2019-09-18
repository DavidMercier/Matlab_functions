%% Copyright 2014 MERCIER David
function voigtReussHillAverage = VoigtReussHillAverage(property, volumeFraction, varargin)
%% Function giving the Voigt-Reuss-Hill's average

% author: david9684@gmail.com

if nargin < 2
    volumeFraction = [20 30 50]/100; % in %
end

if nargin < 1
    property = [10 20 30]; % in the unit of the property
end

voigtAverage = sum(volumeFraction .* property);
reussAverage = (sum(volumeFraction ./ property))^(-1);

voigtReussHillAverage = (voigtAverage+reussAverage)/2;

end