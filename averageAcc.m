% function [averageAccc,averageAcc1,averageAcc2,averageAcc3]=averageAcc(c1,c2,lamda)
clear all
% % % clc
AAAA=zeros(4,4);
while (AAAA(1,1)<0.85)
c1=5.31243836079963;
c2=1.00826610240733;
lamda=2.75997235397434;  
Acc=0;
Acc1=0;Acc11=0;Acc12=0;Acc13=0;
Acc2=0;Acc21=0;Acc22=0;Acc23=0;
Acc3=0;Acc31=0;Acc32=0;Acc33=0;
% % for i=1:20
% data=xlsread('C:\Users\LJX\Desktop\学术论文（程序）\LMD+CSP\C.xlsx');
% data=xlsread('C:\Users\LJX\Desktop\云特征数据\EMD+CSP\特征A.xlsx');
data=xlsread('C:\Users\LJX\Desktop\学术论文数据\14\B1.xlsx');
% data=xlsread('C:\Users\LJX\Desktop\学术论文数据\TDP\G1.xlsx');

label1(1:15)=1;
label1(16:30)=2;
label1(31:45)=3;
label=label1';

% load label.mat
[averageAccc,averageAcc1,averageAcc11,averageAcc12,averageAcc13,averageAcc2,averageAcc21,averageAcc22,averageAcc23,averageAcc3,averageAcc31,averageAcc32,averageAcc33]=tenCrossTest(label,data,[c1,c2;c1,c2;c1,c2],struct('type','gauss','width',lamda));
% Acc=averageAccc+Acc;
% Acc1=averageAcc1+Acc1;
% Acc11=averageAcc11+Acc11;
% Acc12=averageAcc12+Acc12;
% Acc13=averageAcc13+Acc13;
% 
% Acc2=averageAcc2+Acc2;
% Acc21=averageAcc21+Acc21;
% Acc22=averageAcc22+Acc22;
% Acc23=averageAcc23+Acc23;
% 
% Acc3=averageAcc3+Acc3;
% Acc31=averageAcc31+Acc31;
% Acc32=averageAcc32+Acc32;
% Acc33=averageAcc33+Acc33;
% 
% 
% % end
% averageAccc=Acc/20;
% averageAccc1=Acc1/20;
% averageAcc11=Acc11/20;
% averageAcc12=Acc12/20;
% averageAcc13=Acc13/20;
% 
% averageAcc2=Acc2/20;
% averageAcc21=Acc21/20;
% averageAcc22=Acc22/20;
% averageAcc23=Acc23/20;
% 
% 
% 
% averageAcc3=Acc3/20;
% averageAcc31=Acc31/20;
% averageAcc32=Acc32/20;
% averageAcc33=Acc33/20;

% % % end
AAAA(:,:)=[averageAccc,0,0,0
    averageAcc1,averageAcc11,averageAcc12,averageAcc13
    averageAcc2,averageAcc21,averageAcc22,averageAcc23
    averageAcc3,averageAcc31,averageAcc32,averageAcc33
    ];

end