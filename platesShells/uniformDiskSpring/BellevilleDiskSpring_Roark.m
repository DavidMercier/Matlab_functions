%% Roark's formulas
% Conical disk, or Belleville spring
clear all;
clc
close all;

%% Constants definition
% Disk geometry in mm
t = 12; % thickness
h = 18; % cone height
a = 225; % outer radius of the middle surface
b = 114; % inner radius of the middle surface
ab_ratio = a/b;

% Disk mechanical properties
E = [190 210]; % elastic modulus in GPa
nu = 0.3; % Poisson's coefficient

% Constants
% See Dubey et al. 2012
M = (6/(pi*log(ab_ratio)))*((ab_ratio-1)/(ab_ratio))^2;
C1 = (6/(pi*log(ab_ratio)))*(((ab_ratio-1)/(log(ab_ratio)))-1);
C2 = (6/(pi*log(ab_ratio)))*((ab_ratio-1)/2);

%% Load and stresses calculations
delta = 0:0.1:10; % deflection in mm

for ii = 1:length(E)
    % Load in kN
    P(:,ii) = ((E(ii).*delta)./((1-(nu^2)).*(M.*a.^2)).*...
        (((h-delta).*(h-(delta./2)).*t)+(t.^3)))';
    
    %           A
    % /--------/   \--------\
    %/--------/     \--------\
    %        B
    
    % Stress at point A in GPa
    sA(:,ii) = (-E(ii).*delta)./((1-(nu^2)).*(M.*a.^2)).*...
        (C1.*(h-(delta./2))+(C2.*t));
    
    % Stress at point B in GPa
    sB(:,ii) = (-E(ii).*delta)./((1-(nu^2)).*(M.*a.^2)).*...
        (C1.*(h-(delta./2))-(C2.*t));
end
%% Plots
colorPlot = ['r+' 'bx'];

figure;
for ii = 1:length(E)
    h1(ii) = plot(delta, P(:,ii), colorPlot(ii));
    xlabel('Deflection (mm)');
    ylabel('Load (kN)');
    hold on
end
legend(strcat('E=',num2str(E(1)),'GPa'), ...
    strcat('E=',num2str(E(2)),'GPa'));
grid on;

figure;
for ii = 1:length(E)
    h2(ii) = plot(P(:,ii), sA(:,ii), colorPlot(ii));
    xlabel('Load (kN)');
    ylabel('Stress at point A (GPa)');
    hold on
end
legend(strcat('E=',num2str(E(1)),'GPa'), ...
    strcat('E=',num2str(E(2)),'GPa'));
grid on;

figure;
for ii = 1:length(E)
    h3(ii) = plot(P(:,ii), sB(:,ii), colorPlot(ii));
    xlabel('Load (kN)');
    ylabel('Stress at point B (GPa)');
    hold on
end
legend(strcat('E=',num2str(E(1)),'GPa'), ...
    strcat('E=',num2str(E(2)),'GPa'));
grid on;

set([h1, h2, h3], 'Linewidth', 2);