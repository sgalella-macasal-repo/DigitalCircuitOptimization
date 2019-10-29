function population = recombination(population, bestIndividuals, nGates, nInputs, nIndividuals)
%
% Function:
% - recombination: Repopulates population with offspring of best individuals
%
% Inputs: 
% - population: Connectivity matrix of the population (not repopulated)
% - bestIndividuals: Connectivity matrix of the individuals with better fitness
%                    (1 x nSelected cell)
% - nGates: Number of logic gates conforming the individuals (int)
% - nInputs: Number of total inputs in the individual (int)
% – nIndividuals: Number of total individuals conforming the population (int)
%
% Outputs:
% - population: Connectivity matrix of the population (repopulated)
%
% Authors: mikirubio & sgalella
% https://github.com/sgalella-mikirubio-repo

nSelected = size(bestIndividuals,2);
recombinationType = NaN(1, nIndividuals-nSelected);

for iChild = nSelected+1:(nIndividuals)
    
    % Initialize the connectivity matrix of the child
    columnsChild = ones(1, nInputs+nGates);
    child = zeros(nGates+nInputs);
    
    while (sum(columnsChild) > 0)
        idFather = randi(nSelected);
        idMother = randi(nSelected);    
        while idFather == idMother
            idMother = randi(nSelected);
        end
        father = population(:,:,idFather);
        mother = population(:,:,idMother);
        
        % Calculate the recombination type. Indexing for debugging.
        recombinationType(iChild-nSelected+1) = randi(3);
        
        % Vertical split
        if recombinationType(iChild-nSelected+1) == 1
           verticalCut = nInputs + randi(nGates-1);
           child(:,1:verticalCut) = father(:,1:verticalCut);
           child(:,(verticalCut+1):(nGates+nInputs))=mother(:,(verticalCut+1):(nGates+nInputs));
           
        % Horizontal split
        elseif recombinationType(iChild-nSelected+1) == 2
           horizontalCut = randi(nGates+ nInputs -1);
           child(1:horizontalCut,:) = father(1:horizontalCut,:);
           child((horizontalCut+1):(nGates+nInputs),:)=mother((horizontalCut+1):(nGates+nInputs),:);
           
        % Mixed split
        elseif recombinationType(iChild-nSelected+1) == 3
           verticalCut = nInputs+ randi(nGates-1);
           horizontalCut = nInputs+ randi(nGates-1);
           child(1:horizontalCut,1:verticalCut)=father(1:horizontalCut,1:verticalCut);
           child(1:horizontalCut,(verticalCut+1):(nGates+nInputs))=mother(1:horizontalCut,(verticalCut+1):(nGates+nInputs));
           if rand(1)<0.5
              child((horizontalCut+1:nGates+nInputs),:)= father((horizontalCut+1:nGates+nInputs),:);
           else
              child((horizontalCut+1:nGates+nInputs),:)= mother((horizontalCut+1:nGates+nInputs),:);
           end
       
        end
        columnsChild = sum(child);
        columnsChild = columnsChild > 2;
    end
    population(:,:,iChild) = child;
end

end

