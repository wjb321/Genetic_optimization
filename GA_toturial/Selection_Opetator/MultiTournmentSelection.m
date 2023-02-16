% 多元锦标赛选择
function p = MultiTournmentSelection(Parent, count)

    n = numel(Parent);
    if count >= n
        error('the number in tournment should less than Parent population! ');
    else
        index = randperm(n);
        players = Parent(index(1 : count));
        
        [~, so] = sort([players.fitness], 'descend');

        p = players(so(1)); 
    end
    
end