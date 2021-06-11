function model = OvO_TSVM(label,data,c,ker,n_class)
% ��һ��һ��Twin support vector machine ʮ�۽�����֤
%  ���룺label:���ݱ�ǩ
%        data��ѵ������
%        c:����,������һ������Ҳ������һ��������ʽΪÿһ����������ָ��һ�����
%        ker���˺���struct��'type',kernelType,['width',kernelparameter]��
%         'linear'���Ժˣ���gauss����˹RBF��
% �����model���ṹ�壬����function [prel,accuracy] = OvOTSVMpredict(label_test,data_test,model)
%              ������
%        Written in JLIIP, School of Compuer Science and
%        Technology,CUMT,Xuzhou
if nargin<5                        %��������������5��
    n_class=length(unique(label));   %unique�ҳ�label�в��ظ���ֵ���ڴ˴�ӦΪ�������
end
if nargin<4          %���������������ĸ�
    ker.type = 'linear';   %�˺�����Ĭ��Ϊ  linear ����
end
if nargin<3   %��������������3��
    c=1;       %Ĭ�ϲ��� c = 1  
end
[cn1,cn2]=size(c);  %���������������ʱ��size������������������ص���һ���������cn1����������������ص��ڶ����������cn2��
if cn1==1&&cn2==1       %���cn1=1��cn2=1
    c=c*ones(n_class,n_class);  %ones ����һ��N*N��ȫ1����
end


if strcmp(ker.type,'linear')  %�жϺ˺����Ƿ��� linear
    data1 = data;
else if strcmp(ker.type,'gauss')  %�жϺ˺����Ƿ��� gauss
    data1=ker_Gaussian(data,data,ker);  %��ת�� ker_Gaussian ����
    end
end

v1=[]; v2=[];
for i = 1:1:n_class-1     %ѭ���� 1 �� �����-1
    for j= i+1:1:n_class   %ѭ���� 2 �� �����
        data_op = data1(label==i,:); %data_op��ֵΪ  data1�е�label����iʱȡ�У�������
        data_ng = data1(label==j,:); %data_ng��ֵΪ  data1�е�label����jʱȡ�У�������
        %label_temp=[ones(size(data_op,1),1);ones(size(data_ng,1),1)];
%         [w1,w2] = TWSVMtrain(data_op,data_ng,c(i,j));
        [w1,w2] = TWSVMtrain(data_op,data_ng,c(i,1),c(i,2));
        v1=[v1,w1];
        v2=[v2,w2];
    end
end
if strcmp(ker.type,'linear')  %�жϺ˺����Ƿ��� linear
    model.v1=v1;
    model.v2=v2;
    model.ker= ker;
    model.n_class=n_class;
    model.label=label;
else if strcmp(ker.type,'gauss') %�жϺ˺����Ƿ��� gauss
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
% % ����H,G
% H=[A,e1];
% G=[B,e2];
% Q=G/(H'*H+0.05*eye(size(H'*H,1)))*G';  % S*S
% Q1=(H'*H+0.05*eye(size(H'*H,1)))\G';   % l1*S
% % ��������f
% f=-e2;
% % ��������
% lb=zeros(S,1);
% ub=c*ones(S,1);
% % ������ʼ��x0
% x0=zeros(S,1);
% % �����Ž�x
% [x,~,~]=quadprog(Q,f,[],[],[],[],lb,ub,x0);
% w1=-Q1*x;
% 
% 
% 
% % ����H,G
% G=[A,e1];
% H=[B,e2];
% Q=G/(H'*H+0.05*eye(size(H'*H,1)))*G';
% Q1=(H'*H+0.05*eye(size(H'*H,1)))\G';
% % ��������f
% f=-e1;
% % ��������
% lb=zeros(q,1);
% ub=c*ones(q,1);
% % ������ʼ��x0
% x0=zeros(q,1);
% % �����Ž�x
% [x,~,~]=quadprog(Q,f,[],[],[],[],lb,ub,x0);
% w2=-Q1*x;
% 
% end