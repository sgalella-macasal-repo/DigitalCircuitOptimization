function globalFitness = fitness(hammingFitness, costFitness, nGates)
%
% Function:
% - fitness: Computes the global fitness of the individuals
%
% Inputs: 
% - hammingFitness: Hamming distance (number different bits)
% - costFitness: nGates + nConnections of the individuals (1 x nIndividuals)
% – nGates: Number of logic gates conforming the individuals (int)
%
% Outputs:
% - globalFitness: Overall fitness of the individuals (3 x nIndividuals)
%
% Authors: macasal & sgalella
% https://github.com/sgalella-macasal-repo

% Set the hamming and cost to be part of the globalFitness (visualization
% purposes)
globalFitness(1,:) = hammingFitness;
globalFitness(2,:) = costFitness;

% Retrieve the number of individuals from the hammingFitness
nIndividuals = length(hammingFitness);

% Set the fitness to be equal the hammingDistance if this is different than
% 0. Otherwise, let it be equal to the cost divided by nGates^2.
for iIndividual = 1:nIndividuals
    globalFitness(3,iIndividual) = 1 / (1 + hammingFitness(iIndividual));
end

end

