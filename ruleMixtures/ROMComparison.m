%% Copyright 2014 MERCIER David
%% Script to compare rules of mixtures
% From "Mechanical Behavior of Materials", by Meyers M and Chawla K.,
% 2nd edition, 2008.

% author: david9684@gmail.com

clear all; cla; clf;
volumeFraction = 0:0.005:1;
Em = 100;
Ef = 400;
E = 0:0.5:100;

voigtAverage = volumeFraction(:) .* Ef + (1-volumeFraction(:)) .* Em;
reussAverage = ((volumeFraction(:) ./ Ef) + ((1-volumeFraction(:)) ./ Em)).^(-1);
voigtReussHillAverage = (voigtAverage+reussAverage)./2;

line('XData',volumeFraction,'YData',voigtAverage','Color','red','LineWidth',3); hold on;
line('XData',volumeFraction,'YData',reussAverage','Color','blue','LineWidth',3, 'Linestyle','-.'); hold on;
line('XData',volumeFraction,'YData',voigtReussHillAverage','Color','black','LineWidth',3, 'Linestyle',':');
legend('Voigt', 'Reuss', 'Voigt-Reuss-Hill','Location','northwest');
xlabel('Fraction volumique des renforcements');
ylabel('Module d''Young (GPa)');
grid on;