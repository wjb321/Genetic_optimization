clc;
clear;
close all;

%% define the problem
%CostFunc = @MinOne;
Problem.CostFunc = @(x) MinOne(x);
Problem.nVar = 100; %parameter variable


%% GA parameters 
params.MaxIt = 100;
params.nPop = 100; %the initial generation value
params.pC = 1;
params.Mu = 0.02; % mutation rate
params.beta = 1;
%nC = round(pC*nPop); % this should be an even number, cause the output are
%2~n so change to the line like below

%% Run GA to solve problem
out = RunGA(Problem, params);


%% results
figure;
plot(out.bestCost);
xlabel('iterations');
ylabel('best cost');
grid on;