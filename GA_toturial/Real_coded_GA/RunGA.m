function out = RunGA(Problem, params)
  % the problem defination
  CostFunc = Problem.CostFunc; 
  nVar = Problem.nVar;
  VarSize = [1, nVar];
  VarMin = Problem.VarMin;
  VarMax = Problem.VarMax;
  
  %% extract the parameter
  MaxIt = params.MaxIt;
  nPop = params.nPop;
  pC = params.pC;% percentage of children
  nC = round(pC*nPop/2)*2; %nC offsprings
  Mu = params.Mu;
  beta = params.beta;
  sigma = params.sigma;
  gamma = params.gamma;
  %create the initialization
  %the empty individual template for members of population
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
      pop(i).Position = unifrnd(VarMin, VarMax,VarSize); %generate the random real coded values from min-max with size Varsize
      %evaluate solution
      pop(i).Cost = CostFunc(pop(i).Position);
      
      if pop(i).Cost < bestSol.Cost % replace the Cost if there is a smaller value
          bestSol = pop(i);
      end
  end
  %best records of Iterations
  bestCost = nan(MaxIt, 1);
  
  %% Main loop
  for it = 1:MaxIt
      %% selection probablity
      c = [pop.Cost];
      avgc = mean(c);
      if avgc ~= 0
         c = c/avgc;
      end
      probs = exp(-beta *c);
      %popC = repmat(empty_individual, nC, 1); %population of children, it should be 2 columns
      popC = repmat(empty_individual, nC/2, 2);
      
      %% perform crossover
      for k = 1:nC/2
          %q = randperm(nPop);
          %selection parents
          p1 = pop(RouletteWheelSelection(probs)); 
          p2 = pop(RouletteWheelSelection(probs));
          %p1 = pop(q(1));
          %p2 = pop(q(2));
          [popC(k,1).Position, popC(k,2).Position] = ... %popC(k,1).Position is y1
              UniformCrossover(p1.Position, p2.Position,gamma);%p1.Position id x1  
              %can be doublePointCrossover()/singlepointcrossover/uniformcrossover;
      end
      
      %% perform mutation
      %the matrix of popC is not needed to be 2 columns, so here need to be
      %changed
      popc = popC(:);% change popc from 2 column to 1 column
      for t = 1:nC
          popc(t).Position  = Mutate(popc(t).Position, Mu, sigma);
          %check for the variable Bounds
          %if below 2 lines for bounds are commended out, then some
          %variable will be out of the expected range(last column):[0.0550 -0.0261 0.1208 -0.0265 5.8151]
          %if it is not commended out:[-4.1017e-04 -0.0017 -0.0020 0.0018 7.0000]
          %C = max(A,B) 返回从 A 或 B 中提取的最大元素的数组
          popc(t).Position  = max(popc(t).Position, VarMin); %position will not go below Varmin(lower bound)
          popc(t).Position  = min(popc(t).Position, VarMax); %position will not go beyond Varmax(upper bound)
          %evalutate the solution
          popc(t).Cost  = CostFunc(popc(t).Position);
          if pop(t).Cost < bestSol.Cost % replace the Cost if there is a smaller value
             bestSol = pop(t);
          end
      end 
      %merge and sort the population(parents and offspring) 
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