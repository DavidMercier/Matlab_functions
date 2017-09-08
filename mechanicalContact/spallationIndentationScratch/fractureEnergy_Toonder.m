%% Copyright 2014 MERCIER David
function Gamma = fractureEnergy_Toonder(E, nu, t, sigmaRes, a, L, beta, varargin)
%% Calculation of fracture energy from indentation or scratch tests
% From J. den Toonder et al., "Fracture toughness and adhesion energy of
% sol-gel coatings on glass", J. Mater. res., Vol. 17, No 1, Jan 2002.
% The equation to calculate fracture energy from scratch tests is obtained from
% Thouless formulae, which is derived to take into account the curved
% geometry and the residual stress.

% See M.D. Thouless, "An analysis of spalling in the microscratch test",
% Eng. Fracture Mech., 61, 1998, pp. 75-81.
% See also for indentation test, S.J. Bull and E.G. Berasetegui, "An overview
% of the potential of quantitative coating adhesion measurement by scratch
% testing", Tribology Intern., 39, 2009, pp. 99-114.

% Gamma: Fracture energy in J/m2 = 1 N/m = 1Pa.m = 1e-3 GPa.µm = 1e-6 MPa.m

% E: Elastic modulus in GPa
% nu: Poisson's coefficient (0 to 0.5)
% t: Coating thickness in µm
% sigmaRes: residual stress in GPa
% a: Half length of indenter edge in contact with the chip in µm
% L: Chip length in µm
% beta: Angle between radial crack and scratch direction (for scratch test)
% or direction normale to the indenter edge (for indentation test) in
% degrees.

% author: david9684@gmail.com

if nargin < 1
    close all;
    
    % Experimental values obtained for a sol-gel coating.
    E = 20; % in GPa
    nu = 0.3; % Poisson's coefficient
    t = 0:0.1:1; % in µm
    sigmaRes = 0.05; % in GPa
    a = 4; % in µm
    L = 13; % in µm
    beta = 60; % in degrees for a Berkovich indenter during indentation
    gammaVal = fractureEnergy_Toonder(E, nu, t, sigmaRes, a, L, beta);
    figure;
    plot(t, gammaVal, 'b-', 'LineWidth', 2, 'MarkerSize', 10);
    title('Young''s modulus = 20GPa / \nu = 0.3 / a = 4 \mum / L = 13 \mum / \beta = 60° / \sigma_r = 50 MPa', 'Color', [0,0,0], 'FontSize', 14);
    xlabel('Coating thickness (in micron)', 'Color', [0,0,0], 'FontSize', 14);
    ylabel('Fracture energy - \Gamma (in J)', 'Color', [0,0,0], 'FontSize', 14);
    set(gca, 'FontSize', 14);
    grid on;
    ylim([0 1]);
    
    % Experimental values obtained for a sol-gel coating.
    E = 1:1:300; % in GPa
    nu = 0.3; % Poisson's coefficient
    t = 1; % in µm
    sigmaRes = 0.05; % in GPa
    a = 4; % in µm
    L = 13; % in µm
    beta = 60; % in degrees for a Berkovich indenter during indentation
    gammaVal = fractureEnergy_Toonder(E, nu, t, sigmaRes, a, L, beta);
    figure;
    plot(E, gammaVal, 'b-', 'LineWidth', 2, 'MarkerSize', 10);
    title('Coating thickness = 1 \mum / \nu = 0.3 / a = 4 \mum / L = 13 \mum / \beta = 60° / \sigma_r = 50 MPa', 'Color', [0,0,0], 'FontSize', 14);
    xlabel('Young''s modulus (in GPa)', 'Color', [0,0,0], 'FontSize', 14);
    ylabel('Fracture energy - \Gamma (in J)', 'Color', [0,0,0], 'FontSize', 14);
    set(gca, 'FontSize', 14);
    grid on;
    ylim([0 5]);
    
    % Experimental values obtained for a sol-gel coating.
    E = 20; % in GPa
    nu = 0.3; % Poisson's coefficient
    t = 1; % in µm
    sigmaRes = 0:0.05:1; % in GPa
    a = 4; % in µm
    L = 13; % in µm
    beta = 60; % in degrees for a Berkovich indenter during indentation
    gammaVal = fractureEnergy_Toonder(E, nu, t, sigmaRes, a, L, beta);
    figure;
    plot(sigmaRes, gammaVal, 'b-', 'LineWidth', 2, 'MarkerSize', 10);
    title('Young''s modulus = 20GPa / Coating thickness = 1 \mum / \nu = 0.3 / a = 4 \mum / L = 13 \mum / \beta = 60°', 'Color', [0,0,0], 'FontSize', 14);
    xlabel('Residual stress (in GPa)', 'Color', [0,0,0], 'FontSize', 14);
    ylabel('Fracture energy - \Gamma (in J)', 'Color', [0,0,0], 'FontSize', 14);
    set(gca, 'FontSize', 14);
    grid on;
    
    % Experimental values obtained for a sol-gel coating.
    E = 1:1:300; % in GPa
    nu = 0.3; % Poisson's coefficient
    t = 0:0.1:1; % in µm
    sigmaRes = 0.05; % in GPa
    a = 4; % in µm
    L = 13; % in µm
    beta = 60; % in degrees for a Berkovich indenter during indentation
    gammaVal_mat = ones(length(E), length(t));
    for ii = 1:1:length(E)
        for jj = 1:1:length(t)
            gammaVal_mat(ii, jj) = fractureEnergy_Toonder(E(ii), nu, t(jj), sigmaRes, a, L, beta);
        end
    end
    E_mat = E(ones(1,length(t)), :);
    t_mat = t(ones(1,length(E)), :);
    figure;
    surf(E_mat', t_mat, gammaVal_mat);
    title('\nu = 0.3 / a = 4 \mum / L = 13 \mum / \beta = 60° / \sigma_r = 50 MPa', 'Color', [0,0,0], 'FontSize', 14);
    xlabel('Young''s modulus (in GPa)', 'Color', [0,0,0], 'FontSize', 14);
    ylabel('Coating thickness (in micron)', 'Color', [0,0,0], 'FontSize', 14);
    zlabel('Fracture energy - \Gamma (in J)', 'Color', [0,0,0], 'FontSize', 14);
    set(gca, 'FontSize', 14);
    grid on;
    view(-20, 20);
    shading interp;
    
end

X = ((a./L) + ((beta.*pi./180)./2))./((a./L) + (beta.*pi./180));

Gamma = (1.42 .* (E.*(t.^5)./(L.^4)) .* (X).^2 + ...
    ((t.*(1-nu).*(sigmaRes.^2))./E) + ...
    (((3.36.*(1-nu).*(t.^3).*sigmaRes)./(L.^2)).*X)).*1000;

end