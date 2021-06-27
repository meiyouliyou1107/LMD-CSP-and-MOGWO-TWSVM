% function [x, y, Ex, En, He] = cloud_transform(y_spor, n)
% x 表示云滴， y 表示隶属度（这里是钟型隶属度）， 意义是度量倾向的稳定程度；
% Ex 云模型的数字特征，表示期望；En 云模型的数字特征，表示滴（表示混乱程度的物理量，实在是打不出来了，就用这个代替了，下同）；
% He 云模型的数字特征，表示超滴
clear all
load data_aa.mat
yy=aa_car_butterworth(:,:,11);
y_spor=LMD(yy);
y_spor=y_spor(3,:)
% y_spor=k3b_1(:,40,2);
% y_spor=imf(:,2);
% n=1000;
Ex = mean(y_spor);
En = mean(abs(y_spor - Ex)).*sqrt(pi./2);
He = sqrt(var(y_spor) - En.^2);





% load B_car_butterworth.mat
% yy=a_car_butterworth(:,:,5);
% y_spor=LMD(yy);
% y_spor=y_spor(3,:)
% % y_spor=k3b_1(:,40,2);
% % y_spor=imf(:,2);
% % n=1000;
% Ex = mean(y_spor);
% En = mean(abs(y_spor - Ex)).*sqrt(pi./2);
% He = sqrt(var(y_spor) - En.^2);




% 
% Ex=-0.01;
% En=0.0408;
% He=0.0043;
% n=384;
% % 通过统计数据样本计算云模型的数字特征
% for q = 1:n
%     Enn = randn(1).*He + En;
%     x(q) = randn.*Enn + Ex;
%     y(q) = exp(-(x(q) - Ex).^2./(2.*Enn.^2));
% end
% scatter(x,y)
% set(gca,'XLim',[-0.2 0.2])