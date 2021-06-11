function [bestacc,bestc,bestg] = SVMcgForClass(label,data,cmin,cmax,gmin,gmax,v,cstep,gstep,accstep,ker)

if nargin < 10
    accstep = 4.5;
end
if nargin < 8
    cstep = 0.4;
    gstep = 0.4;
end
if nargin < 7
    v = 5;
end
if nargin < 5
    gmax = 8;
    gmin = -8;
end
if nargin < 3
    cmax = 8;
    cmin = -8;
end
% X:c Y:g cg:CVaccuracy
[X,Y] = meshgrid(cmin:cstep:cmax,gmin:gstep:gmax);
[m,n] = size(X);
cg = zeros(m,n);

% eps = 10^(-4);
eps = 10;
% record acc with different c & g,and find the bestacc with the smallest c
bestc = 1;
bestg = 0.1;
bestacc = 0;
basenum = 2;
for i = 1:m
    for j = 1:n
        cmd = [v, basenum^X(i,j), basenum^Y(i,j);v, basenum^X(i,j), basenum^Y(i,j)];
        c1=basenum^X(i,j);
        c2=basenum^Y(i,j);
   
       averageAcc=tenCrossTest(label,data,[1,c1,c2;4,c1,c2],struct('type','gauss'));
        cg(i,j)=averageAcc*100;
        if cg(i,j) <= 50
            continue;
        end
        
        if cg(i,j) > bestacc
            bestacc = cg(i,j);
            bestc = basenum^X(i,j);
            bestg = basenum^Y(i,j);
        end        
        
%         if abs( cg(i,j)-bestacc )<=eps %&& bestc > basenum^X(i,j) 
%             bestacc = cg(i,j);
%             bestc = basenum^X(i,j);
%             bestg = basenum^Y(i,j);
%         end        
        
    end
end
% to draw the acc with different c & g
figure;
[C,h] = contour(X,Y,cg,70:accstep:100);
clabel(C,h,'Color','r');
xlabel('log2c','FontSize',12);
ylabel('log2g','FontSize',12);
firstline = 'SVC参数选择结果图(等高线图)[GridSearchMethod]'; 
secondline = ['Best c=',num2str(bestc),' g=',num2str(bestg), ...
    ' CVAccuracy=',num2str(bestacc),'%'];
title({firstline;secondline},'Fontsize',12);
grid on; 

figure;
meshc(X,Y,cg);
% mesh(X,Y,cg);
% surf(X,Y,cg);
axis([cmin,cmax,gmin,gmax,30,100]);
xlabel('log2c','FontSize',12);
ylabel('log2g','FontSize',12);
zlabel('Accuracy(%)','FontSize',12);
firstline = 'SVC参数选择结果图(3D视图)[GridSearchMethod]'; 
secondline = ['Best c=',num2str(bestc),' g=',num2str(bestg), ...
    ' CVAccuracy=',num2str(bestacc),'%'];
title({firstline;secondline},'Fontsize',12);



