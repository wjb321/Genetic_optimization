function o = UM(p, nMu)

    r = rand(size(p));
    index = find(r <= nMu);
    p(index) = 1 - p(index);
    o = p;

end
