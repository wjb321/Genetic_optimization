function [y1, y2] = UniformCrossover(x1, x2, gamma)%, 
  %this is the random integer from 0-1, it is not for real-coded
  %so change to the continuous values in order to satisfy the real coded
  %status.
  %alpha = randi([0,1], size(x1));%integer
  %alpha = rand(size(x1));%continuous
  
  %edited version for another parameter gamma
  %the gamma here is the way to extend the range of exploration and the
  %efficiency then there will more choice for offspring values
  alpha = unifrnd(-gamma, 1+gamma, size(x1));
  %alpha = rand(size(x1));
  % the offspring y1 and y2 can be go beyond or lower than the upper bound
  % and the lower bound, so it is good to define the range for the specific
  % values
  y1 = alpha.*x1 + (1-alpha).*x2;
  y2 = alpha.*x2 + (1-alpha).*x1;
end