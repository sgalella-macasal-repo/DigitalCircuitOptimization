function costFitness = cost(nInputs, nGates, sumColumns)
%
% Function:
% - cost: Computes the cost (components + connections) of an individual 
%
% Inputs: 
% - nInputs: Numper of total inputs in the individual (int)
% - nGates: Number of logic gates conforming the individuals (int)
% - sumColumns: Sum of the columns of an individual (1 x nComponents)
%
% Outputs:
% - costFitness: Cost of the individual (1 x nIndividuals)
%
% Authors: macasal & sgalella
% https://github.com/sgalella-macasal-repo

% Compute the total number of gates in an individual
totalGates = 0;
totalConnections = sum(sumColumns, 'all');
for iGate = (nInputs+1):(nGates+nInputs)
    if (sumColumns(iGate) > 0)
        totalGates = totalGates + 1;
    end
end

% Compute the total cost
costFitness = totalConnections + totalGates;

end

