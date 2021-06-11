function [averageAcc,averageAcc1,averageAcc11,averageAcc12,averageAcc13,averageAcc2,averageAcc21,averageAcc22,averageAcc23,averageAcc3,averageAcc31,averageAcc32,averageAcc33]=tenCrossTest(label,data,param,ker)
% ��һ��һ��Twin support vector machine ʮ������֤
%  ���룺label:���ݱ�ǩ
%        data��ѵ������
%        param:����,������һ������Ҳ������һ��������ʽΪÿһ����������ָ��һ�����
%        ker���˺���struct��'type',kernelType,['width',kernelparameter]��
%         'linear'���Ժˣ���gauss����˹RBF��
%        ���ӣ�clc;   clear;
%              load('wine.mat');
%              tenCrossTest(label,data,1,struct('type','linear'));
%
%        Written in JLIIP, School of Compuer Science and
%        Technology,CUMT,Xuzhou
warning('off')                            %�رվ���
%�������ݱ�ǩ�����������Ϊ5��
indices = crossvalind('Kfold',label,5); 
% �������һ������N���۲�������K��fold����Ϊ�ۣ��С��㡱֮��ĺ��壬�о�����Ӣ����˼�����󣩵ı�ǣ�indices����
% �ñ���к�����ͬ�����߽�����ͬ��������1��K��ֵ����������ΪK�������Ӽ�����K-fold��������У�K-1��fold����ѵ����
% ʣ�µ�һ���������ԡ��˹���ѭ��K�Σ�ÿ��ѡȡ��ͬ��fold��Ϊ���Լ���K��ȱʡֵΪ5��

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
% x1 = [1*ones(8,1);2*ones(8,1);3*ones(8,1)];     % �ر�ע�⣺�����Ŀ���������粻ͬ 
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


    testindx = (indices==k); trainindx = (indices~=k);% == �����ж��������ߵ�ֵ�Ƿ���ȣ�~=�����ж����������Ƿ����
    trainingdata = data(trainindx,:);  %ѵ��������
    testdata = data(testindx,:);   %���Լ�����
    traininglabel = label(trainindx,:);  %ѵ������ǩ
    testlabel = label(testindx,:);   %���Լ���ǩ
  
    model = OvO_TSVM(traininglabel,trainingdata,param,ker);     % ѵ��
    [~,acc,acc1,acc11,acc12,acc13,acc2,acc21,acc22,acc23,acc3,acc31,acc32,acc33]= OvOTSVMpredict(testlabel,testdata,model);          % ����
   
    accsum = accsum+acc;  %ÿ�ε�׼ȷ�����
    accsum1 = accsum1+acc1;  %ÿ�ε�׼ȷ�����
    accsum11 = accsum11+acc11; 
    accsum12= accsum12+acc12; 
    accsum13 = accsum13+acc13; 
    accsum2 = accsum2+acc2;  %ÿ�ε�׼ȷ�����
    accsum21 = accsum21+acc21; 
    accsum22= accsum22+acc22; 
    accsum23 = accsum23+acc23; 
    
    accsum3 = accsum3+acc3;  %ÿ�ε�׼ȷ�����
    accsum31 = accsum31+acc31; 
    accsum32= accsum32+acc32; 
    accsum33 = accsum33+acc33; 
    count=count+1;        %������1
end
averageAcc=accsum/count;          % ����ƽ��׼ȷ��
averageAcc1=accsum1/count;          % ����ƽ��׼ȷ��
averageAcc11=accsum11/count;          % ����ƽ��׼ȷ��
averageAcc12=accsum12/count;          % ����ƽ��׼ȷ��
averageAcc13=accsum13/count;          % ����ƽ��׼ȷ��


averageAcc2=accsum2/count;          % ����ƽ��׼ȷ��
averageAcc21=accsum21/count;          % ����ƽ��׼ȷ��
averageAcc22=accsum22/count;          % ����ƽ��׼ȷ��
averageAcc23=accsum23/count;          % ����ƽ��׼ȷ��

averageAcc3=accsum3/count;          % ����ƽ��׼ȷ��
averageAcc31=accsum31/count;          % ����ƽ��׼ȷ��
averageAcc32=accsum32/count;          % ����ƽ��׼ȷ��
averageAcc33=accsum33/count;          % ����ƽ��׼ȷ��


time=toc/count;                   % ƽ����ʱ
disp(time);                       % ��ʾ��ʱ
str = sprintf( 'OvO-TSVM Average Accuracy = %g%% ',averageAcc*100);
disp(str);                        % ��ʾƽ��׼ȷ��
end

            
            
        

