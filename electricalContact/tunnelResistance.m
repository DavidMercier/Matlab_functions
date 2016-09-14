function Rtunnel = tunnelResistance(h, e, me, phi, tf, ac, varargin)
%% Calculation of the electical tunnel resistance in the case of metallic contact
% with an oxide at the interface at low loads.
% From Simmons J. G., “Generalized Formula for the Electric Tunnel Effect between
% Similar Electrodes Separated by a Thin Insulating Film.”, J. Appl. Phys., 1963,
% 34(6), pp. 1793-1803.
% From Slade P. G., “Electrical contacts: principles and applications.” Marcel Dekker, 1999.

% h: Planck's constant = 6.62607004 × 10-34 m2 kg / s
% e: elementary electronic charge = -1.602×10-19 C
% me: mass of electron = 9.109×10-31 kg
% phi: energy of the metal-oxide-metal barrier in eV
% tf: film thickness in nm
% ac: contact radius in µm

close all;

if nargin < 7
    ac = 0.01:100:1e7;
end

if nargin < 6
    tf = 2;
end

if nargin < 5
    phi = 2;
end

if nargin < 4
    h = 6.62607004 * 10^(-34);
    e = -1.602 * 10^(-19);
    me = 9.109 * 10^(-31);
end

tf = tf * 1e-9;
ac = ac * 1e-6;

%% Tunnel contact resistance
contactArea = pi()*ac.^2;
X = sqrt(2*me*phi*1.6*10^(-19));

Rtunnel = 2.*(tf./(contactArea)) .* ((h./e).^2) .* ...
    (2./(3.*X)) .* exp(((X.*4.*pi().*tf)./h));

%% Plot of the tunnel contact resistance
lineWidth = 2;

loglog(contactArea*1e6, Rtunnel, 'k', 'Linewidth', lineWidth); hold on;

xlim([1e-10 1e7]);
ylim([1e-2 1e14]);

xlabel('Contact area (mm^2)');
ylabel('Resistance contact tunnel (Ohm)');
grid on;

end