function y = Mutate(x, Mu, sigma)
 %the flag indices where the value of decision variables should be changed
 flag = (rand(size(x)) < Mu);
 y = x;
 r = randn(size(x));
 %it is possible that x(flag)after adding some parameters like sigma*r(flag)
 %then it can be go beyond the upper bound
 
 %% x' = x + delta, where the delta is the random step
 % here is the basic rule:
 % a.N(mu,delta^2) --> mu + sigma* randn
 % b.N(0, delta^2) --> sigma* randn
 y(flag) = x(flag) + sigma * r(flag); %random step
end