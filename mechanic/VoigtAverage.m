%% Copyright 2014 MERCIER David
function voigtAverage = VoigtAverage(property, volumeFraction, varargin)
%% Function giving the Voigt's average
% From "Mechanical Behavior of Materials", by Meyers M and Chawla K.,
% 2nd edition, 2008.

% author: david9684@gmail.com

if nargin < 2
    volumeFraction = [20 30 50]/100; % in %
end

if nargin < 1
    property = [10 20 30]; % in the unit of the property
end

voigtAverage = sum(volumeFraction .* property);

end