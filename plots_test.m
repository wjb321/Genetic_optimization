x1 = 0:pi/100:2*pi;
x2 = 0:pi/10:2*pi;
x3 = 0:pi/100:2*pi;
x4 = 0:pi/10:2*pi;
plot(x1,sin(x1),'r:',x2,sin(x2),'g+', x3,0.2*x3 +0.1 ,'b:', x4,0.2*x4 +0.1,'c+')
title('Ninad complains that I can not help him')
xlabel('x for the independent variable')
ylabel('y for the dependent variable sin(x1)')
legend({'y = sin(x/100)','y = sin(x/10)', 'y = 0.2(x/100) + 0.1', 'y = 0.2(x/10) + 0.1'},'Location','southwest')
