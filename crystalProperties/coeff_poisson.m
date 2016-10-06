%% Copyright 2014 MERCIER David
function nu = coeff_poisson(C12, C44, varargin)
% C12 and C14 : compliances in TPa
% nu: Poisson's coefficient

% author: david9684@gmail.com

% [LEVY 2001] : "Handbook of elastic properties of solids, liquids and
% gases" by M. Levy, H.E. Bass and R.S. Stern (Vol. 2 - Elastic
% Properties of Solids: Theory, Elements, and Compounds, Novel Materials,
% Technological Materials, Alloys, Building Materials)
% Chapter 1 / p. 19
% ISBN-13: 978-0124457607  ISBN-10: 0124457606

if nargin < 2
    % Elastic constants of the Titanium (hcp)
    C12 = 0.0903;
    C44 = 0.0465;
end

nu = 1/(2*(1+(C44/C12)));

end