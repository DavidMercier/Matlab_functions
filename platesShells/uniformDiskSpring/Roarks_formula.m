%% Roark's formulas
% Conical disk, or Belleville spring
clear all;
clc
close all;

%% Constants definition
% Disk geometry in mm
t = 12; % thickness
h = 17.8; % cone height
a = 225; % outer radius of the middle surface
b = 114; % inner radius of the middle surface
ab_ratio = a/b;

% Disk mechanical properties
E = 220; % elastic modulus in GPa
nu = 0.3; % Poisson's coefficient

% Constants
% See Dubey et al. 2012
M = (6/(pi*log(ab_ratio)))*((ab_ratio-1)/(ab_ratio))^2;
C1 = (6/(pi*log(ab_ratio)))*(((ab_ratio-1)/(log(ab_ratio)))-1);
C2 = (6/(pi*log(ab_ratio)))*((ab_ratio-1)/2);

%% Load and stresses calculations
delta = 0:0.1:10; % deflection in mm

% Load in kN
P = (E.*delta)./((1-(nu^2)).*(M.*a.^2)).*...
    (((h-delta).*(h-(delta./2)).*t)+(t.^3));

%           A
% /--------/   \--------\
%/--------/     \--------\
%        B

% Stress at point A in GPa
sA = (-E.*delta)./((1-(nu^2)).*(M.*a.^2)).*...
    (C1.*(h-(delta./2))+(C2.*t));

% Stress at point B in GPa
sB = (-E.*delta)./((1-(nu^2)).*(M.*a.^2)).*...
    (C1.*(h-(delta./2))-(C2.*t));

%% Plots
figure;
h1 = plot(delta, P, 'r+');
xlabel('Deflection (mm)');
ylabel('Load (kN)');
grid on;

figure;
h2 = plot(P, sA, 'r+');
xlabel('Load (kN)');
ylabel('Stress at point A (GPa)');
grid on;

figure;
h3 = plot(P, sB, 'r+');
xlabel('Load (kN)');
ylabel('Stress at point B (GPa)');
grid on;

set([h1, h2, h3], 'Linewidth', 2);