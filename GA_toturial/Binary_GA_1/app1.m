clc;clear

%% define the variables
nVar = 100; % variable for recepting the length of x???
nPop = 30; % the group size
maxIt = 1500;
nPc = 0.8; %prob of crossover
nMu = 0.01;
%% when crossover
%it can not be an odd output(31,35...) ,cause the output of crossover is y1 and y2, should be even
%so modify "nC= round(nPop * nPc);" into below
nC= round(nPop * nPc/2)*2; %now it is a even value of crossover value

%% define the template
template.x = [];
template.y = [];
%repmat([2,1], 2, 1) = 2     1
%                      2     1
Parent = repmat(template, nPop, 1); % repeat the matrix template with npop rows and 1 column

%% initialize the population
for i = 1:nPop
   Parent(i).x = randi([0,1], 1, nVar);
   Parent(i).y = fun(Parent(i).x); % get the fitness value
end

%% main loop
for It = 1: maxIt
    %offspring = repmat(template, nC, 1);% repeat the offspring template to nC row and 1 column
    % in order to simply check change to (nC/2, 2)dim
    %% refresh the offspring but not addup offspring
    %below line should be in the main loop, because the offspring space
    %should be fixed,like overwrite the offspring array, otherwise the
    %offsrping group will enlarge
    offspring = repmat(template, nC/2, 2); 
    %% crossover loop
    for j = 1:nC/2
        p1 = selectionPop(Parent);
        p2 = selectionPop(Parent);
        %assign col 1 and col 2 to x of sum(x),no need to calculate y value
        %cause next step is mutation, after this, then can calculate y
        [offspring(j,1).x, offspring(j,2).x] = Crossover(p1.x, p2.x);
    end
    offspring = offspring(:);
    
    %% mutate
    for k = 1: nC
        offspring(k).x = mutate(offspring(k).x, nMu);
        offspring(k).y = fun(offspring(k).x);
    end
    newPop = [Parent;offspring]; %selecte the parent and offspr(concatenation)
    [~, loc] = sort([newPop.y],'ascend');% ascend and only take its subscript
    newPop = newPop(loc); % find the individual by the subscript
    Parent = newPop(1 : nPop);% just select the 1-nPop population, discard the rest
    disp(['it times: ', num2str(It), 'mini val is: ', num2str(Parent(1).y)]);
    %throw away to last half
end

%% result
% figure;
% plot(Parent(1).y);
% xlabel('iterations');
% ylabel('the cost');
% grid on;