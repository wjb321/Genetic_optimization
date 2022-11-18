opts = detectImportOptions('E:\jiabin_github\Matlab_optimization\betragen.csv');
preview('E:\jiabin_github\Matlab_optimization\betragen.csv',opts)
opts.SelectedVariableNames = [1,2]; 
img = imread('C:\Users\hoshiraku\Desktop\666.jpg');
% 设置图片在绘制时的尺寸
min_x = 0;
max_x = 52.5;
min_y = 0;
max_y = 20;
%opts.DataRange = 'A5';
x1 = readmatrix('E:\jiabin_github\Matlab_optimization\betragen.csv', 'Range','A1:A8192');
y1 = readmatrix('E:\jiabin_github\Matlab_optimization\betragen.csv', 'Range','B1:B8192');
x2 = readmatrix('E:\jiabin_github\Matlab_optimization\betragen.csv', 'Range','C1:C8192');
y2 = readmatrix('E:\jiabin_github\Matlab_optimization\betragen.csv', 'Range','D1:D8192');
x3 = readmatrix('E:\jiabin_github\Matlab_optimization\betragen.csv', 'Range','E1:E8192');
y3 = readmatrix('E:\jiabin_github\Matlab_optimization\betragen.csv', 'Range','F1:F8192');
figure
ax = gca;
%ax.YAxisLocation = 'right';
ax.YAxisLocation = 'origin';
%imagesc([min_x max_x], [min_y max_y], flip(img,1));
%set(gca,'XTick',(-5:0.5:4)) 
%hold on;
H = plot(x1,1000*y1,x2,1000*y2,x3,1000*y3 )
%set(gca,'XAxisLocation','origin','YAxisLocation','origin')
hl = legend(H([1 2 3]),'1','2','3');
set(hl,'Orientation','horizon')
legend({'I(D1)','I(D2)','I(D3)'},'Location','southoutside')
title('liubingqing')
xlabel('Spannung über Diode / V')
ylabel('Diodenstrom / mA')
