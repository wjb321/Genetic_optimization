function p = roulette(Parent)
  Px = [Parent.fitness]./sum([Parent.fitness]);
  Cx = cumsum(Px);
  i = find(rand <= Cx, 1, 'first');
  p = Parent(i);
end