function [o1, o2] = MPC(p1, p2)
    
    n = numel(p1);
    s = randperm(n-1, 2);
    point1 = min(s);
    point2 = max(s);
    
    o1 = [p1(1 : point1) p2(point1+1 : point2) p1(point2+1 : end)];
    o2 = [p2(1 : point1) p1(point1+1 : point2) p2(point2+1 : end)];
    
end