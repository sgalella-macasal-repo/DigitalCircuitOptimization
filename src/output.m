function [statesMatrix, outputs] = output(individual, nGates, nInputs, inputs, sumColumns)
%
% Function:
% - output: Computes the output of an individual for different inputs 
%
% Inputs: 
% - individual: Connectivity matrix of logical circuits (nComponents x
%               nComponents)
% - nGates: Number of logic gates conforming the individuals (int)
% - nInputs: Number of total inputs in the individual (int)
% - inputs: Total different number of inputs (2^nInputs x nInputs)
% – sumColumns: Sum of the columns of an individual (1 x nComponents)
%
% Outputs:
% - statesMatrix: Contains input and output of an individual (The first three
%                 components of each row represent the input, the rest, the 
%                 output (2^nInputs, nComponents)
% - outputs: Output of an individual for the different inptus (2^nInputs x 1)
%
% Authors: macasal & sgalella
% https://github.com/sgalella-macasal-repo

% Initialization
states = zeros(nGates, 2,(2^nInputs));
statesMatrix = NaN(2^nInputs, nGates + nInputs);
outputs = NaN(1,2^nInputs);  
gate = 0;

for nInput = 1:(2^nInputs)
   
    % Inputs and states of the gates
    statesMatrix(nInput,:) = [inputs(nInput,:), zeros(1, nGates)];           
    
    for column = (nInputs + 1):(nGates + nInputs)                    
        % Case 1: one entry
        if (sumColumns(column) == 1)
            % Condition: number of connextions per gate
            for row = 1:(nGates+nInputs)
                if (individual(row,column) == 1)
                    states(column-nInputs,1,nInput) = statesMatrix(nInput,row);
                    states(column-nInputs,2,nInput) = 0;
                end
            end
            % NOR gate: Assignation output values
            if (states(column-nInputs,1,nInput) + states(column-nInputs,2,nInput) >= 1)
                statesMatrix(nInput,column) = 0;
            elseif (states(column-nInputs,1,nInput) + states(column-nInputs,2,nInput) == 0)
                statesMatrix(nInput,column) = 1;
            end
        else
            % Case 2: two entries
            if (sumColumns(column) == 0)
                statesMatrix(nInput,column) = 0;
            else
                % Case 3: three entries
                if (sumColumns(column) == 2)
                    a = 1;
                    for row=1:nGates+nInputs
                        if (individual(row,column) == 1)
                            states(column-nInputs,a,nInput) = statesMatrix(nInput,row);
                            a = a + 1;
                        end
                    end
                    % NOR gate output vector assignation
                    if states(column-nInputs,1,nInput) + states (column-nInputs,2,nInput) >= 1
                        statesMatrix(nInput,column) = 0;
                    elseif states(column-nInputs,1,nInput) + states (column-nInputs,2,nInput) == 0
                        statesMatrix(nInput,column) = 1;
                    end
                end
            end
        end
    end
    
    for iGate = (nInputs+1):(nGates+nInputs)
        if sumColumns(iGate) > 0
            gate = iGate - nInputs;
        end
    end
    outputs(nInput) = statesMatrix(nInput,gate+nInputs);
end


end

