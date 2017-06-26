%% Copyright 2014 MERCIER David
function s = stressSingularityExponent
%% Calculation of critical film cracking number in film cracking
% From J. L. Beuth., "Cracking of thin bonded films in residual tension",
% International Journal of Solids and Structures, 29(13), 1657-1675, 1992.
% See also A. Favache et al., "Fracture toughness measurement of ultra-thin hard
% films deposited on a polymer interlayer", Thin Solid Films, 550, 464-471, 2014.

% alpha and beta: Dimensionless Dundur's parameters
% Ef and Es: Young's modulus of coating and subtrate in GPa
% nuf and nus: Poisson's coefficient of coating and subtrate

% author: david9684@gmail.com

F = @(a,b,s) cos(s*pi)-2*((a-b)/(1-b))*...
    ((1-s)^2)+((a-(b^2))/(1-(b^2)));

a = -1:0.02:1;
b = 0:0.1:0.5;
s = zeros(length(a), length(b));

for ii = 1:length(a)
    for jj = 1:length(b)
        s(ii,jj) = fzero(@(s) F(a(ii),b(jj),s), 0.5);
    end
end

for jj = 1:length(b)
    plot(a, s(:,jj), 'LineWidth',4/jj);
    hold on
end
strLeg_val = cellstr(num2str(b'));
strLeg = strcat('{\beta} =', strLeg_val);
legend(strLeg,'Location','northwest');
xlabel('\alpha','Interpreter','Tex');
ylabel('Stress singularity exponent');

end