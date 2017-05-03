%% Copyright 2014 MERCIER David
function HP_parameters = HallPetch(S, d, varargin)
% S: stress = yield stress or hardness in GPa
% d: grain size in micron

% author: david9684@gmail.com

clear all;
clc;
close all;

if nargin < 2
    S = [2.8 1.7 1.5]*1e3;
    d = [7 20 30];
end

xdata = d.^(-0.5);
ydata = S;

figure;
plot(xdata, ydata, '+r');
xlabel('{\surd}d in m^{-2}'); % Latex interpreter doesn't work...
ylabel('Hardness in MPa');
xlim([0, 1.2*max(xdata)]);
ylim([0, 1.2*max(ydata)]);
grid on;
hold on;

% ax1 = gca; % current axes
% ax1_pos = get(ax1,'Position');
% ax2 = axes('Position',ax1_pos,...
%     'XAxisLocation','top',...
%     'YAxisLocation','right',...
%     'Color','none');

HP_model = @(S, d) S - HP(1) - (HP(2)./sqrt(d));

% Make a starting guess
HP_guess(1) = S(1);
HP_guess(2) = 10;

if license('test','Optimization_Toolbox')
    [HP_fit, ...
        resnorm, ...
        residual, ...
        exitflag, ...
        output, ...
        lambda, ...
        jacobian] =...
        lsqcurvefit(HP_model, HP, d, S);
else
    model = @LMS;
    HP_fit = fminsearch(model, HP_guess);
    warning('No Optimization toolbox available !');
    HP_fit_plot = HP_fit(1) + HP_fit(2).*xdata;
    line(xdata, HP_fit_plot);
end

    function [sse, FittedCurve] = LMS(params)
        FittedCurve = params(1) + (params(2)./sqrt(d));
        residual = FittedCurve - S;
        sse = sum(residual .^ 2);
    end

HP_parameters = HP_fit;

end