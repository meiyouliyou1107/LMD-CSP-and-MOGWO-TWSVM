function model = OvO_TSVM(label,data,c,ker,n_class)
% ‘一对一’Twin support vector machine 十折交叉验证
%  输入：label:数据标签
%        data：训练数据
%        c:参数,可以是一个数，也可以以一个矩阵形式为每一个二分类器指定一组参数
%        ker：核函数struct｛'type',kernelType,['width',kernelparameter]｝
%         'linear'线性核，‘gauss’高斯RBF核
% 输出：model：结构体，用作function [prel,accuracy] = OvOTSVMpredict(label_test,data_test,model)
%              的输入
%        Written in JLIIP, School of Compuer Science and
%        Technology,CUMT,Xuzhou
if nargin<5                        %如果输入参数少于5个
    n_class=length(unique(label));   %unique找出label中不重复的值，在此处应为类别数量
end
if nargin<4          %如果输入参数少于四个
    ker.type = 'linear';   %核函数就默认为  linear 函数
end
if nargin<3   %如果输入参数少于3个
    c=1;       %默认参数 c = 1  
end
[cn1,cn2]=size(c);  %当有两个输出参数时，size函数将矩阵的行数返回到第一个输出变量cn1，将矩阵的列数返回到第二个输出变量cn2。
if cn1==1&&cn2==1       %如果cn1=1且cn2=1
    c=c*ones(n_class,n_class);  %ones 返回一个N*N的全1矩阵
end


if strcmp(ker.type,'linear')  %判断核函数是否是 linear
    data1 = data;
else if strcmp(ker.type,'gauss')  %判断核函数是否是 gauss
    data1=ker_Gaussian(data,data,ker);  %跳转到 ker_Gaussian 函数
    end
end

v1=[]; v2=[];
for i = 1:1:n_class-1     %循环从 1 到 类别数-1
    for j= i+1:1:n_class   %循环从 2 到 类别数
        data_op = data1(label==i,:); %data_op的值为  data1中当label等于i时取行，所有列
        data_ng = data1(label==j,:); %data_ng的值为  data1中当label等于j时取行，所有列
        %label_temp=[ones(size(data_op,1),1);ones(size(data_ng,1),1)];
%         [w1,w2] = TWSVMtrain(data_op,data_ng,c(i,j));
        [w1,w2] = TWSVMtrain(data_op,data_ng,c(i,1),c(i,2));
        v1=[v1,w1];
        v2=[v2,w2];
    end
end
if strcmp(ker.type,'linear')  %判断核函数是否是 linear
    model.v1=v1;
    model.v2=v2;
    model.ker= ker;
    model.n_class=n_class;
    model.label=label;
else if strcmp(ker.type,'gauss') %判断核函数是否是 gauss
    model.v1=v1;
    model.v2=v2;
    model.ker= ker;
    model.n_class=n_class;
    model.data = data; 
    model.label=label;
    end
end

end

% function [w1,w2] = TWSVMtrain(data_op,data_ng,c)
% 
% A=data_op;
% B=data_ng;
% q=size(A,1);S=size(B,1);
% e1=ones(q,1);e2=ones(S,1); 
% % 计算H,G
% H=[A,e1];
% G=[B,e2];
% Q=G/(H'*H+0.05*eye(size(H'*H,1)))*G';  % S*S
% Q1=(H'*H+0.05*eye(size(H'*H,1)))\G';   % l1*S
% % 产生矩阵f
% f=-e2;
% % 变量限制
% lb=zeros(S,1);
% ub=c*ones(S,1);
% % 产生初始点x0
% x0=zeros(S,1);
% % 求最优解x
% [x,~,~]=quadprog(Q,f,[],[],[],[],lb,ub,x0);
% w1=-Q1*x;
% 
% 
% 
% % 计算H,G
% G=[A,e1];
% H=[B,e2];
% Q=G/(H'*H+0.05*eye(size(H'*H,1)))*G';
% Q1=(H'*H+0.05*eye(size(H'*H,1)))\G';
% % 产生矩阵f
% f=-e1;
% % 变量限制
% lb=zeros(q,1);
% ub=c*ones(q,1);
% % 产生初始点x0
% x0=zeros(q,1);
% % 求最优解x
% [x,~,~]=quadprog(Q,f,[],[],[],[],lb,ub,x0);
% w2=-Q1*x;
% 
% end