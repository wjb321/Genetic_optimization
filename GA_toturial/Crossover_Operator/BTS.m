% 二元锦标赛选择
function p = BTS(Parent)

    n = numel(Parent);
    index = randperm(n);
    players = Parent(index(1 : 2));
    [~, so] = sort([players.fitness], 'descend');
    p = players(so(1));
    
end