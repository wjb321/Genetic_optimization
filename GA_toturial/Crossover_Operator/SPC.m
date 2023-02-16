function [o1, o2] = SPC(p1, p2)

    n = numel(p1);
    s = randi([1, n-1]);
    
    o1 = [p1(1 : s) p2(s+1 : end)];
    o2 = [p2(1 : s) p1(s+1 : end)];
    
end