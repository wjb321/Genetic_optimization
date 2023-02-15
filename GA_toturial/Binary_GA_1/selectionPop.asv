function  p = selectionPop(Parent)
  %tournament method: select the one who fits the fitness function better,
  %and discard the bad one
  n = numel(Parent); %number of elements in an array(get how many elements in the array)
  index = randperm(n);%生成一个从 1 到 6 的整数的随机排列 return 1*n 
  
  %% select 2 individuals randomly from the matrix
  p1 = Parent(index(1)); %get the value in the given location 
  p2 = Parent(index(2));
  if p1.y <= p2.y
      p = p1;
  else
      p = p2;
  end
end