function [y1,y2] = SinglePointCrossover(x1, x2)
%x1 and x2 are the positions of the parents chromesome
%for the cutting point, you cannt select the first and the last line of the
%chromesome, so we can pick a number randomly from 1 - len-1 of the
%chromesome
         nVar =numel(x1);
         j = randi([1, nVar-1]); % pick the single point
         
         y1 = [x1(1:j) x2(j+1: end)];
         y2 = [x2(1:j) x1(j+1: end)];

end