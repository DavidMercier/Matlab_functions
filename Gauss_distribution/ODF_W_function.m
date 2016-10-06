%% Copyright 2014 MERCIER David
function W = ODF_W_function(phi2, alpha, varargin)
% Gaussian distribution function to describe a texture
% See Li J.Y. /  J. Mech. Phys. Solids 48 (2000) 529-552
% DOI : 10.1016/S0022-5096(99)00042-3

% author: david9684@gmail.com

% phi2 : Euler angles in rad
% alpha : Parameter in Gaussian distribution function

if nargin < 2
    % Setting of parameter in Gaussian distribution function
    alpha = [0.15235, 0.5, 1, 2];
end

if nargin < 1
    phi2 = 0:1:360;
    phi2 = phi2*pi/180; % degtorad
end

% Setting of color/width of lines
c1 = 0;
c2 = 0;
c3 = 0;
lw = 1;

% Preallocation of variables
W = zeros(length(phi2),length(alpha));
legendInfo{length(alpha)} = [];

for ii = 1:length(alpha)
    W(:,ii) = (1./(alpha(ii)*((2*pi).^0.5))) * ...
        exp((-phi2.^2)./(2*(alpha(ii).^2)));
    plot(phi2, W(:,ii),...
        'Color',[c1 c2 c3],...
        'Linewidth', lw);
    legendInfo{ii} = (strcat('\alpha=', num2str(alpha(ii))));
    c1 = c1 + 1/length(alpha);
    c2 = c2 + 1/length(alpha);
    c3 = c3 + 1/length(alpha);
    lw = lw + 1;
    hold on;
end

% Plot options
xlim(gca, [0, 1]);
ylim(gca, [0, 1.5]);
xlabel('Euler angle - \phi_2')
ylabel('Orientationnal distribution function')
legend(legendInfo);

end
