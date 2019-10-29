function individual = mutation(individual, nMutations, nGates, nInputs, mutationRate)
%
% Function:
% - mutation: Mutates the connectivity matrix of a individual 
%
% Inputs: 
% - individual: Connectivity matrix of logical circuits (nComponents x
%               nComponents)
% - nMutations: Number of mutations to produce in the individual (int)
% - nGates: Number of maximum gates in the individual (int)
% - nInputs: Numper of total inputs in the individual (int)
% – mutationRate: Probability of mutation (float)
%
% Outputs:
% - individual: Mutated connectivity matrix (nComponents x nComponents)
%
% Authors: mikirubio & sgalella
% https://github.com/sgalella-mikirubio-repo

for iMutation = 1:nMutations
    
    % Connection matrix column sum vector
    sumColumns = sum(individual, 1);   
    
    % row is assigned with a random value. Not accounting for last row
    row = randi(nGates + nInputs - 1);  
    
    % Condition: No error. Not accounting last row neither penultimate.
    if row < nGates + nInputs - 2
        % Assign column a random number 
        column = row + randi(nGates + nInputs - row);              
    else
        % Calculation of j in last row
        column = row + 1;                                                             
    end
    
    % Restriction: No accessible areas of the matrix
    while ((row < nInputs+1) && (column < nInputs+1))                                                  
        row = randi(nGates + nInputs - 1);
        column = row + randi(nGates + nInputs - row);
    end
    
    % Mutate the position with probability mutationRate
    if rand(1) <= mutationRate
        if individual(row,column) == 1
                % If there is a 1 in our coordinate (row, column),
                % equals to 0
                individual(row,column) = 0;
                % Condition: Sum of columns cannot be greater than 2 (NOR gate)
        elseif ((individual(row,column) == 0) && (sumColumns(column) < 2))
                % If there is a 0 in our (row, column) coordinate,
                % equals to 1
                individual(row,column) = 1;                                                  
        end
    end
end

end

