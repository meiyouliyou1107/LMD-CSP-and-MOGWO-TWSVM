% function [x, y, Ex, En, He] = cloud_transform(y_spor, n)
% x ��ʾ�ƵΣ� y ��ʾ�����ȣ����������������ȣ��� �����Ƕ���������ȶ��̶ȣ�
% Ex ��ģ�͵�������������ʾ������En ��ģ�͵�������������ʾ�Σ���ʾ���ҳ̶ȵ���������ʵ���Ǵ򲻳����ˣ�������������ˣ���ͬ����
% He ��ģ�͵�������������ʾ����
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
% % ͨ��ͳ����������������ģ�͵���������
% for q = 1:n
%     Enn = randn(1).*He + En;
%     x(q) = randn.*Enn + Ex;
%     y(q) = exp(-(x(q) - Ex).^2./(2.*Enn.^2));
% end
% scatter(x,y)
% set(gca,'XLim',[-0.2 0.2])