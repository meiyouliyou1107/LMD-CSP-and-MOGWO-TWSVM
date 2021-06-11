function [w1,w2] = TWSVMtrain(data_op,data_ng,c1,c2)

A=data_op;
B=data_ng;
q=size(A,1);S=size(B,1);   %���ص��Ǿ���A��B������
e1=ones(q,1);e2=ones(S,1); %����ȫ1����e1��e2
% ����H,G
H=[A,e1]; %����H�����ھ���A��߼���һ��e1
G=[B,e2]; %����G�����ھ���B��߼���һ��e2
Q=G/(H'*H+0.05*eye(size(H'*H,1)))*G';  % S*S   eye��a������һ��a*a�ĵ�λ����   a/b��ʾa����b����
Q1=(H'*H+0.05*eye(size(H'*H,1)))\G';   % l1*S   a\b��ʾa�������b
% ��������f
f=-e2;     
% ��������
lb=zeros(S,1);   %����һ��S*1�ľ���
ub=c1*ones(S,1);  
% ������ʼ��x0
x0=zeros(S,1);   %����һ��S*1�ľ���
% �����Ž�x
[x,~,~]=quadprog(Q,f,[],[],[],[],lb,ub,x0);
% �������
% H �� ���ι滮�еĶ��������
% f �� ���ι滮�е�һ��������
% Aineq �� ���Բ���Լ����ϵ������
% bineq �� ���Բ���Լ�����Ҷ�����
% Aeq �� ���Ե�ʽԼ����ϵ������
% beq �� ���Ե�ʽԼ�����Ҷ�����
% lb �� �Ա����½�Լ��
% ub �� �Ա����Ͻ�Լ��
% x0 �� ��ʼ��
% solver �� �������Ϊ��quadprog��
% options �� options�ṹ

%�������
% x �� ���Ž�
% fval �� ���ؽ�x����Ŀ�꺯��ֵ
% exitflag �� ����������˳�����

w1=-Q1*x;



% ����H,G
G=[A,e1];
H=[B,e2];
Q=G/(H'*H+0.05*eye(size(H'*H,1)))*G';
Q1=(H'*H+0.05*eye(size(H'*H,1)))\G';
% ��������f
f=-e1;
% ��������
lb=zeros(q,1);
ub=c2*ones(q,1);
% ������ʼ��x0
x0=zeros(q,1);
% �����Ž�x
[x,~,~]=quadprog(Q,f,[],[],[],[],lb,ub,x0);
w2=-Q1*x;

end