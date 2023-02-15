function [y1,y2] = Crossover(x1, x2)
 % single point crossover, randomly choose one bit from the given length of
 % x1 and x2, crossover the same point from x1 and x2. remember the point
 % selection should not be the last point, because the last point means the
 % point(last one)and before points should all be crossovered, then same
 % like 2 chromsomes are swaps totally, it is meaningless.
  n = numel(x1); % return the element numbers
  %% randi(a,b), usage:
  % 1.randi(a,b)
  % a varabie range from 1-a,dimen b*b matrix
  % 2. randi([a,b]):generate the value range from a  to b
  % select the crossover point
  s = randi([1, n-1]);% randomly generate a integer value from 1 to n-1
  
         y1 = [x1(1:s) x2(s+1: end)];
         y2 = [x2(1:s) x1(s+1: end)];
end