%%%%% Test 3 inputs %%%%%
%
% 10 Automatic tests for circuits with 3 inputs
%
% Authors: macasal & sgalella
% https://github.com/sgalella-macasal-repo

% Add path to optimizer folder
addpath('../src/');

% Set the random seed for controlling rng
runSeed = 4321;

% Set the parameters
Params = struct();
Params.iInfo = 250;
Params.nGates = 10;
Params.nMutations = 500;
Params.nIndividuals = 100;
Params.nInputs = 3;
Params.nIterations = 2000;
Params.mutationRate = 0.1;
Params.nComponents = Params.nGates + Params.nInputs;
Params.isDisplay = false;
Params.isPlot = false;

%% Test1
rng(runSeed);
targetOutput = [1 1 1 0 0 1 0 1];
bestIndividual = circuitoptimizer(Params, targetOutput);
assert(isequal(bestIndividual, targetOutput));

%% Test2
rng(runSeed);
targetOutput = [0 1 1 1 1 1 0 1];
bestIndividual = circuitoptimizer(Params, targetOutput);
assert(isequal(bestIndividual, targetOutput));

%% Test3
rng(runSeed);
targetOutput = [0 0 0 1 1 1 0 1];
bestIndividual = circuitoptimizer(Params, targetOutput);
assert(isequal(bestIndividual, targetOutput));

%% Test4
rng(runSeed);
targetOutput = [1 1 1 1 1 1 1 1];
bestIndividual = circuitoptimizer(Params, targetOutput);
assert(isequal(bestIndividual, targetOutput));

%% Test5
rng(runSeed);
targetOutput = [0 0 0 0 0 1 0 1];
bestIndividual = circuitoptimizer(Params, targetOutput);
assert(isequal(bestIndividual, targetOutput));

%% Test6
rng(runSeed);
targetOutput = [1 0 0 0 0 0 0 0];
bestIndividual = circuitoptimizer(Params, targetOutput);
assert(isequal(bestIndividual, targetOutput));

%% Test7
rng(runSeed);
targetOutput = [1 0 1 0 1 0 1 0];
bestIndividual = circuitoptimizer(Params, targetOutput);
assert(isequal(bestIndividual, targetOutput));

%% Test8
rng(runSeed);
targetOutput = [0 1 0 1 0 1 0 1];
bestIndividual = circuitoptimizer(Params, targetOutput);
assert(isequal(bestIndividual, targetOutput));

%% Test9
rng(runSeed);
targetOutput = [1 1 1 0 0 1 1 1];
bestIndividual = circuitoptimizer(Params, targetOutput);
assert(isequal(bestIndividual, targetOutput));

%% Test10
rng(runSeed);
targetOutput = [1 1 1 1 0 1 1 1];
bestIndividual = circuitoptimizer(Params, targetOutput);
assert(isequal(bestIndividual, targetOutput));