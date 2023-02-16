function p = RouletteWheelSelection(Parent)
    % fitness value calculation
    Px = [Parent.fitness] ./ sum([Parent.fitness]); % calculate relative fitness value
    Cx = cumsum(Px); % culate cumlative probs
    r = rand;
    %find one value that satisfied the condition r <= Cx (randomValue < cumulative sum value), and the one is
    %the first value that found,and return the subscript
    i = find(r <= Cx, 1, 'first'); % find the interval that the point locates
    p = Parent(i);

end