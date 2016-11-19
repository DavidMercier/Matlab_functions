%% Copyright 2014 MERCIER David
function abaque_FP
%% Function giving the mean pressure below a circular flat punch in function of applied load

% author: david9684@gmail.com

diameterFlatPunch = 0:1:250; % Flat punch diameter in micron
  
applied_Load = 0:0.005:0.5; % Applied lod in N

contactArea = pi * (((diameterFlatPunch/2) * 1e-6).^2); % Contact area in m²

[X, Y] = meshgrid(applied_Load, contactArea);
mean_Pressure = 1e-9 * (X ./ Y); % Mean pressure in GPa

A = axes;
surf(X,Y,mean_Pressure);
set(A,'ZScale','log');
xlabel('Applied load in N');
ylabel('Contact area in m²');
zlabel('Mean pressure in GPa');

end