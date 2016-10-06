%% Copyright 2014 MERCIER David
function coneIndentation(E, nu, beta, Y, varargin)
%% Relationship between the dimensionless quantities H/Y and the indentation index.
% From "Nanostructured Thin Films and Coatings Mechanical Properties"
% Sam Zhang (2010) (ISBN:9781420094022)
% Equations are p.184-185

% author: david9684@gmail.com

% H: hardness (in GPa)
% E: elastic modulus (in GPa)
% nu: Poisson's coefficient (0 to 0.5)
% beta: angle between the indented surface and the face of the indenter (in
% degrees), comprised between 0° and 37.5°.
% Y: yield strength (in GPa)

close all;

%% Calculation of indentation index (X)
if nargin > 0
    if nu <= 0 || nu > 0.5
        commandwindow;
        warning('Wrong input for the Poisson''s coefficient...');
    end
    X = (E * tand(beta))/((1-nu^2)*Y);
elseif nargin == 0
    X = 0.1:0.1:1000;
    beta = 19.7; % for a Berkovich indenter
end

%% Calculation of H/Y ratios in function of X - Johnson's model
HYratio(1,:) = (2/3)*(1 + log((1/3).*X));

%% Calculation of H/Y ratios in function of X - Yu's model
HYratio(2,:) = (X/2) .* tanh(((2/(nthroot(3,3))).*(2.845 - 0.023757*beta))./(X/2));

%% Plots
figure(1);
lineWidth = 3;
FontSizeVal = 14;

hPlot = semilogx(X, HYratio(1,:), 'b', 'Linewidth', lineWidth); hold on;
hPlot = semilogx(X, HYratio(2,:), 'r', 'Linewidth', lineWidth);

legendStr1 = ['Johnson''s model for \beta = ', num2str(beta), '°'];
legendStr2 = ['Yu''s model for \beta = ', num2str(beta), '°'];
legend(legendStr1, legendStr2, 'Location', 'SouthEast');
xlabel('Indentation index (X)', 'Interpreter', 'Latex', 'FontSize', FontSizeVal);
ylabel('H/Y', 'Interpreter', 'Latex', 'FontSize', FontSizeVal);
grid on;
ylim([0 4]);
hold off;

end