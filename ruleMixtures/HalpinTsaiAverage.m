%% Copyright 2014 MERCIER David
function halpintsaiAverage = HalpinTsaiAverage(propM, propF, volumeFraction, shapeRatio, varargin)
%% Function giving the Halpin- Tsai average
% From F. Akhtar, Canadian Metallurgical Quarterly 2014 VOL 53 NO 3 253

% author: david9684@gmail.com

if nargin < 4
    shapeRatio = 1; % in %
end

if nargin < 3
    volumeFraction = 0.3; % in %
end

if nargin < 2
    propF = 400; % Property of the reinforcement
end

if nargin < 1
    propM = 100; % Property of the matrix
end

q = ((propF./propM)-1) ./ ((propF./propM)+2*shapeRatio); 
halpintsaiAverage = propM .* (1+2*shapeRatio.*q.*volumeFraction) ./ (1-q*volumeFraction);

end