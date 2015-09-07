%% Copyright 2014 MERCIER David
function [true_strain, true_stress] = trueStressStrain(...
    engineering_stress, engineering_strain, varargin)
%% Function giving the true stress-strain curve

% author: d.mercier@mpie.de

if nargin < 2
    engineering_strain = [0 5 10 15 20 25 30 35 40]/100; % in %
end

if nargin < 1
    engineering_stress = [0 35 50 60 65 63 60 55 50]; % in GPa
end

true_strain = log(1 + engineering_strain);

true_stress = engineering_stress .* (1 + engineering_strain);

smoothed_engStress = ...
    smooth(engineering_strain,engineering_stress,2,'lowess');

smoothed_trueStress = ...
    smooth(true_strain,true_stress,2,'lowess');

% Plot
figure;

plot(engineering_strain,engineering_stress,'b+',...
    engineering_strain,smoothed_engStress,'r-');

hold on;

plot(true_strain,true_stress,'ko',...
    true_strain,smoothed_trueStress,'g-');

legend('Engineering Stress-Strain curve','Smoothed engineering data',...
    'Tue Stress-Strain curve','Smoothed true data',...
    'Location','SE');
xlabel('Engineering or true stress (GPa)');
ylabel('Engineering or true strain (%)');

end