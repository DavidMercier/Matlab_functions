function s = Hertz_equations(nu, varargin)
%% Stress distributions at the surface and along the axis of symmetry
% causes by Hertz pressure acting on a circular area radius a.
% From "Contact Mechanics" - K. L. Johnson (1987) (ISBN:9780521347969)
% Equations are p.62 and graphics p.94.

% nu: Poisson's coefficient (0 to 0.5)

% author: D. Mercier

close all;

if nargin == 0
    nu = 0.3; % Poisson's coefficient
end

if nu <= 0 || nu > 0.5
    commandwindow;
    warning('Wrong input for the Poisson''s coefficient...');
else
    s = struct();
    
    %% Stress distributions at the surface in function of the ratio r over a
    % with r the radial coordinates and a (or ae) the radius of elastic contact
    
    s.r_over_a.r_over_a = linspace(1e-5, 2);
    
    s.r_over_a.stress_radial = zeros(length(s.r_over_a.r_over_a),1);
    s.r_over_a.stress_orthoradial = zeros(length(s.r_over_a.r_over_a),1);
    s.r_over_a.stress_z = zeros(length(s.r_over_a.r_over_a),1);
    
    for ii = 1:length(s.r_over_a.r_over_a)
        s.r_over_a.stress_radial(ii) = -1.5 * (((((1-(2*nu))/3) ...
            * (1/s.r_over_a.r_over_a(ii))^2) ...
            * (1-(1-(s.r_over_a.r_over_a(ii))^2)^1.5)) ...
            - ((1-(s.r_over_a.r_over_a(ii))^2)^0.5));
        
        s.r_over_a.stress_orthoradial(ii) = -1.5 * (-((((1-(2*nu))/3) ...
            * (1/s.r_over_a.r_over_a(ii))^2) ...
            * (1-(1-(s.r_over_a.r_over_a(ii))^2)^1.5)) ...
            - (2*nu)*((1-(s.r_over_a.r_over_a(ii))^2)^0.5));
        
        s.r_over_a.stress_z(ii) = -1.5 * ...
            (-((1-(s.r_over_a.r_over_a(ii))^2)^0.5));
    end
    
    %% Stress distributions along the axis of symmetry in function of the ratio z over a
    % with z the vertical coordinates and a (or ae) the radius of elastic contact
    
    s.z_over_a.z_over_a = linspace(1e-4, 3);
    
    s.z_over_a.stress_radial = zeros(length(s.z_over_a.z_over_a),1);
    s.z_over_a.stress_orthoradial = zeros(length(s.z_over_a.z_over_a),1);
    s.z_over_a.stress_z = zeros(length(s.z_over_a.z_over_a),1);
    s.z_over_a.stress_shear = zeros(length(s.z_over_a.z_over_a),1);
    
    for ii = 1:length(s.z_over_a.z_over_a)
        s.z_over_a.stress_radial(ii) = -(1+nu) ...
            * (1-(s.z_over_a.z_over_a(ii)) ...
            * atan(1/s.z_over_a.z_over_a(ii))) ...
            + 0.5*(1+(s.z_over_a.z_over_a(ii))^2)^-1;
        
        s.z_over_a.stress_orthoradial(ii) = s.z_over_a.stress_radial(ii);
        
        s.z_over_a.stress_z(ii) = -1.5*(1+(s.z_over_a.z_over_a(ii))^2)^-1;
        
        s.z_over_a.stress_shear(ii) = 0.5*(s.z_over_a.stress_z(ii) - ...
            s.z_over_a.stress_radial(ii));
    end
    
    %% Plots
    figure(1);
    lineWidth = 3;
    
    % Plot of stress distributions at the surface
    subplot(2,1,1);
    plot(s.r_over_a.r_over_a, s.r_over_a.stress_radial, ...
        'b', 'Linewidth', lineWidth); hold on;
    
    plot(s.r_over_a.r_over_a, s.r_over_a.stress_orthoradial, ...
        'r', 'Linewidth', lineWidth); hold on;
    
    plot(s.r_over_a.r_over_a, s.r_over_a.stress_z, 'g', 'Linewidth', lineWidth);
    
    legend('Radial stress', 'Orthoradial stress', 'Z stress');
    xlabel('r/a_e');
    ylabel('Stress');
    
    % Plot of stress distributions along the axis of symmetry
    subplot(2,1,2);
    plot(s.z_over_a.stress_radial, s.z_over_a.z_over_a, ...
        'b', 'Linewidth', lineWidth); hold on;
    
    plot(s.z_over_a.stress_z, s.z_over_a.z_over_a, ...
        'g', 'Linewidth', lineWidth); hold on;
    
    plot(s.z_over_a.stress_shear, s.z_over_a.z_over_a, ...
        'y', 'Linewidth', lineWidth);
    
    legend('Radial stress', 'Z stress', 'Shear stress');
    xlabel('Stress');
    ylabel('z/a_e');
    
    % Set x-limits to ensure graph starts at first data point
    currentLimits = xlim;
    xlim([currentLimits(1) 0]);
    
    set(gca,'XDir','Reverse');
    set(gca,'YDir','Reverse');
    
end

end