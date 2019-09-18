%% Copyright 2017 MERCIER David
function paramAlloy = VegardLaw(xFraction_A, paramA, paramB, varargin)
%% Vegard's law is the empirical heuristic that the lattice parameter of a
% solid solution of two constituents is approximately equal to a rule of 
% mixtures of the two constituents' lattice parameters at the same temperature

% xFraction_A: Fraction of phase A
% paramA: Lattice parameter of material A in pm
% paramB: Lattice parameter of material B in pm

if nargin == 0
    xFraction_A = 0.38;
    paramA = 2.935;
    paramB = 3.356;
end

paramAlloy = (xFraction_A*paramA) + ((1-xFraction_A)*paramB);

end