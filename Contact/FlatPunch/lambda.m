%% Copyright 2014 MERCIER David
function lambdaFit = lambda(Esub, Eind, varargin)
%% Function giving the value of the lambda parameter in function of the
% ratio between Young's modulus of a substrate and Young's modulus of the
% indenter, in the case of substrate indentation with a flat punch

% author: d.mercier@mpie.de

% See PhD thesis of Diop M.D., "Contribution à l'étude mécanique et électrique
% du contact localisé : Adaptation de la nanoindentation à la microinsertion." (2009).
% ... and see Jordan E. H. et Urban M. R. (1999) - DOI: 10.1016/S0043-1648(99)00284-7

% Esub: Young's modulus of the substrate in GPa
% Eind: Young's modulus of the indenter in GPa
% lambdaValue: Value of the adimensional parameter lambda

if nargin < 2
    Eind = 261; % in GPa
end

if nargin < 1
    Esub = 53; % in GPa
end

Eratio = Eind/Esub;

lambdaModel = @(lambdaValue) ...
    tan(pi*(1-lambdaValue)) * sin(pi*(1-lambdaValue)) + ...
    Eratio * (1-cos(pi*(1-lambdaValue))-2*(1-lambdaValue)^2);

lambdaValue0 = 0.25;

options = optimoptions('fsolve', ...
    'TolFun',1e-12, 'TolX',1e-12, 'MaxIter', 1000);
%'Display','iter'

lambdaFit = fzero(lambdaModel,lambdaValue0,options);

% if nargin == 0
%     Eind = 0:0.1:60;
%     Esub = 1;
%     Eratio = Eind/Esub;
%     for ii = 1:length(Eind)
%         lambdaFit(ii) = lambda(Esub, Eind(ii));
%     end
%     plot(Eratio, lambdaFit);
%     xlabel('Eind/Esub');
%     ylabel('\lambda');
%     ylim([0 0.5]);
% end

end