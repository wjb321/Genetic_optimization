#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sun Feb 26 15:48:21 2023

@author: wangjiabin
"""
import numpy as np
from ypstruct import structure

#问题里面的参数应该有problem和param
def run(problem, params):
    #变量的初始化
    #problems information
    costfunc = problem.costfunc
    nvar     = problem.nvar
    varmin   = problem.varmin
    varmax   = problem.varmax
    
    #parameters
    maxit = params.maxit
    npop  = params.npop
    #pc：is the number who tells about the propotion to main population
    #like: pc = 2, then pc*npop: twice of the poplution
    pc = params.pc
    #define the times of population, for example, if the pc is 2, then it means that 
    #the it is going to be 2 times of population as the offsprings
    nc = int(np.round(pc*npop/2)*2)
    mu    =    params.mu
    sigma = params.sigma
    gamma = params.gamma
    beta = params.beta
    
    #empty individual template
    #创建一个空结构体
    empty_individual = structure()
    empty_individual.position = None 
    empty_individual.cost = None
    #初始化结构体，结构体里面有两个成员，一个是position 另一个是cost
    print("empty_individual",empty_individual)
    
    #bestsolution ever found
    bestsol = empty_individual.deepcopy()
    print("bestsol:",bestsol)
    #初始化损失函数= inf
    bestsol.cost = np.inf
    
    #initialize population
    #将已经初始化的种群重复npop次（npop是种群数量）
    pop = empty_individual.repeat(npop)
    print("pop", pop)
    for i in range(0, npop):
    #产生随机均匀分布的数据，个数nvar,范围varmin -varmax，此处相当于给
    #npop种群中的每个个体初始化。这个结构体内部有两个变量，一个是position另一个是
    #损失函数 cost：struct({'position': None, 'cost': None})
        pop[i].position = np.random.uniform(varmin, varmax, nvar)
        print("pop[i].position",pop[i].position)
        #将pop[i].position成员随机值放进costfunc内部进行评判，然后复制给pop[i].cost
        #然后将变量中的所有值求和，最终的cost = sum([pop[i].position])
        pop[i].cost = costfunc(pop[i].position)
        print("pop[i].deepcopy()",pop[i].deepcopy())
        #若新求解的损失函数小于厨师话的cost值，将当前的结构体赋值给损失函数
        #pop[i].deepcopy() struct({'position': array([ 8.19782895,  1.4135332 , 
        #0.98749549, -1.70548645,  6.72676511]), 'cost': 118.33567580003854})
        if pop[i].cost < bestsol.cost:
            bestsol = pop[i].deepcopy()
        
    #best cost of iterations
    bestcost = np.empty(maxit)
    print("bestcost", bestcost)
    
    #main loop
    for it in range(maxit):
        costs = np.array([x.cost for x in pop])
        print("costs",costs)
        avg_costs = np.mean(costs)
        if avg_costs != 0:
            costs = costs/avg_costs
        #selection probilities
        probs = np.exp(-beta*costs)
        #crossover 
        popc = []# fill this popc with newly produced offsprings
        #nc是offsprin,这个nc填充到nc中
        for _ in range(nc//2): #make sure it is 2
           #select parents
           #permutation:对矩阵进行随机排列，q是一个矩阵，随机排列，从0-npop
           #q = np.random.permutation(npop)
           #p1和p2是poplution下的成员，称之为parents
           #p1 = pop[q[0]]
           #p2 = pop[q[1]]
           
           #perform roulette wheel selection，选择满足roulette_wheel_selection(probs)
           #pop中的所在项目作为子代p1
           p1 = pop[roulette_wheel_selection(probs)]
           print("probs",probs)
           print("roulette_wheel_selection(probs)",roulette_wheel_selection(probs))
           print("p1",p1)
           
           p2 = pop[roulette_wheel_selection(probs)]
           #perform crossover
           c1, c2 = crossover(p1, p2, gamma)
           
           #perform mutation
           c1 = mutation(c1, mu, sigma)
           c2 = mutation(c2, mu, sigma)
           
           #apply bounds
           apply_bound(c1, varmin, varmax)
           apply_bound(c2, varmin, varmax)
           
           #evaluate first offspring
           c1.cost = costfunc(c1.position)
           if c1.cost < bestsol.cost:
               bestsol = c1.deepcopy()
           
           c2.cost = costfunc(c2.postion)
           if c2.cost < bestsol.cost:
               bestsol = c2.deepcopy()
          #add offsprings to pops
           popc.append(c1)
           popc.append(c2)
          
          #merge, sort and select
           pop += popc
           #key:代表sort函数的排序标准，即以什么作为排序标准
           pop = sorted(pop, key =lambda x: x.cost)
           pop = pop[0:npop]
           
           
           #store best cost
           bestcost[it]  = bestsol.cost
           
           #show iteration information
           print("iteration {}: best cost = {}".format(it, bestcost[it]))
            
        #mutation
            
            
    #output
    out = structure()
    out.pop = pop
    out.bestsol = bestsol 
    out.bestcost = bestcost
    return out

def crossover(p1, p2, gamma = 0.1):
    #return same format like p1 and p2（structure）, so here use the reference(deepcopy of oroginal)
    c1 = p1.deepcopy()
    c2 = p1.deepcopy() 
    gamma = 0.1 #set a parameter for gamma
    #the array that used should follow the equations in the picture
    #so here should generate the alpha, which is uniform distribution
    #alpha_i = [-gamma, 1+gamma], *c1.position.shape: specify the size of the output
    #the asterisk "*" submit this as distinct elements to the end of this function call
    #we going to use all members of shape as seperate arguments in the uniform function,
    #so i must perform this conversion this converts this tuple: c1.position.shape to a 
    #list of distinct variables, disjoint variants so alpha 
    
    #选择交叉点
    alpha = np.random.uniform(-gamma,1+gamma,*c1.position.shape)
    
    #print("c1.position.shape",c1.position.shape) #tuple:(5,)
    #print("type c1.position.shape",type(c1.position.shape))
    print("*c1.position.shape", *c1.position.shape) #depackage:5
    print("alpha", alpha)
    #print("type position", type(c1.position))
    
    #offspring c1 and c2
    print("before1 c1",p1.position)
    print("before1 c2",p1.position)
    c1.position = alpha*p1.position + (1-alpha)* p2.position
    c2.position = alpha*p2.position + (1-alpha)* p1.position
    print("after c1",c1.position)
    print("after c2",c2.position)
    return c1, c2


def mutation(x, mu, sigma):
    y = x.deepcopy()
    #create which genes are going to be modified, going to be muted
    #extract infomation from the tuple, and the size of rand(size) should 
    #be same size like the genes(x), so the input is the extract of the tuple
    flag = np.random.rand(*x.position.shape) <= mu
    #return the indice of the indice where the codition satisfiies
    ind = np.argwhere(flag)
    print("ind",ind)
    print("ind.shape",ind.shape)
    print("*ind.shape",*ind.shape)
    y.position[ind] += sigma * np.random.randn(*ind.shape)
    print("y.position[ind]",y.position[ind])
    return y

def apply_bound(x,varmin, varmax):
    #guarantee that the valule: varmin < x < varmax
    x.postion = np.maximum(x.position, varmin)
    x.postion = np.minimum(x.position, varmax)
    
def roulette_wheel_selection(p):
    #[1,2,3,4,5]-> [1,3,6,10,15]
    #累计求和
    c = np.cumsum(p)
    #在已经获得的P底下获得随机函数，这个随机值跟累积求和比，第一个小于累积函数的位置
    r = sum(p)*np.random.rand()
    ind = np.argwhere(r <= c)
    #产生第一个满足上述条件的值
    return ind[0][0]
    
    
    
    
    
    
         
