%% Copyright 2014 MERCIER David
function [E_homo, nu_homo] = MT_homoScheme(modulusMatrix, modulusParticle, ...
    coeffPoissonMatrix, coeffPoissonParticle, volFracParticle, varargin)
%% Function to apply Mori-Tanaka homogenization scheme
% From J. Nemecek, Habilitation thesis, "Nanoindentation of Heterogeneous
% Structural Materials", 2009.

% author: david.mercier@crmgroup.be
% volFracParticle: Volume fraction of particles (= 1 - volFracMatrix)
% modulusMatrix: Elastic modulus of the matrix (in GPa)
% modulusParticle: Elastic modulus of the particles (in GPa)
% coeffPoissonMatrix: Poisson's coefficient of the matrix
% coeffPoissonParticle: Poisson's coefficient of the particles

if nargin < 5
    volFracParticle = 0.294; % in %
    modulusMatrix = 20.09; % in GPa
    modulusParticle = 33.93; % in GPa
    coeffPoissonMatrix = 0.2;
    coeffPoissonParticle = 0.2;
end

global vf_M vf_P Km Kp Gm Gp

% Calculations of volume fraction
vf_M = 1 - volFracParticle;
vf_P = volFracParticle;

% Calculations of bulk and shear modulus of the matrix (Km and Gm) and the
% particles (Kp and Gp)
Km = modulusMatrix/(3*(1-(2*coeffPoissonMatrix)));
Kp = modulusParticle/(3*(1-(2*coeffPoissonParticle)));
Gm = modulusMatrix/(2*(1+coeffPoissonMatrix));
Gp = modulusParticle/(2*(1+coeffPoissonParticle));

%% Mori-Tanaka homogenization scheme
OPTIONS = optimset('fminsearch');
OPTIONS = optimset(OPTIONS, 'Display','iter');
OPTIONS = optimset(OPTIONS, 'MaxFunEvals', 1000);
OPTIONS = optimset(OPTIONS, 'TolFun', 1e-8);
OPTIONS = optimset(OPTIONS, 'TolX', 1e-4);

x0 = [(Km+Kp)/2 ; (Gm+Gp)/2];
[Kval, fval] = fminsearch(@MoriTanakaModel_K_homo, x0, OPTIONS)
[Gval, fval] = fminsearch(@MoriTanakaModel_G_homo, x0, OPTIONS)
%[Gval, fval] = fminsearch(@(x)(MoriTanakaModel_G_homo( abs(x) ) ), x0, OPTIONS)

% if Gp > Gm
%     ub = Kp;
% else
%     ub = Km;
% end
% [Kval, fval] = fmincon(@MoriTanakaModel_K_homo, x0, [],[],[],[],0,ub)
% if Gp > Gm
%     ub = Gp;
% else
%     ub = Gm;
% end
% [Kval, fval] = fmincon(@MoriTanakaModel_G_homo, x0, [],[],[],[],0,ub)

K_homo = Kval(1);
G_homo = Kval(2);

%% Homogenized Young's modulus and Poisson's ratio
E_homo = (9*K_homo*G_homo) / ((3*K_homo) + G_homo);
nu_homo = ((3*K_homo) - (2*G_homo)) / ((6*K_homo) + (2*G_homo));

    function K = MoriTanakaModel_K_homo(x)
        if x(1) < 0 || x(2) < 0 % check if there is any negative number in input variable
            K = 1e10000;    % give a big value to the result
            return;            % return to fminsearch - do not execute the rest of the code
        end
        if x(1) > 1e10 || x(2) > 1e10 % check if there is any negative number in input variable
            K = 1e10000;    % give a big value to the result
            return;            % return to fminsearch - do not execute the rest of the code
        end
        K = ((vf_P * Kp)*(1+(3*x(1))/((3*x(1)) + (4*x(2)))*((Kp/Km)-1))^(-1)) / (vf_P*(1+(3*x(1))/((3*x(1)) + (4*x(2)))*((Kp/Km)-1))^(-1)) - x(1);
    end
    function G = MoriTanakaModel_G_homo(x)
        if x(1) < 0 || x(2) < 0 % check if there is any negative number in input variable
            G = 1e10000;    % give a big value to the result
            return;            % return to fminsearch - do not execute the rest of the code
        end
        if x(1) > 100 || x(2) > 100 % check if there is any negative number in input variable
            G = 1e10000;    % give a big value to the result
            return;            % return to fminsearch - do not execute the rest of the code
        end
        G = ((vf_P * Gp)*(1+((6*x(1)) + (12*x(2)))/((15*x(1)) + (20*x(2)))*((Gp/Gm)-1))^(-1)) / (vf_P*(1+((6*x(1)) + (12*x(2)))/((15*x(1)) + (20*x(2)))*((Gp/Gm)-1))^(-1)) - x(2);
    end

end