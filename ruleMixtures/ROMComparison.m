%% Copyright 2014 MERCIER David
%% Script to compare rules of mixtures
% From "Mechanical Behavior of Materials", by Meyers M and Chawla K.,
% 2nd edition, 2008.
% From F. Akhtar, Canadian Metallurgical Quarterly 2014 VOL 53 NO 3 253
% From S._Y. Fu, Composites: Part B 39 (2008) 933–961

% author: david9684@gmail.com

clear all; close all;

%% Inputs definition
vF = 0:0.005:1; % Volume fraction of the reinforcement
propM = 100; % Property of the matrix
propF = 400; % Property of the reinforcement

%% Models
% Voigt / Reuss / Voigt-Reuss-Hill models
voigtAverage = vF(:) .* propF + (1-vF(:)) .* propM;
reussAverage = ((vF(:) ./ propF) + ((1-vF(:)) ./ propM)).^(-1);
voigtReussHillAverage = (voigtAverage+reussAverage)./2;

% Halpin-Tsai model
s_min = 1; % aspect ratio of the reinforcements
q = ((propF./propM)-1) ./ ((propF./propM)+2*s_min); 
HT_min = propM .* (1+2*s_min.*q.*vF) ./ (1-q*vF);

s_max = 5; % aspect ratio of the reinforcements
q = ((propF./propM)-1) ./ ((propF./propM)+2*s_max); 
HT_max = propM .* (1+2*s_max.*q.*vF) ./ (1-q*vF);

% Mooney model
s_min = 1; % crowding factor for the ratio of the apparentvolume occupied by the particle to its own true volume
Mooney_min = propM .* exp((2.5.*vF)./(1-(s_min.*vF)));

s_max = 2; % crowding factor for the ratio of the apparentvolume occupied by the particle to its own true volume
Mooney_max = propM .* exp((2.5.*vF)./(1-(s_max.*vF)));

% Mooney model (non-spherical particles)
s_min = 1; % crowding factor for the ratio of the apparentvolume occupied by the particle to its own true volume
P_min = 1; % aspect ratio of the particle 
Mooney2_min = propM .* exp((2.5.*vF + 0.407.*(P_min-1).^(1.508) .* vF)./(1-(s_min.*vF)));

s_mean = 1.5; % crowding factor for the ratio of the apparentvolume occupied by the particle to its own true volume
P_mean = 7.5; % aspect ratio of the particle 
Mooney2_mean = propM .* exp((2.5.*vF + 0.407.*(P_mean-1).^(1.508) .* vF)./(1-(s_mean.*vF)));

s_max = 2; % crowding factor for the ratio of the apparentvolume occupied by the particle to its own true volume
P_max = 15; % aspect ratio of the particle 
Mooney2_max = propM .* exp((2.5.*vF + 0.407.*(P_max-1).^(1.508) .* vF)./(1-(s_max.*vF)));

%% Plots
% Plots with Halpin-Tsai model
figure;
line('XData',vF,'YData',voigtAverage','Color','red','LineWidth',3); hold on;
line('XData',vF,'YData',reussAverage','Color','blue','LineWidth',3, 'Linestyle','-.'); hold on;
line('XData',vF,'YData',voigtReussHillAverage','Color','black','LineWidth',3, 'Linestyle',':');
line('XData',vF,'YData',HT_min','Color','Green','LineWidth',3);%, 'Linestyle',':'
line('XData',vF,'YData',HT_max','Color','Magenta','LineWidth',3, 'Linestyle',':');
legend('Voigt', 'Reuss', 'Voigt-Reuss-Hill', 'Halpin-Tsai s=1','Halpin-Tsai s=5','Location','northwest');
xlabel('Reinforcement volume fraction');
ylabel('Composite property');
ylim([propM propF])
grid on;

% Plots with Mooney model
figure;
line('XData',vF,'YData',voigtAverage','Color','red','LineWidth',3); hold on;
line('XData',vF,'YData',reussAverage','Color','blue','LineWidth',3, 'Linestyle','-.'); hold on;
line('XData',vF,'YData',voigtReussHillAverage','Color','black','LineWidth',3, 'Linestyle',':');
line('XData',vF,'YData',Mooney_min','Color','Green','LineWidth',3);%, 'Linestyle',':'
line('XData',vF,'YData',Mooney_max','Color','Magenta','LineWidth',3, 'Linestyle',':');
legend('Voigt', 'Reuss', 'Voigt-Reuss-Hill', 'Mooney s=1','Mooney s=2','Location','southeast');
xlabel('Reinforcement volume fraction');
ylabel('Composite property');
ylim([propM propF])
grid on;

% Plots with Mooney model (non-spherical particles)
figure;
line('XData',vF,'YData',voigtAverage','Color','red','LineWidth',3); hold on;
line('XData',vF,'YData',reussAverage','Color','blue','LineWidth',3, 'Linestyle','-.'); hold on;
line('XData',vF,'YData',voigtReussHillAverage','Color','black','LineWidth',3, 'Linestyle',':');
line('XData',vF,'YData',Mooney2_min','Color','Green','LineWidth',3);%, 'Linestyle',':'
line('XData',vF,'YData',Mooney2_max','Color','Magenta','LineWidth',3, 'Linestyle',':');
line('XData',vF,'YData',Mooney2_mean','Color','Yellow','LineWidth',3, 'Linestyle','-');
legend('Voigt', 'Reuss', 'Voigt-Reuss-Hill', 'Mooney s=1 p=1','Mooney s=2 p=15','Mooney s=1.5 p=7.5', 'Location','southeast');
xlabel('Reinforcement volume fraction');
ylabel('Composite property');
ylim([propM propF])
grid on;