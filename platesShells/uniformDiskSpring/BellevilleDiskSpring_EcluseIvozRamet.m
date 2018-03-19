function results = BellevilleDiskSpring_EcluseIvozRamet(t, t1, h, a, b, ...
    E, nu, varargin)
%% Stress distribution for a conical disk, or Belleville spring
% See Schnorr - Handbook for disc springs
close all
clc

results = struct();

%% Constants definition
if nargin == 0
    % Disk geometry in mm
    t = 12; % Disk thickness
    t1 = 12; % Reduced spring thickness for springs with contact flats
    h = 18; % Cone height
    a = 225; % Outer radius of the middle surface
    b = 112; % Inner radius of the middle surface
    
    % Disk mechanical properties
    % Material: 1.4923 (X 22 CrMoV 12 1) 
    E = [180 210]; % Elastic modulus in GPa
    nu = 0.3; % Poisson's coefficient  
end

%% Calculation of constants
ab = a/b;
h0 = h-t; % Cone height of an unloaded single spring
h1 = h-t1; % Cone height of an unloaded spring with reduced thickness t1

C1 = ((t1/t)^2) / ((0.25*(h/t)-(t1/t)+0.75)*((5/8)*(h/t)-(t1/t)+3/8));

C2 = (C1/(t1/t)^3) * (((5/32)*((h/t)-1)^2) + 1);

K1 = (1/pi)*(((ab-1)/(ab))^2)/...
    (((ab+1)/(ab-1))-(2/(log(ab))));

K2 = (6/pi)*(((ab-1)/log(ab))-1)/(log(ab));

K3 = (3/pi)*((ab-1)/log(ab));

K4 = ((-C1/2)+(((C1/2)^2)+C2)^(0.5))^(0.5);

%% Load and stresses calculations
if h0 < 1
    deltaBin = 0.01;
else
    deltaBin = 0.1;
end
delta = 0:deltaBin:h0; % Deflection in mm

P = zeros(length(delta),length(E));
sA = zeros(length(delta),length(E));
sB = zeros(length(delta),length(E));
sC = zeros(length(delta),length(E));
sD = zeros(length(delta),length(E));
sOM = zeros(length(delta),length(E));

for ii = 1:length(E)
    % Load in kN
    P(:,ii) = ((4.*E(ii))./(1-(nu^2))).*((t^4)./(K1.*a^2)).*(delta./t).*...
        ((((h0./t)-(delta./t)).*((h0./t)-(delta./(2.*t))))+1);
    
    %   D   OM    A
    %   /--------/   \--------\
    %  /--------/     \--------\
    % C        B
    
    % Stress at point A in GPa
    sA(:,ii) = -((4.*E(ii))./(1-(nu^2))).*((t^2)./(K1.*a^2)).*K4.*...
        (delta./t).*(K4.*K2.*((h0./t)-(delta./(2.*t)))+K3);
    
    % Stress at point B in GPa
    sB(:,ii) = -((4.*E(ii))./(1-(nu^2))).*((t^2)./(K1.*a^2)).*K4.*...
        (delta./t).*(K4.*K2.*((h0./t)-(delta./(2.*t)))-K3);
    
    % Stress at point C in GPa
    sC(:,ii) = -((4.*E(ii))./(1-(nu^2))).*((t^2)./(K1.*a^2)).*K4.*...
        (delta./(ab.*t)).*(K4.*(K2-2.*K3).*((h0./t)-(delta./(2.*t)))-K3);
    
    % Stress at point D in GPa
    sD(:,ii) = -((4.*E(ii))./(1-(nu^2))).*((t^2)./(K1.*a^2)).*K4.*...
        (delta./(ab.*t)).*(K4.*(K2-2.*K3).*((h0./t)-(delta./(2.*t)))+K3);
    
    % Stress at point OM in GPa
    sOM(:,ii) = ((4.*E(ii))./(1-(nu^2))).*((t^2)./(K1.*a^2)).*K4.*...
        (delta./t).*(3/pi);
    
    results.deflection = delta;
    results.P = P;
    results.sA = sA;
    results.sB = sB;
    results.sC = sC;
    results.sD = sD;
    results.sOM = sOM;
end

%% Plots
colorPlot = ['r+' 'bx'];
h1 = zeros(1,length(E));
h2 = zeros(1,length(E));
h3 = zeros(1,length(E));
h4 = zeros(1,length(E));
h5 = zeros(1,length(E));
h6 = zeros(1,length(E));

txtLeg = cell(length(E),1);
for ii = 1:length(E)
    if length(num2str(E(ii))) == 3
        txtLeg{ii} = strcat('E=',num2str(E(ii)),'GPa');
    elseif length(num2str(E(ii))) == 2
        txtLeg{ii} = strcat('E=0',num2str(E(ii)),'GPa');
    end
end
txtLeg{3} = 'Compression test #1';
txtLeg{4} = 'Compression test #2';

loadLab = 'Load (kN)';

figure;
for ii = 1:length(E)
    h1(ii) = plot(delta, P(:,ii), colorPlot(ii));
    xlabel('Deflection (mm)');
    ylabel(loadLab);
    hold on
end
%h_comp(1) = plot([4.38 4.43],[170 170],'kx');
h_comp(1) = plot([4.38 4.38],[0 250],'k-');
h_comp(7) = plot([4.43 4.43],[0 250],'k--');
h_comp(8) = plot([0 h0],[170 170],'k-.');
hl1 = legend(txtLeg);
xlim([0 h0]);
ylim([0 250]);
grid on;

txtLeg{3} = 'Compression tests';

figure;
for ii = 1:length(E)
    h2(ii) = plot(P(:,ii), sA(:,ii), colorPlot(ii));
    xlabel(loadLab);
    ylabel('Stress at point A (GPa)');
    hold on
end
h_comp(2) = plot([170 170],[-10 10],'k--');
hl2 = legend(txtLeg);
xlim([0 250]);
ylim([-4 0]);
grid on;

figure;
for ii = 1:length(E)
    h3(ii) = plot(P(:,ii), sB(:,ii), colorPlot(ii));
    xlabel(loadLab);
    ylabel('Stress at point B (GPa)');
    hold on
end
h_comp(3) = plot([170 170],[-10 10],'k--');
hl3 = legend(txtLeg);
xlim([0 250]);
ylim([0 2]);
grid on;

figure;
for ii = 1:length(E)
    h4(ii) = plot(P(:,ii), sC(:,ii), colorPlot(ii));
    xlabel(loadLab);
    ylabel('Stress at point C (GPa)');
    hold on
end
h_comp(4) = plot([170 170],[-10 10],'k--');
hl4 = legend(txtLeg);
xlim([0 250]);
ylim([0 2]);
grid on;

figure;
for ii = 1:length(E)
    h5(ii) = plot(P(:,ii), sD(:,ii), colorPlot(ii));
    xlabel(loadLab);
    ylabel('Stress at point D (GPa)');
    hold on
end
h_comp(5) = plot([170 170],[-10 10],'k--');
hl5 = legend(txtLeg);
xlim([0 250]);
ylim([-2 0]);
grid on;

figure;
for ii = 1:length(E)
    h6(ii) = plot(P(:,ii), sOM(:,ii), colorPlot(ii));
    xlabel(loadLab);
    ylabel('Stress at point OM (GPa)');
    hold on
end
h_comp(6) = plot([170 170],[-10 10],'k--');
hl6 = legend(txtLeg);
xlim([0 250]);
ylim([0 2]);
grid on;

set([h1, h2, h3, h4, h5, h6, h_comp], 'Linewidth', 2);
set([hl1, hl3, hl4, hl6], 'Location', 'northwest');
set([hl2, hl5], 'Location', 'southwest');
end