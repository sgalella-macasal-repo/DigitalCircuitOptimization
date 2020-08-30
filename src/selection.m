function selectedIndividuals = selection(globalFitness, nIndividuals)
%
% Function:
% - selection: Selects best individuals from the population according to 
%              the globalFitness
%
% Inputs: 
% - globalFitness: Overall fitness of the population (3 x nIndividuals)
% - nIndividuals: Number of individuals of the population (int)
%
% Outputs:
% - selectedIndividuals: Individuals with best fitness (2 x nSelected)
%
% Authors: macasal & sgalella
% https://github.com/sgalella-macasal-repo


% Retrieve the overall fitness from globalFitness
fitnessIndividuals = globalFitness(3,:);

% Select the number of selected individuals according to their hamming
if (min(globalFitness(1,:)) == 0)
    nSelected = ceil(nIndividuals/4);
else
    nSelected = ceil(nIndividuals/2);
end

% Sort the fitness in ascending order
selectedIndividuals = NaN(nIndividuals, nSelected);
for iSelected = 1:nSelected
    [maxFitnessIndividuals, idxFitnessIndividuals] = max(fitnessIndividuals);
    selectedIndividuals(1,iSelected) = maxFitnessIndividuals;
    selectedIndividuals(2,iSelected) = idxFitnessIndividuals;
    fitnessIndividuals(selectedIndividuals(2,iSelected)) = -Inf;
end
    

end

