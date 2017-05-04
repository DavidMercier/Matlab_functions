%% Copyright 2014 MERCIER David
function HP_parameters = HallPetch(S, d, varargin)
% S: stress = yield stress or hardness in GPa
% d: grain size in micron

% author: david9684@gmail.com

clear all;
clc;
close all;

if nargin < 2
    S = [2.8 1.7]*1e3;
    d = [8 20];
end

xdata_1 = d.^(-0.5);
ydata_1 = S;
xdata_2 = d;
ydata_2 = S;
xlabels{1} = '{\surd}d in m^{-2}'; % Latex interpreter doesn't work...
xlabels{2} = 'Grain size (d) in m';
ylabels{1} = 'Hardness in MPa';
ylabels{2} = 'Hardness in MPa';
minX = 0.1;
maxX = 1;

[ax,hlT,hlS] = plotxx(xdata_1,ydata_1,xdata_2,ydata_2,xlabels,ylabels, ...
    minX, maxX);
axes(ax(1));
xlim([minX, maxX]);
ylim([0, round(1.2*max(ydata_1))]);
grid on;

axes(ax(2));
ylim([0, round(1.2*max(ydata_2))]);
grid on;

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
end

axes(ax(1));
HP_fit_plot = HP_fit(1) + HP_fit(2).*xdata_1;
line(xdata_1, HP_fit_plot);

    function [sse, FittedCurve] = LMS(params)
        FittedCurve = params(1) + (params(2)./sqrt(d));
        residual = FittedCurve - S;
        sse = sum(residual .^ 2);
    end

axes(ax(2));
HP_parameters = HP_fit;

end