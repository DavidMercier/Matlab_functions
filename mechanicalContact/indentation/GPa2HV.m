%% Copyright 2014 MERCIER David
function HV = GPa2HV(nanoHardnessVal, varargin)
%% Function to convert nanohardness (GPa) in Vickers hardness (HV)

% nanoHardnessVal: nanohardness in GPa

% author: david9684@gmail.com

close all;

if nargin == 0
    nanoHardnessVal = 1;
end

HV = 1e3 * nanoHardnessVal / 9.80665;

end