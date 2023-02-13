function out = RunGA(Problem, params)
  % the problem defination
  CostFunc = Problem.CostFunc; 
  nVar = Problem.nVar;
  
  %extract the parameter
  MaxIt = params.MaxIt;
  nPop = params.nPop;
  pC = params.pC;% percentage of children
  nC = round(pC*nPop/2)*2; %nC offsprings
  Mu = params.Mu;
  
  %create the initialization
  empty_individual.Position = [];
  empty_individual.Cost = [];
  
  %find the best solution
  %before the init, the sol is inf
  bestSol.Cost = inf;
  %initialization 
  % repmat(1, 2, 3)
  % 1     1     1
  % 1     1     1
  pop = repmat(empty_individual, nPop, 1); %repeat matrix
  %randi([0,1],1, 10): produce integer between [0,1], 1 row and 10 columns
  for i=1:nPop
      %generate the random solution
      pop(i).Position = randi([0,1],1, nVar);
      %evaluate solution
      pop(i).Cost = CostFunc(pop(i).Position);
      
      if pop(i).Cost < bestSol.Cost % replace the Cost if there is a smaller value
          bestSol = pop(i);
      end
  end
  %best records of Iterations
  bestCost = nan(MaxIt, 1);
  
  %Main loop
  for it = 1:MaxIt
      %popC = repmat(empty_individual, nC, 1); %population of children, it should be 2 columns
      popC = repmat(empty_individual, nC/2, 2);
      
      %perform crossover
      for k = 1:nC/2
          q = randperm(nPop);
          p1 = pop(q(1));
          p2 = pop(q(2));
          [popC(k,1).Position, popC(k,2).Position] = ... %popC(k,1).Position is y1
              CombinedCrossover(p1.Position, p2.Position);%p1.Position id x1
              %can be doublePointCrossover()/singlepointcrossover/uniformcrossover;
      end
      %perform mutation
      %the matrix of popC is not needed to be 2 columns, so here need to be
      %changed
      popc = popC(:);% change popc from 2 column to 1 column
      for l = 1:nC
          popc(1).Position = Mutate(popc(1).Position, Mu);
          %evalutate the solution
          popc(1).Cost  = CostFunc(popc(1).Position);
          if pop(l).Cost < bestSol.Cost % replace the Cost if there is a smaller value
          bestSol = pop(i);
          end
      end 
      %merge the population
      pop = SortPopulation([pop; popc]);
      
      %remove the extra  individuals
      pop = pop(1:nPop);
      
      %update the best cost of the iteration
      bestCost(it) = bestSol.Cost;
      
      %display the info
      disp(['iteration '  num2str(it) ': best cost =' num2str(bestCost(it))]);
  end
  out.pop = pop;
  out.bestSol = bestSol;
  out.bestCost = bestCost;
end 