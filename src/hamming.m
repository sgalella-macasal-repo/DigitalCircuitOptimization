function hammingFitness = hamming(outputs, nInputs, targetOutput)
%
% Function:
% - hamming: Computes the hamming distance of the outputs
%
% Inputs: 
% - output: Output from an individual of the population (1x2^nInputs)
% - nInputs: Numper of total inputs in the individual (int)
% - targetOutput: Target output of the circuit (1x2^nInputs)
%
% Outputs:
% - hammingFitness: Hamming fitness for each individual (1 x nIndividuals)
%
% Authors: mikirubio & sgalella
% https://github.com/sgalella-mikirubio-repo

% Comparison output and targetOutput
hammingFitness = 0;
for iInput = 1:(2^nInputs)                                         
    if outputs(iInput)~= targetOutput(iInput)
        hammingFitness = hammingFitness + 1;
    end
end

end

