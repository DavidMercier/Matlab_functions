%% Copyright 2014 MERCIER David
function HV = VickersHardness(load, diam)
%% Function to calculate Vickers hardness (HV)

% load: applied load in kgf (1kgf = 9.80665 N)
% diam: mean diameter in mm

% author: david9684@gmail.com

close all;

HV = 2*sind(136/2) * load / (diam^2);

end