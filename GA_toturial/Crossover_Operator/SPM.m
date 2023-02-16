function o = SPM(p, nMu)

    if rand <= nMu
        n = numel(p);
        s = randi([1, n]);
        p(s) = 1 - p(s);
    end
    o = p;

end