function p = RWS(Parent)

    Px = [Parent.fitness] ./ sum([Parent.fitness]); % 计算相对适应度值
    Cx = cumsum(Px); % 计算累积概率
    r = rand;
    i = find(r <= Cx, 1, 'first'); % 找到随机点落在线上的区间
    p = Parent(i);

end