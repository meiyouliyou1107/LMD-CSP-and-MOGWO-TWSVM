clc;   clear all;
% load syddata.mat
% load label.mat
% data=syddata;
% [bestacc,bestc,bestg] = SVMcgForClass(label,data,-10,10,-10,10);
% disp('��ӡ����ѡ����');
% str = sprintf( 'Best Cross Validation Accuracy = %g%% Best c = %g Best g = %g',bestacc,bestc,bestg);
% % disp(str);
% % [bestacc,bestc,bestg] = SVMcgForClass(label,data,-2,4,-4,4,3,0.5,0.5,0.9);
% % % ��ӡ��ϸѡ����
% % disp('��ӡ��ϸѡ����');
% % str = sprintf( 'Best Cross Validation Accuracy = %g%% Best c = %g Best g = %g',bestacc,bestc,bestg);
% % disp(str);
% c1=6.72;
% c2=7.70;
c1=3.6423;
c2=1.6685;
lamda=7.0688;
% data=xlsread('C:\Users\LJX\Desktop\��������1217\15.xlsx');
% data=data(1:90,:);  
data=xlsread('C:\Users\LJX\Desktop\ѧ����������\14\A.xlsx');
% data=xlsread('C:\Users\LJX\Desktop\ѧ����������\TDP\D1.xlsx');
% data=xlsread('C:\Users\LJX\Desktop\����������\EMD+CSP\����B.xlsx');
% data=xlsread('C:\Users\LJX\Desktop\����������\LMD2����+CSP\����A.xlsx');
load label.mat
% label(1:20)=1;
% label(21:40)=2;
% % label(41:60)=3;
% % label(61:80)=4;
% label=label';
% label(1:15)=1;
% label(16:30)=2;
% label(31:45)=3;
% label=label';
% [averageAcc,averageAcc1,averageAcc2,averageAcc3]=tenCrossTest(label,data,[c1,c2;c1,c2;c1,c2;c1,c2;c1,c2;c1,c2],struct('type','gauss','width',lamda));
[averageAcc,averageAcc1,averageAcc2,averageAcc3]=tenCrossTest(label,data,[c1,c2;c1,c2;c1,c2],struct('type','gauss','width',lamda));
% tenCrossTest(label,data,[c1,c2;c1,c2],struct('type','gauss','width',lamda));

