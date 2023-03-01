#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sun Feb 26 15:42:59 2023

@author: wangjiabin
"""
import numpy as np
import matplotlib.pyplot as plt
from ypstruct import structure #structure lib, like other structure in C
import GA_wang

#here define the cost function
def sphere(x):
    return sum(x**2)

#problem definition
#给定结构体，然后里面有不同的变量，然后对变量进行初始化
problem = structure()
problem.costfunc = sphere
problem.nvar = 5
problem.varmin = [-10, -10, -1, -5, 4]
problem.varmax = [10,   6,   2,  5, 7]


#GA parameters
#给参数定义一些变量结构体
params = structure()
params.maxit = 10 #iterations
params.npop = 5 #population
params.pc = 1 #prop
params.gamma = 0.1
params.mu = 0.1
params.sigma = 0.1
params.beta = 1
#out ga
out = GA_wang.run(problem, params)

#plt.plot(out.bestcost)
plt.semilogy(out.bestcost)
plt.xlim(0, params.maxit)
plt.xlabel('iteration')
plt.ylabel('best cost')
plt.title('genetic algorithm')
plt.grid(True)
plt.show()
#run GA
