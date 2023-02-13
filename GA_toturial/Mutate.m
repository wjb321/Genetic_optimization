function y = Mutate(x, Mu)
 flag = (rand(size(x)) < Mu);
 y = x;
 y(flag) = 1- x(flag);
end