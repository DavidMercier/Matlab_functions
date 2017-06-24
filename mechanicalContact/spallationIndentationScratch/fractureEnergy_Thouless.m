%% Copyright 2014 MERCIER David
function Gamma = fractureEnergy_Thouless(E, t, a, L, beta, varargin)
%% Calculation of fracture energy from indentation or scratch tests
% From M.D. Thouless, "An analysis of spalling in the microscratch test",
% Eng. Fracture Mech., 61, 1998, pp. 75-81.
% This simple equation can be used to calculate fracture energy from
% scratch tests.

% Gamma: Fracture energy in J/m2 = 1 N/m = 1Pa.m = 1e-3 GPa.µm = 1e-6 MPa.m

% E: Elastic modulus in GPa
% t: Coating thickness in µm
% a: Half length of indenter edge in contact with the chip in µm
% L: Chip length in µm
% beta: Angle between radial crack and scratch direction (for scratch test)
% or direction normale to the indenter edge (for indentation test) in
% degrees.

% author: david9684@gmail.com

%close all;

if nargin < 1
    % Experimental values obtained for a sol-gel coating.
    E = 20; % in GPa
    t = 0:0.01:1; % in µm
    a = 4; % in µm
    L = 13; % in µm
    beta = 60; % in degrees for a Berkovich indenter during indentation
    gammaVal = fractureEnergy_Thouless(E, t, a, L, beta);
    figure(1);
    plot(t, gammaVal, 'b-', 'LineWidth', 2, 'MarkerSize', 10);
    title('Young''s modulus = 20 GPa / a = 4 \mum / L = 13 \mum / \beta = 60°');
    xlabel('Coating thickness (in micron)', 'Color', [0,0,0], 'FontSize', 14);
    ylabel('Fracture energy - \Gamma (in J)', 'Color', [0,0,0], 'FontSize', 14);
    set(gca, 'FontSize', 14);
    grid on;
    ylim([0 1]);
    %save_figure(pwd, gca);
    
    % Experimental values obtained for a sol-gel coating.
    E = 1:1:300; % in GPa
    t = 1; % in µm
    a = 4; % in µm
    L = 13; % in µm
    beta = 60; % in degrees for a Berkovich indenter during indentation
    gammaVal = fractureEnergy_Thouless(E, t, a, L, beta);
    figure(2);
    plot(E, gammaVal, 'b-', 'LineWidth', 2, 'MarkerSize', 10);
    title('Coating thickness = 1 \mum / a = 4 \mum / L = 13 \mum / \beta = 60°');
    xlabel('Young''s modulus (in GPa)', 'Color', [0,0,0], 'FontSize', 14);
    ylabel('Fracture energy - \Gamma (in J)', 'Color', [0,0,0], 'FontSize', 14);
    set(gca, 'FontSize', 14);
    grid on;
    ylim([0 5]);
    %save_figure(pwd, gca);
end

X = (tand(beta) + (2*a/L))/(tand(beta) + (a/L));

Gamma = (0.35 * (E*(t.^5)/(L.^4)) * (X).^2)*1000;

end