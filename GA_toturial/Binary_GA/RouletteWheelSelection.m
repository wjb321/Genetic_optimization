function i = RouletteWheelSelection(p)
  %p = p/sum(p); % can be dangerous if sum(p) = 0
  r = rand*sum(p);
  %r = rand;
  c = cumsum(p);
  i = find(r <= c, 1, 'first');
end