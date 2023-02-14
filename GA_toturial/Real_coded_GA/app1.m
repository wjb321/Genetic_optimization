clc;
clear;
close all;

%% define the problem
%CostFunc = @MinOne;
Problem.CostFunc = @(x) Sphere(x);
Problem.nVar = 5; %parameter variable
Problem.VarMin = -10; %this can be replaced with a matrix
Problem.VarMax =  10;

%% GA parameters 
params.MaxIt = 1000;
params.nPop = 1000; %the initial generation value
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