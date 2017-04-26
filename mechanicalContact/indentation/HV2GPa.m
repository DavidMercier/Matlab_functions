%% Copyright 2014 MERCIER David
function nanoHardnessVal = HV2GPa(HV, varargin)
%% Stress distributions at the surface and along the axis of symmetry
%% Function to convert Vickers hardness (HV) in nanohardness (GPa)

% HV: Vickers hardness (HV)

% author: david9684@gmail.com

close all;

if nargin == 0
    HV = 100;
end

nanoHardnessVal = 1e-3 * HV * 9.80665;

end