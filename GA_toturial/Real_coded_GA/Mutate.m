function y = Mutate(x, Mu, sigma)
 flag = (rand(size(x)) < Mu);
 y = x;
 r = randn(size(x));
 y(flag) = x(flag) + sigma * r(flag); %random step
end