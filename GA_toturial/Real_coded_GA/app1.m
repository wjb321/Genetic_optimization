clc;
clear;
close all;

%% define the problem
%CostFunc = @MinOne;
Problem.CostFunc = @(x) Sphere(x);
Problem.nVar = 5; %parameter variables
%so the meaning below is defining the minimal values for the problem in
%ranges[-10,10] [-8, 8],,,,,,(matrix version)

%the variables have different bounds
Problem.VarMin = [-10 -8 -1 -10 -7]; %so the each variable has the low bound respectively
Problem.VarMax = [ 10  8  1  10 9]; %so the variable has th upper bound also

%% GA parameters 
params.MaxIt = 500;
params.nPop = 100; %the initial generation value
params.pC = 1;
params.Mu = 0.02; % mutation rate
params.beta = 1;
params.sigma = 0.1;
params.gamma = 0.1;
%nC = round(pC*nPop); % this should be an even number, cause the output are
%2~n so change to the line like below

%% Run GA to solve problem
out = RunGA(Problem, params);


%% results
figure;
%plot(out.bestCost);
semilogy(out.bestCost, 'LineWidth', 2);
xlabel('iterations');
ylabel('best cost');
grid on;