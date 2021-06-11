% % % % % % %%LMD2分量+CSP
% % % clear all
% % % load F_car_butterworth.mat
% % % %第一类
% % % aa=b_car_butterworth;
% % % for i=1:20
% % %     a_pud(:,:,i)=flipud(aa(1:384,:,i));
% % %     a(385:768,:,i)=aa(:,:,i);
% % %     a(1:384,:,i)=a_pud(:,:,i);
% % %     a(769:1152,:,i)=a_pud(:,:,i);
% % % end
% % % for q=1:20
% % %     for i=1:4
% % %         a_PF=LMD(a(:,i,q));
% % %         a_allPF(2*(i-1)+1:2*(i-1)+2,:,q)=a_PF(1:2,:);
% % %     end
% % % end
% % % 
% % % %第二类
% % % bb=c_car_butterworth;
% % % for i=1:20
% % %     b_pud(:,:,i)=flipud(bb(:,:,i));
% % %     b(385:768,:,i)=bb(:,:,i);
% % %     b(1:384,:,i)=a_pud(:,:,i);
% % %     b(769:1152,:,i)=a_pud(:,:,i);
% % % end
% % % for q=1:20
% % %     for i=1:4
% % %         b_PF=LMD(b(:,i,q));
% % %         b_allPF(2*(i-1)+1:2*(i-1)+2,:,q)=b_PF(1:2,:);
% % %     end
% % % end
% % % %%CSP提取特征
% % % 
% % % s=zeros(8,8);e=zeros(8,8);
% % % for i=1:20
% % %     Xz=a_allPF(:,:,i);
% % %     Yz=b_allPF(:,:,i);
% % %     Rx=(Xz*Xz')/trace(Xz*Xz');
% % %     Ry=(Yz*Yz')/trace(Yz*Yz');
% % %     s=s+Rx;
% % %     e=e+Ry;
% % % end
% % % Rx=s/20;
% % % Ry=e/20;
% % % 
% % % R=(Rx+Ry);
% % % [U,Lambda] = eig(R);% 求矩阵R的全部特征值，构成对角阵Lambda，并求A的特征向量构成U的列向量
% % % [Lambda,ind] = sort(diag(Lambda),'descend');%对特征值进行降序排列
% % % U=U(:,ind);
% % % P=sqrt(inv(diag(Lambda)))*U';
% % % S1=P*Rx*P';
% % % S2=P*Ry*P';
% % % [B,G] = eig(S1,S2); %由eig(S1,S2)返回方阵S1和S2的N个广义特征值，构成N×N阶对角阵G，
% % %                     %其对角线上的N个元素即为相应的广义特征值，同时将返回相应的特征向量构成N×N阶满秩矩阵
% % %                     %且满足S1B=S2BG。
% % % [G,ind] = sort(diag(G)); 
% % % B = B(:,ind);
% % % W=(B'*P);
% % % w=W([1:2 7:8],:);
% % % %filtered and projected EEGs
% % % for i=1:20
% % %     Zp1(1+(i-1)*4:4*i,:)=w*a_allPF(:,:,i);
% % %     VarZp1(i,:)=var(Zp1(1+(i-1)*4:4*i,:),1,2);
% % %     Sum_VarZp1(i)=sum(VarZp1(i,:));
% % %     for k=1:4
% % %         fp1(i,k)=log(VarZp1(i,k)/Sum_VarZp1(i)); 
% % %     end
% % % end
% % % 
% % % for i=1:20
% % %      Zp2(1+(i-1)*4:4*i,:)=w*b_allPF(:,:,i);
% % %     VarZp2(i,:)=var(Zp2(1+(i-1)*4:4*i,:),1,2);
% % %     Sum_VarZp2(i)=sum(VarZp2(i,:));
% % %     for k=1:4
% % %         fp2(i,k)=log(VarZp2(i,k)/Sum_VarZp2(i)); 
% % %     end  
% % % end
% % % x=1:1:20;
% % % subplot(4,1,1)
% % % plot(x,fp1(:,1),x,fp2(:,1));
% % % xlabel('f1(1)')
% % % subplot(4,1,2)
% % % plot(x,fp1(:,2),x,fp2(:,2));
% % % xlabel('f1(2)')
% % % subplot(4,1,3)
% % % plot(x,fp1(:,3),x,fp2(:,3));
% % % xlabel('f1(3)')
% % % subplot(4,1,4)
% % % plot(x,fp1(:,4),x,fp2(:,4));
% % % xlabel('f1(4)')


% % % %%emd+csp
% % % clear all
% % % load k3b_car_butterworth.mat
% % % %第一类
% % % a=c_car_butterworth;
% % % for q=1:45
% % %     for i=1:5
% % %         a_PF=emd(a(:,i,q));
% % %         a_allPF(:,2*(i-1)+1:2*(i-1)+2,q)=a_PF(:,1:2);
% % %     end
% % % end
% % % %第二类
% % % b=d_car_butterworth;
% % % for q=1:45
% % %     for i=1:5
% % %         b_PF=emd(b(:,i,q));
% % %         b_allPF(:,2*(i-1)+1:2*(i-1)+2,q)=b_PF(:,1:2);
% % %     end
% % % end
% % % %%CSP提取特征
% % % 
% % % s=zeros(10,10);e=zeros(10,10);
% % % for i=1:45
% % %     Xz=permute(a_allPF(:,:,i),[2,1,3]);
% % %     Yz=permute(b_allPF(:,:,i),[2,1,3]);
% % %     Rx=(Xz*Xz')/trace(Xz*Xz');
% % %     Ry=(Yz*Yz')/trace(Yz*Yz');
% % %     s=s+Rx;
% % %     e=e+Ry;
% % % end
% % % Rx=s/45;
% % % Ry=e/45;
% % % 
% % % R=(Rx+Ry);
% % % [U,Lambda] = eig(R);% 求矩阵R的全部特征值，构成对角阵Lambda，并求A的特征向量构成U的列向量
% % % [Lambda,ind] = sort(diag(Lambda),'descend');%对特征值进行降序排列
% % % U=U(:,ind);
% % % P=sqrt(inv(diag(Lambda)))*U';
% % % S1=P*Rx*P';
% % % S2=P*Ry*P';
% % % [B,G] = eig(S1,S2); %由eig(S1,S2)返回方阵S1和S2的N个广义特征值，构成N×N阶对角阵G，
% % %                     %其对角线上的N个元素即为相应的广义特征值，同时将返回相应的特征向量构成N×N阶满秩矩阵
% % %                     %且满足S1B=S2BG。
% % % [G,ind] = sort(diag(G)); 
% % % B = B(:,ind);
% % % W=(B'*P);
% % % w=W([1:2 9:10],:);
% % % %filtered and projected EEGs
% % % for i=1:45
% % %     Zp1(1+(i-1)*4:4*i,:)=w*permute(a_allPF(:,:,i),[2,1,3]);
% % %     VarZp1(i,:)=var(Zp1(1+(i-1)*4:4*i,:),1,2);
% % %     Sum_VarZp1(i)=sum(VarZp1(i,:));
% % %     for k=1:4
% % %         fp1(i,k)=log(VarZp1(i,k)/Sum_VarZp1(i)); 
% % %     end
% % % end
% % % 
% % % for i=1:45
% % %      Zp2(1+(i-1)*4:4*i,:)=w*permute(b_allPF(:,:,i),[2,1,3]);
% % %     VarZp2(i,:)=var(Zp2(1+(i-1)*4:4*i,:),1,2);
% % %     Sum_VarZp2(i)=sum(VarZp2(i,:));
% % %     for k=1:4
% % %         fp2(i,k)=log(VarZp2(i,k)/Sum_VarZp2(i)); 
% % %     end  
% % % end
% % % x=1:1:45;
% % % subplot(4,1,1)
% % % plot(x,fp1(:,1),x,fp2(:,1));
% % % xlabel('f1(1)')
% % % subplot(4,1,2)
% % % plot(x,fp1(:,2),x,fp2(:,2));
% % % xlabel('f1(2)')
% % % subplot(4,1,3)
% % % plot(x,fp1(:,3),x,fp2(:,3));
% % % xlabel('f1(3)')
% % % subplot(4,1,4)
% % % plot(x,fp1(:,4),x,fp2(:,4));
% % % xlabel('f1(4)')

% % % %%LMD1分量+csp
clear all
load data17.mat
%第一类
aa=b_car_butterworth;
% % a_allPF=permute(c_car_butterworth,[2,1,3]);
for i=1:20
    a_pud(:,:,i)=flipud(aa(1:384,:,i));
    a(385:768,:,i)=aa(:,:,i);
    a(1:384,:,i)=a_pud(:,:,i);
    a(769:1152,:,i)=a_pud(:,:,i);
end
for q=1:20
    for i=1:14
        a_PF=LMD(a(:,i,q));
        a_allPF(i,:,q)=a_PF(1,385:768);
    end
end
%第二类
bb=c_car_butterworth;
% b_allPF=permute(d_car_butterworth,[2,1,3]);
 for i=1:20
    b_pud(:,:,i)=flipud(bb(1:384,:,i));
    b(385:768,:,i)=bb(:,:,i);
    b(1:384,:,i)=b_pud(:,:,i);
    b(769:1152,:,i)=b_pud(:,:,i);
end

for q=1:20
    for i=1:14
        b_PF=LMD(b(:,i,q));
        b_allPF(i,:,q)=b_PF(1,385:768);
    end
end



%%CSP提取特征

s=zeros(14,14);e=zeros(14,14);
for i=1:20
    Xz=a_allPF(:,:,i);
    Yz=b_allPF(:,:,i);
    Rx=(Xz*Xz')/trace(Xz*Xz');
    Ry=(Yz*Yz')/trace(Yz*Yz');
    s=s+Rx;
    e=e+Ry;
end
Rx=s/20;
Ry=e/20;

R=(Rx+Ry);
[U,Lambda] = eig(R);% 求矩阵R的全部特征值，构成对角阵Lambda，并求A的特征向量构成U的列向量
[Lambda,ind] = sort(diag(Lambda),'descend');%对特征值进行降序排列
U=U(:,ind);
P=sqrt(inv(diag(Lambda)))*U';
S1=P*Rx*P';
S2=P*Ry*P';
[B,G] = eig(S1,S2); %由eig(S1,S2)返回方阵S1和S2的N个广义特征值，构成N×N阶对角阵G，
                    %其对角线上的N个元素即为相应的广义特征值，同时将返回相应的特征向量构成N×N阶满秩矩阵
                    %且满足S1B=S2BG。
[G,ind] = sort(diag(G)); 
B = B(:,ind);
W=(B'*P);
w=W([1:4 11:14],:);
%filtered and projected EEGs
for i=1:20
    Zp1(1+(i-1)*8:8*i,:)=w*a_allPF(:,:,i);
    VarZp1(i,:)=var(Zp1(1+(i-1)*8:8*i,:),1,2);
    Sum_VarZp1(i)=sum(VarZp1(i,:));
    for k=1:8
        fp1(i,k)=log(VarZp1(i,k)/Sum_VarZp1(i)); 
    end
end

for i=1:20
     Zp2(1+(i-1)*8:8*i,:)=w*b_allPF(:,:,i);
    VarZp2(i,:)=var(Zp2(1+(i-1)*8:8*i,:),1,2);
    Sum_VarZp2(i)=sum(VarZp2(i,:));
    for k=1:8
        fp2(i,k)=log(VarZp2(i,k)/Sum_VarZp2(i)); 
    end  
end





figure(2)
x=1:1:20;
subplot(4,1,1)
plot(x,fp1(:,1),x,fp2(:,1));
xlabel('f1(1)')
subplot(4,1,2)
plot(x,fp1(:,2),x,fp2(:,2));
xlabel('f1(2)')
subplot(4,1,3)
plot(x,fp1(:,3),x,fp2(:,3));
xlabel('f1(3)')
subplot(4,1,4)
plot(x,fp1(:,4),x,fp2(:,4));
xlabel('f1(4)')
% for i=1:14
%     sc(i)=norm(w(:,i))/norm(w,2);
% end
