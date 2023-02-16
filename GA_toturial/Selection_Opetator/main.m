clc;clear;close all

nVar = 100; % length of varibles
nPop = 30; % population size
maxIt = 2000; % iteration 
nPc = 0.8; % child population
nC = round(nPop * nPc / 2) * 2; % population size
nMu = 0.01; % mutate rate

% template for storing the output 
template.chromosome = []; % serie of chromosome
template.value = []; % output value
template.fitness = []; % fitness value

% store parent population output 
Parent = repmat(template, nPop, 1);
% store the best individual in each generation
bestIndividual = zeros(maxIt, 1);

% initialize the population
for i = 1 : nPop
    
    Parent(i).chromosome = randi([0, 1], 1, nVar);
    Parent(i).value = fun(Parent(i).chromosome);
    Parent(i).fitness = exp(-Parent(i).value);
    
end

for It = 1 : maxIt
    
    % children population output storage
    Offspring = repmat(template, nC/2, 2);
    
    for j = 1 : nC / 2     
%       p1 = MultiTournmentSelection(Parent,25);
%       p2 = MultiTournmentSelection(Parent,25);
        
        p1 = RouletteWheelSelection(Parent);
        p2 = RouletteWheelSelection(Parent);
        
        % crossover
        [Offspring(j, 1).chromosome, Offspring(j, 2).chromosome] = crossPop(p1.chromosome, p2.chromosome);
        
    end
    Offspring = Offspring(:);
    
    % mutate
    for k = 1 :nC
        Offspring(k).chromosome = mutatePop(Offspring(k).chromosome, nMu);
        Offspring(k).value = fun(Offspring(k).chromosome);
        Offspring(k).fitness = exp(-Offspring(k).value);
    end
    
    % merge the popluation
    newPop = [Parent; Offspring];
    
    % sort
    [~, so] = sort([newPop.fitness], 'descend');
    newPop = newPop(so);
    
    % select
    Parent = newPop(1 : nPop);
    
    disp(['iteration:', num2str(It), '，miniVal is ', num2str(Parent(1).value)])
    
    bestIndividual(It) = Parent(1).value;
    
end

plot(bestIndividual,'r', 'linewidth', 1.5);
disp(['itr', num2str(find(bestIndividual == 0, 1, 'first')), 'find the result'])