function PF=LMD(x)
% 局域均值分析
% x=a_car_butterworth(:,4,1);
c = x';         %转置
N = length(x);  %求数据长度
A = ones(1,N);  %
PF = [];
aii = 2*A;

while(1)

  si = c;
  a = 1;
  
   while(1)
    h = si;
    
      maxVec = [];
      minVec = [];
      
   % look for max and min point
      for i = 2: N - 1
         if h (i - 1) < h (i) & h (i) > h (i + 1)
            maxVec = [maxVec i]; 		
         end
         if h (i - 1) > h (i) & h (i) < h (i + 1)
            minVec = [minVec i]; 		
         end         
      end
      
   % check if it is residual
      if (length (maxVec) + length (minVec)) < 2
         break;
      end
           
  % handle end point 
      lenmax=length(maxVec);
      lenmin=length(minVec);
      %left end point
      if h(1)>0
          if(maxVec(1)<minVec(1))
              yleft_max=h(maxVec(1));
              yleft_min=-h(1);
          else
              yleft_max=h(1);
              yleft_min=h(minVec(1));
          end
      else
          if (maxVec(1)<minVec(1))
              yleft_max=h(maxVec(1));
              yleft_min=h(1);
          else
              yleft_max=-h(1);
              yleft_min=h(minVec(1));
          end
      end
      %right end point
      if h(N)>0
          if(maxVec(lenmax)<minVec(lenmin))
             yright_max=h(N);
             yright_min=h(minVec(lenmin));
          else
              yright_max=h(maxVec(lenmax));
              yright_min=-h(N);
          end
      else
          if(maxVec(lenmax)<minVec(lenmin))
              yright_max=-h(N);
              yright_min=h(minVec(lenmin));
          else
              yright_max=h(maxVec(lenmax));
              yright_min=h(N);
          end
      end
      %get envelop of maxVec and minVec using
      %spline interpolate
      maxEnv=spline([1 maxVec N],[yleft_max h(maxVec) yright_max],1:N);
      minEnv=spline([1 minVec N],[yleft_min h(minVec) yright_min],1:N);
      
    mm = (maxEnv + minEnv)/2;
    aa = abs(maxEnv - minEnv)/2;
    
    mmm = mm;
    aaa = aa;

    preh = h;
    h = h-mmm;
    si = h./aaa;
    a = a.*aaa;    
    
aii = aaa;

    B = length(aii);
    C = ones(1,B);
    bb = norm(aii-C);
    if(bb < 1000)
        break;
    end     
    
   end 
   
  pf = a.*si;
  
  PF = [PF; pf];
  
  bbb = length (maxVec) + length (minVec);
 % check if it is residual
      if (length (maxVec) + length (minVec)) < 20
         break;
      end
           
  c = c-pf;

end

line=size(PF,1); 
NN = length(PF(1,:));
n = linspace(0,1,NN);
% figure(1);
% subplot(line+1,1,1),plot(n,x*1000),ylabel('X(t)');
% subplot(line+1,1,2),plot(n,PF(1,:)*1000),ylabel('PF_1(t)');
% subplot(line+1,1,3),plot(n,PF(2,:)*1000),ylabel('PF_2(t)');
% subplot(line+1,1,4),plot(n,PF(3,:)*1000),ylabel('PF_3(t)');
% subplot(line+1,1,5),plot(n,PF(4,:)*1000),ylabel('PF_4(t)');
% subplot(line+1,1,6),plot(n,PF(5,:)*1000),ylabel('PF_5(t)');
% subplot(line+1,1,7),plot(n,PF(6,:)*1000),ylabel('PF_6(t)');
% subplot(line+1,1,8),plot(n,PF(7,:)*1000),ylabel('PF_7(t)');
% subplot(line+1,1,9),plot(n,PF(8,:)*1000),ylabel('PF_8(t)');
% % subplot(line+1,1,10),plot(n,PF(9,:)*1000),ylabel('PF_9(t)');
% xlabel('Time / S'); 

% figure(2)
% for i=1:4
%     [fft_after,x]=FFT(PF(i,:),128);
%     subplot(4,1,i);plot(x,fft_after);
% end
end