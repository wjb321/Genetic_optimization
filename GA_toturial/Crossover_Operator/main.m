clc;clear;close all

nVar = 100; % 自变量长度
nPop = 30; % 种群规模
maxIt = 2000; % 最大迭代次数
nPc = 0.8; % 子代比例
nC = round(nPop * nPc / 2) * 2; % 子代规模
nMu = 0.01; % 变异概率


% 结果存放模板
template.chromosome = []; % 染色体序列
template.value = []; % 输出结果
template.fitness = []; % 适应度值


% 父代种群结果存放
Parent = repmat(template, nPop, 1);

% 每代最优个体存放
bestIndividual = zeros(maxIt, 1);


% 初始化种群
for i = 1 : nPop
    
    Parent(i).chromosome = randi([0, 1], 1, nVar);
    Parent(i).value = fun(Parent(i).chromosome);
    Parent(i).fitness = exp(-Parent(i).value);
    
end

for It = 1 : maxIt
    
    % 子代种群结果存放数组
    Offspring = repmat(template, nC/2, 2);
    
    for j = 1 : nC / 2     
        
        % 选择
        p1 = RWS(Parent);
        p2 = RWS(Parent);
        
        % 交叉
        [Offspring(j, 1).chromosome, Offspring(j, 2).chromosome] = SPC(p1.chromosome, p2.chromosome);
      
    end 
    
    Offspring = Offspring(:);
    
    % 变异
    for k = 1 :nC
        Offspring(k).chromosome = UM(Offspring(k).chromosome, nMu);
        Offspring(k).value = fun(Offspring(k).chromosome);
        Offspring(k).fitness = exp(-Offspring(k).value);
    end
    
    % 合并种群
    newPop = [Parent; Offspring];
    
    % 排序
    [~, so] = sort([newPop.fitness], 'descend');
    newPop = newPop(so);
    
    % 筛选
    Parent = newPop(1 : nPop);
    
    disp(['迭代次数：', num2str(It), '， 最小值为：', num2str(Parent(1).value)])
    
    bestIndividual(It) = Parent(1).value;
    
end

plot(bestIndividual,'r', 'linewidth', 1.5);
disp(['迭代了', num2str(find(bestIndividual == 0, 1, 'first')), '次找到结果'])