function p = mutate(x,Mu)
%sigle point mutate
%define the prob of mutate
%% single point mutation
if rand <= Mu % any value smaller than Mu, then mutate
   n = numel(x);
   s = randi([1, n]); %select the point that mutated from 1 to n
   if x(s) == 0
       x(s) = 1;
   elseif x(s) ==1
       x(s) = 0;
   end
end
   p = x; %give the final mutation result to p
end