% 多元锦标赛选择
function p = MTS(Parent, count)

    n = numel(Parent);
    if count >= n
        error('设置参赛个体数须小于父代种群规模！')
    else
        index = randperm(n);
        players = Parent(index(1 : count));
        
        [~, so] = sort([players.fitness], 'descend');

        p = players(so(1)); 
    end
    
end