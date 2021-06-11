function [averageAcc,averageAcc1,averageAcc11,averageAcc12,averageAcc13,averageAcc2,averageAcc21,averageAcc22,averageAcc23,averageAcc3,averageAcc31,averageAcc32,averageAcc33]=tenCrossTest(label,data,param,ker)
% ‘一对一’Twin support vector machine 十交叉验证
%  输入：label:数据标签
%        data：训练数据
%        param:参数,可以是一个数，也可以以一个矩阵形式为每一个二分类器指定一组参数
%        ker：核函数struct｛'type',kernelType,['width',kernelparameter]｝
%         'linear'线性核，‘gauss’高斯RBF核
%        例子：clc;   clear;
%              load('wine.mat');
%              tenCrossTest(label,data,1,struct('type','linear'));
%
%        Written in JLIIP, School of Compuer Science and
%        Technology,CUMT,Xuzhou
warning('off')                            %关闭警告
%根据数据标签将数据随机分为5组
indices = crossvalind('Kfold',label,5); 
% 该命令返回一个对于N个观察样本的K个fold（意为折，有“层”之类的含义，感觉还是英文意思更形象）的标记（indices）。
% 该标记中含有相同（或者近似相同）比例的1—K的值，将样本分为K个相斥的子集。在K-fold交叉检验中，K-1个fold用来训练，
% 剩下的一个用来测试。此过程循环K次，每次选取不同的fold作为测试集。K的缺省值为5。

tic
count=0;
accsum=0;
accsum1=0;accsum11=0;accsum12=0;accsum13=0;
accsum2=0;accsum21=0;accsum22=0;accsum23=0;
accsum3=0;accsum31=0;accsum32=0;accsum33=0;
for k =1:5
% x1_train=data(1:8,:);
% x2_train=data(11:18,:);
% x3_train=data(21:28,:);
% n1 = [x1_train;x2_train;x3_train]; 
% x1 = [1*ones(8,1);2*ones(8,1);3*ones(8,1)];     % 特别注意：这里的目标与神经网络不同 
%  
% x1_test=data(9:10,:);
% x2_test=data(19:20,:);
% x3_test=data(29:30,:);
% n2 = [x1_test;x2_test;x3_test]; 
% x2 = [1*ones(2,1);2*ones(2,1);3*ones(2,1)];
% trainingdata = n1;
% testdata = n2;
% traininglabel = x1;
% testlabel = x2;


    testindx = (indices==k); trainindx = (indices~=k);% == 用于判断左右两边的值是否相等，~=用于判断左右两边是否不相等
    trainingdata = data(trainindx,:);  %训练集数据
    testdata = data(testindx,:);   %测试集数据
    traininglabel = label(trainindx,:);  %训练集标签
    testlabel = label(testindx,:);   %测试集标签
  
    model = OvO_TSVM(traininglabel,trainingdata,param,ker);     % 训练
    [~,acc,acc1,acc11,acc12,acc13,acc2,acc21,acc22,acc23,acc3,acc31,acc32,acc33]= OvOTSVMpredict(testlabel,testdata,model);          % 测试
   
    accsum = accsum+acc;  %每次的准确率相加
    accsum1 = accsum1+acc1;  %每次的准确率相加
    accsum11 = accsum11+acc11; 
    accsum12= accsum12+acc12; 
    accsum13 = accsum13+acc13; 
    accsum2 = accsum2+acc2;  %每次的准确率相加
    accsum21 = accsum21+acc21; 
    accsum22= accsum22+acc22; 
    accsum23 = accsum23+acc23; 
    
    accsum3 = accsum3+acc3;  %每次的准确率相加
    accsum31 = accsum31+acc31; 
    accsum32= accsum32+acc32; 
    accsum33 = accsum33+acc33; 
    count=count+1;        %次数加1
end
averageAcc=accsum/count;          % 计算平均准确率
averageAcc1=accsum1/count;          % 计算平均准确率
averageAcc11=accsum11/count;          % 计算平均准确率
averageAcc12=accsum12/count;          % 计算平均准确率
averageAcc13=accsum13/count;          % 计算平均准确率


averageAcc2=accsum2/count;          % 计算平均准确率
averageAcc21=accsum21/count;          % 计算平均准确率
averageAcc22=accsum22/count;          % 计算平均准确率
averageAcc23=accsum23/count;          % 计算平均准确率

averageAcc3=accsum3/count;          % 计算平均准确率
averageAcc31=accsum31/count;          % 计算平均准确率
averageAcc32=accsum32/count;          % 计算平均准确率
averageAcc33=accsum33/count;          % 计算平均准确率


time=toc/count;                   % 平均耗时
disp(time);                       % 显示耗时
str = sprintf( 'OvO-TSVM Average Accuracy = %g%% ',averageAcc*100);
disp(str);                        % 显示平均准确率
end

            
            
        

