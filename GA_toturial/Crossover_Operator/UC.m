function [o1, o2] = UC(p1, p2)

    n = numel(p1);
    
    alpha = randi([0, 1], 1, n);
    
    o1 = alpha .* p1 + (1 - alpha) .* p2;
    o2 = alpha .* p2 + (1 - alpha) .* p1;

end