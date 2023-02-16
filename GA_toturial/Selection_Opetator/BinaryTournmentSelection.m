% binary tonurment selection
function p = BinaryTournmentSelection(Parent)

    n = numel(Parent);
    index = randperm(n);
    %get 2 players from the parameters
    players = Parent(index(1 : 2));
    [~, so] = sort([players.fitness], 'descend');
    %find the one with the highest fitness value
    p = players(so(1));
    
end