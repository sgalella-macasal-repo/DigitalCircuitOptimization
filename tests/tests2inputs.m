%%%%% Test 2 inputs %%%%%
%
% 10 Automatic tests for circuits with 2 inputs
%
% Authors: macasal & sgalella
% https://github.com/sgalella-macasal-repo

% Add path to optimizer folder
addpath('../src/');

% Set the parameters
Params = struct();
Params.iInfo = 250;
Params.nGates = 10;
Params.nMutations = 500;
Params.nIndividuals = 100;
Params.nInputs = 2;
Params.nIterations = 1000;
Params.mutationRate = 0.3;
Params.nComponents = Params.nGates + Params.nInputs;
Params.isDisplay = false;
Params.isPlot = false;

%% Test1
targetOutput = [0 0 0 1];
bestIndividual = circuitoptimizer(Params, targetOutput);
assert(isequal(bestIndividual, targetOutput));

%% Test2
targetOutput = [0 0 1 0];
bestIndividual = circuitoptimizer(Params, targetOutput);
assert(isequal(bestIndividual, targetOutput));

%% Test3
targetOutput = [0 0 1 1];
bestIndividual = circuitoptimizer(Params, targetOutput);
assert(isequal(bestIndividual, targetOutput));

%% Test4
targetOutput = [0 1 0 0];
bestIndividual = circuitoptimizer(Params, targetOutput);
assert(isequal(bestIndividual, targetOutput));

%% Test5
targetOutput = [0 1 0 1];
bestIndividual = circuitoptimizer(Params, targetOutput);
assert(isequal(bestIndividual, targetOutput));

%% Test6
targetOutput = [0 1 1 0];
bestIndividual = circuitoptimizer(Params, targetOutput);
assert(isequal(bestIndividual, targetOutput));

%% Test7
targetOutput = [0 1 1 1];
bestIndividual = circuitoptimizer(Params, targetOutput);
assert(isequal(bestIndividual, targetOutput));

%% Test8
targetOutput = [1 0 1 0];
bestIndividual = circuitoptimizer(Params, targetOutput);
assert(isequal(bestIndividual, targetOutput));

%% Test9
targetOutput = [1 0 1 1];
bestIndividual = circuitoptimizer(Params, targetOutput);
assert(isequal(bestIndividual, targetOutput));

%% Test10
targetOutput = [1 1 1 1];
bestIndividual = circuitoptimizer(Params, targetOutput);
assert(isequal(bestIndividual, targetOutput));