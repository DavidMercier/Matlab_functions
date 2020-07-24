%% Copyright 2014 MERCIER David
function voigtReussHillAverage = VoigtReussHillAverage(property, volumeFraction, varargin)
%% Function giving the Voigt-Reuss-Hill's average

% author: david9684@gmail.com

if nargin < 1
    property = [10 20 30]; % in the unit of the property
end

if nargin < 2
    l_p = length(property);
    r = rand(1, l_p);
    volumeFraction = r / sum(r); % in % 
end

voigtAverage = sum(volumeFraction .* property);
reussAverage = (sum(volumeFraction ./ property))^(-1);

disp(property);
disp(volumeFraction);
voigtReussHillAverage = (voigtAverage+reussAverage)/2;

end