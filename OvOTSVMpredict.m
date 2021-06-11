function [prel,accuracy,accuracy1,accuracy11,accuracy12,accuracy13,accuracy2,accuracy21,accuracy22,accuracy23,accuracy3,accuracy31,accuracy32,accuracy33] = OvOTSVMpredict(label_test,data_test,model)
% function [prel,accuracy] = OvOTSVMpredict(label_test,data_test,model)
v1=model.v1;
v2=model.v2;
ker = model.ker;
uuu=3;
if strcmp(ker.type,'linear') %判断核函数是否是 linear
    data=data_test;
else if strcmp(ker.type,'gauss') %判断核函数是否是 gauss
    data_trn = model.data;
    data = ker_Gaussian(data_test,data_trn,ker); 
    end
end


n_class = model.n_class; 
n1=size(data,1);  %返回data的行数

vote=zeros(n1,n_class); %构建一个n1×n_class的零矩阵
kk=1;
for i=1:n_class-1  %从1到类别数-1
    for j=i+1:n_class  %从2到类别数
        
        pre = predictor(data,v1(:,kk),v2(:,kk),n1); %自编函数，见下方
        
        indx1= find(pre==1); %找到pre中等于1的元素的位置
        indx2= find(pre==-1);%找到pre中等于-1的元素的位置
        vote(indx1,i)=vote(indx1,i)+1; %
        vote(indx2,j)=vote(indx2,j)+1;
        kk=kk+1;
    end
end
[~,prel]=max(vote,[],2);
acck=0;
%三类平均值
for po=1:n1
    if label_test(po)==prel(po)
        acck=acck+1;
    end
end
accuracy=acck/n1;
%第一类准确率
acck1=0;
for po=1:uuu
    if label_test(po)==prel(po)
        acck1=acck1+1;
    end
end
accuracy1=acck1/uuu;
%求混淆矩阵
acck11=0;
for po=1:uuu
    if prel(po)==1
        acck11=acck11+1;
    end
end
accuracy11=acck11/uuu;

acck12=0;
for po=1:uuu
    if prel(po)==2
        acck12=acck12+1;
    end
end
accuracy12=acck12/uuu;

acck13=0;
for po=1:uuu
    if prel(po)==3
        acck13=acck13+1;
    end
end
accuracy13=acck13/uuu;




%第2类准确率
acck2=0;
for po=uuu+1:2*uuu
    if label_test(po)==prel(po)
        acck2=acck2+1;
    end
end
accuracy2=acck2/uuu;

acck21=0;
for po=uuu+1:2*uuu
    if prel(po)==1
        acck21=acck21+1;
    end
end
accuracy21=acck21/uuu;

acck22=0;
for po=uuu+1:2*uuu
    if prel(po)==2
        acck22=acck22+1;
    end
end
accuracy22=acck22/uuu;

acck23=0;
for po=uuu+1:2*uuu
    if prel(po)==3
        acck23=acck23+1;
    end
end
accuracy23=acck23/uuu;

%第3类准确率
acck3=0;
for po=2*uuu+1:3*uuu
    if label_test(po)==prel(po)
        acck3=acck3+1;
    end
end
accuracy3=acck3/uuu;

acck31=0;
for po=2*uuu+1:3*uuu
    if prel(po)==1
        acck31=acck31+1;
    end
end
accuracy31=acck31/uuu;

acck32=0;
for po=2*uuu+1:3*uuu
    if prel(po)==2
        acck32=acck32+1;
    end
end
accuracy32=acck32/uuu;

acck33=0;
for po=2*uuu+1:3*uuu
    if prel(po)==3
        acck33=acck33+1;
    end
end
accuracy33=acck33/uuu;
end

function pre = predictor(test_data,v1,v2,n1)


pre=zeros(n1,1); %构建n1×1的零矩阵

dis1=abs([test_data,ones(n1,1)]*v1); %
dis2=abs([test_data,ones(n1,1)]*v2);

dis = min(dis1,dis2); % 取最小值
for i=1:n1   %从1到n1的行数
    if dis(i)==dis1(i) %如果dis()中第i个值与dis1()中dii个值相等 
        pre(i)=1;
    else
        pre(i)=-1;
    end
end
end
        
        
            