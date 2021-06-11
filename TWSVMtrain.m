function [w1,w2] = TWSVMtrain(data_op,data_ng,c1,c2)

A=data_op;
B=data_ng;
q=size(A,1);S=size(B,1);   %返回的是矩阵A、B的行数
e1=ones(q,1);e2=ones(S,1); %生成全1矩阵e1、e2
% 计算H,G
H=[A,e1]; %生成H矩阵，在矩阵A后边加上一列e1
G=[B,e2]; %生成G矩阵，在矩阵B后边加上一列e2
Q=G/(H'*H+0.05*eye(size(H'*H,1)))*G';  % S*S   eye（a）返回一个a*a的单位矩阵   a/b表示a乘以b的逆
Q1=(H'*H+0.05*eye(size(H'*H,1)))\G';   % l1*S   a\b表示a的逆乘以b
% 产生矩阵f
f=-e2;     
% 变量限制
lb=zeros(S,1);   %构建一个S*1的矩阵
ub=c1*ones(S,1);  
% 产生初始点x0
x0=zeros(S,1);   %构建一个S*1的矩阵
% 求最优解x
[x,~,~]=quadprog(Q,f,[],[],[],[],lb,ub,x0);
% 输入变量
% H ： 二次规划中的二次项矩阵
% f ： 二次规划中的一次项向量
% Aineq ： 线性不等约束的系数矩阵
% bineq ： 线性不等约束的右端向量
% Aeq ： 线性等式约束的系数矩阵
% beq ： 线性等式约束的右端向量
% lb ： 自变量下界约束
% ub ： 自变量上界约束
% x0 ： 初始点
% solver ： 求解器，为“quadprog”
% options ： options结构

%输出变量
% x ： 最优解
% fval ： 返回解x处的目标函数值
% exitflag ： 描述计算的退出条件

w1=-Q1*x;



% 计算H,G
G=[A,e1];
H=[B,e2];
Q=G/(H'*H+0.05*eye(size(H'*H,1)))*G';
Q1=(H'*H+0.05*eye(size(H'*H,1)))\G';
% 产生矩阵f
f=-e1;
% 变量限制
lb=zeros(q,1);
ub=c2*ones(q,1);
% 产生初始点x0
x0=zeros(q,1);
% 求最优解x
[x,~,~]=quadprog(Q,f,[],[],[],[],lb,ub,x0);
w2=-Q1*x;

end