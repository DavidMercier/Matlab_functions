%% Copyright 2014 MERCIER David
function reussAverage = ReussAverage(property, volumeFraction, varargin)
%% Function giving the Reuss's average
% From "Mechanical Behavior of Materials", by Meyers M and Chawla K.,
% 2nd edition, 2008.

% author: david9684@gmail.com

if nargin < 1
    property = [10 20 30]; % in the unit of the property
end

if nargin < 2
    l_p = length(property);
    r = rand(1, l_p);
    volumeFraction = r / sum(r); % in % 
end

disp(property);
disp(volumeFraction);
reussAverage = (sum(volumeFraction ./ property))^(-1);

end