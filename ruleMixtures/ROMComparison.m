%% Copyright 2014 MERCIER David
%% Script to compare rules of mixtures
% From "Mechanical Behavior of Materials", by Meyers M and Chawla K.,
% 2nd edition, 2008.
% From F. Akhtar, Canadian Metallurgical Quarterly 2014 VOL 53 NO 3 253

% author: david9684@gmail.com

clear all; cla; clf;
volumeFraction = 0:0.005:1;
Em = 100;
Ef = 400;
E = 0:0.5:100;

voigtAverage = volumeFraction(:) .* Ef + (1-volumeFraction(:)) .* Em;
reussAverage = ((volumeFraction(:) ./ Ef) + ((1-volumeFraction(:)) ./ Em)).^(-1);
voigtReussHillAverage = (voigtAverage+reussAverage)./2;

s = 1;
q = ((Ef./Em)-1) ./ ((Ef./Em)+2*s); 
HT = Em .* (1+2*s.*q.*volumeFraction) ./ (1-q*volumeFraction);

s = 5;
q = ((Ef./Em)-1) ./ ((Ef./Em)+2*s); 
HT2 = Em .* (1+2*s.*q.*volumeFraction) ./ (1-q*volumeFraction);

line('XData',volumeFraction,'YData',voigtAverage','Color','red','LineWidth',3); hold on;
line('XData',volumeFraction,'YData',reussAverage','Color','blue','LineWidth',3, 'Linestyle','-.'); hold on;
line('XData',volumeFraction,'YData',voigtReussHillAverage','Color','black','LineWidth',3, 'Linestyle',':');
line('XData',volumeFraction,'YData',HT','Color','Green','LineWidth',3);%, 'Linestyle',':'
line('XData',volumeFraction,'YData',HT2','Color','Magenta','LineWidth',3, 'Linestyle',':');
legend('Voigt', 'Reuss', 'Voigt-Reuss-Hill', 'Halpin-Tsai s=1','Halpin-Tsai s=5','Location','northwest');
xlabel('Fraction volumique des renforcements');
ylabel('Module d''Young (GPa)');
grid on;