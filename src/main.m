%%%%% Main %%%%%
%
% Setup and run the genetic algorithm
%
% Authors: mikirubio & sgalella
% https://github.com/sgalella-mikirubio-repo

% Set the random seed for controlling rng
runSeed = 4321;
rng(runSeed);

% Setup of the algorithm
iInfo = 250;
nGates = 10;
nMutations = 500;
nIndividuals = 100;
nInputs = 3;
nIterations = 2000;
mutationRate = 0.1;
targetOutput = [1 1 1 0 0 1 1 1];
nComponents = nGates + nInputs;

% Initialize the population and best individual
population = zeros(nComponents, nComponents, nIndividuals); 
bestIndividual = zeros(nComponents);

% Control sequences
assert(2^nInputs == size(targetOutput, 2), ['The size of the ' ...
    'output has to be equal to 2^nInputs']);
assert(nGates > 1, 'Number of gates has to be larger than 1');

% Initialize the binary input table
inputs = NaN(2^nInputs, nInputs);
for iInput = 0:(2^nInputs)-1
    inputs(iInput+1,:) = de2bi(iInput,nInputs,'left-msb');
end

% Generate initial population (iIteration = 1)
% Initialize variables
fitnessHamming = NaN(1, nIndividuals);
fitnessCost = NaN(1, nIndividuals);
sumRows = NaN(nComponents, nIndividuals);
sumColumns = NaN(nComponents, nIndividuals);
statesMatrixPopulation = NaN(2^nInputs, nComponents, nIndividuals);
outputs = NaN(nIndividuals, 2^nInputs);

% Compute each individual and its fitness
for iSelected = 1:nIndividuals
    population(:,:,iSelected) = mutation(population(:,:,iSelected),nMutations,nGates,nInputs,1);
    sumRows(:,iSelected) = sum(population(:,:,iSelected),2);
    sumColumns(:,iSelected) = sum(population(:,:,iSelected));                                                     
    [statesMatrixPopulation(:,:,iSelected), outputs(iSelected,:)] = ...
        output(population(:,:,iSelected), nGates, nInputs,inputs,sumColumns(:,iSelected));
    fitnessHamming(iSelected) = hamming(outputs(iSelected,:),nInputs,targetOutput);
    fitnessCost(iSelected) = cost(nInputs,nGates,sumColumns(:,iSelected));
end

% Compute the fitness of the first population
globalFitness = fitness(fitnessHamming, fitnessCost, nGates);
avgFitness = mean(globalFitness(3,:));
minFitness = min(globalFitness(3,:));
finalSelection = selection(globalFitness, nIndividuals);
nSelected = size(finalSelection(1,:), 2);

% Store the best individuals, initialize again the population and 
% repopulate the population with them
bestIndividuals = cell(1, nSelected);
for iSelected = 1:nSelected
    bestIndividuals{iSelected} = population(:,:,finalSelection(2,iSelected));
end
population = zeros(size(population));
for iSelected = 1:nSelected
    population(:,:,iSelected)= bestIndividuals{iSelected};
end

% Compute the subsequent nIterations - 1 populations
for iIteration = 2:nIterations

    % Recombination: Create the rest of the population with breeds of the
    % best individuals
    if (length(bestIndividuals)>1)
        population = recombination(population, bestIndividuals, nGates, nInputs, nIndividuals);
    end
    
    % Incorporate individuals to the population. Eventually, produce mutations
    for iSelected = (length(bestIndividuals)+1):nIndividuals
        population(:,:,iSelected) = mutation(population(:,:,iSelected), 10, nGates, nInputs, mutationRate);
    end 
    
    % Compute each individual and its fitness
    for iSelected = 1:nIndividuals
        sumColumns(:,iSelected) = sum(population(:,:,iSelected));                                                     
        sumRows(:,iSelected) = sum(population(:,:,iSelected),2);
        [statesMatrixPopulation(:,:,iSelected), outputs(iSelected,:)] = ...
            output(population(:,:,iSelected), nGates, nInputs, inputs, sumColumns(:,iSelected));
        fitnessHamming(iSelected) = hamming(outputs(iSelected,:),nInputs,targetOutput);
        fitnessCost(iSelected) = cost(nInputs, nGates, sumColumns(:,iSelected));
    end
    
    % Compute the fitness of the population
    globalFitness = fitness(fitnessHamming, fitnessCost, nGates);
    avgFitness(iIteration) = mean(globalFitness(3,:));
    minFitness(iIteration) = min(globalFitness(3,:));
    finalSelection = selection(globalFitness, nIndividuals);
    nSelected = size(finalSelection(1,:), 2);
    bestIndividuals = cell(1, nSelected);    

    % Store the best individuals, initialize again the population and 
    % repopulate the population with them
    for iSelected = 1:nSelected
        bestIndividuals{iSelected} = population(:,:,finalSelection(2,iSelected));
    end
    population = zeros(size(population));
    for iSelected = 1:nSelected
        population(:,:,iSelected)= bestIndividuals{iSelected};
    end

    % Fitness calculation (keep the best)
    for iSelected = 1:nSelected
        sumColumns(:,iSelected) = sum(population(:,:,iSelected));                                                     
        sumRows(:,iSelected) = sum(population(:,:,iSelected),2);
        [statesMatrixPopulation(:,:,iSelected), outputs(iSelected,:)] = ...
            output(population(:,:,iSelected),nGates, nInputs,inputs,sumColumns(:,iSelected));
        [fitnessHamming(iSelected)] = hamming(outputs(iSelected,:),nInputs,targetOutput);
        [fitnessCost(iSelected)] = cost(nInputs,nGates,sumColumns(:,iSelected));
    end
    
    % Calculate the global fitness
    globalFitness(:,1:nSelected) = ...
        fitness(fitnessHamming(1:nSelected), fitnessCost(1:nSelected), nGates);

    % Print stats
    bestIndividual = population(:,:,1);
    bestFitness = globalFitness(3,1);
    bestOutput = outputs(1,:);
    bestHamming = fitnessHamming(1);
    bestCost = fitnessCost(1);
    totalGates = sum(sum(bestIndividual) > 0);
    totalConnections = sum(sum(bestIndividual));
    
    if mod(iIteration, iInfo) == 0
        clc;
        fprintf('--------- Digital Circuit Optimization ---------\n')
        fprintf("\nNumber of iterations: %d",iIteration);
        fprintf("\nNumber of gates: %d", totalGates);
        fprintf("\nNumber of connections: %d", totalConnections);
        fprintf("\nBest hamming distance: %d",bestHamming);
        fprintf("\nBest cost: %d",bestCost);
        fprintf("\nBest fitness: %.2f",bestFitness);
        fprintf("\nTarget output: %s",num2str(targetOutput));
        fprintf("\nBest output:   %s\n\n",num2str(bestOutput));
        fprintf('         -------------  *  ------------\n');
    end

end

if (bestHamming > 1)
    warning("\nNo optimal solution could be found.")
end

% Plot the minumum and average fitness across iterations
subplot(2,1,1)
plot(minFitness,'r');
title('Minimum fitness','interpreter','latex','fontsize',20);
ylabel('fitness','interpreter','latex','fontsize',20);
subplot(2,1,2)
plot(avgFitness,'b');
title('Average fitness','interpreter','latex','fontsize',20);
xlabel('iterations','interpreter','latex','fontsize',20);
ylabel('fitness','interpreter','latex','fontsize',20)
