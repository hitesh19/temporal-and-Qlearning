clc
iteration=500;
%{ Reward Matrix : to store rewards at each state  %}
reward=zeros(3,4);
reward(2:2,2:2)=-100;
reward(1:1,4:4)=1;
reward(2:2,4:4)=-1;
ploter=zeros(5,500);

%{probability matrix%}
prob=[1221,3111,413221,41;1311,-100,334231,42;2312,3313,324323,4233];
%prob=[21,3111,413221,41;-100,-100,334231,42;23,3313,324323,4233];

ns=zeros(3,4);
ns(2:2,2:2)=-100;

%{ Utily Matrix : to store the computed utility measures of each state %}
utility=zeros(3,4);
utility(:,:)=0;
utility(2:2,2:2)=-100;
utility(3:3,1:1)=0;
utility(1:1,4:4)=1;
utility(2:2,4:4)=-1;

%{Matrix used for ploting%}
mat31=zeros(1,iteration);
mat21=zeros(1,iteration);
mat11=zeros(1,iteration);
mat12=zeros(1,iteration);
mat13=zeros(1,iteration);
mat14=zeros(1,iteration);
mat32=zeros(1,iteration);
mat33=zeros(1,iteration);
mat34=zeros(1,iteration);
mat23=zeros(1,iteration);


for counter=1:iteration
   x=3;
   y=1;
   alpha=1/(counter+1);
   fprintf('trial number = %d\n',counter)
   num=prob(x,y);
   temp=num;
   random_number=randi([1,6]);
   while random_number
       random_number=random_number-1;
       if(temp==0)
          temp=num; 
       end
       nextx=rem(temp,10);
       temp=idivide(int32(temp),10,'floor');
       nexty=rem(temp,10);
       temp=idivide(int32(temp),10,'floor');
   end
   prex=x;
   prey=y;
   num2=nextx*10+nexty;
    while 1
        
        if utility(nextx:nextx,nexty:nexty)==0
            utility(nextx:nextx,nexty:nexty)=reward(nextx:nextx,nexty:nexty);
        end 
        
        if (utility(prex:prex,prey:prey)~= -100) || (utility(prex:prex,prey:prey)~=1) || (utility(prex:prex,prey:prey)~=-1) ||(utility(prex:prex,prey:preyb)~=1.0000)% ||(utility(prex:prex,prey:prey)~=0)
            
           
            utility(prex:prex,prey:prey)= utility(prex:prex,prey:prey)+alpha*(reward(prex:prex,prey:prey)+1*utility(nextx:nextx,nexty:nexty)-utility(prex:prex,prey:prey));
            if num2==14 || num2==24
                break;
            end
        end
        prex=nextx;
        prey=nexty;
        num=prob(prex,prey);
        temp=num;
        random_number=randi([1,6]);
        while random_number
             random_number=random_number-1;
             if(temp==0)
                  temp=num;
             end
        nextx=rem(temp,10);
        temp=idivide(int32(temp),10,'floor');
        nexty=rem(temp,10);
        temp=idivide(int32(temp),10,'floor');
        end
       num2=nextx*10+nexty;
        mat31(1:1,counter:counter)=utility(3:3,1:1);
        mat21(1:1,counter:counter)=utility(2:2,1:1);
        mat11(1:1,counter:counter)=utility(1:1,1:1);
        mat12(1:1,counter:counter)=utility(1:1,2:2);
        mat13(1:1,counter:counter)=utility(1:1,3:3);
        mat14(1:1,counter:counter)=utility(1:1,4:4);
        mat32(1:1,counter:counter)=utility(3:3,2:2);
        mat33(1:1,counter:counter)=utility(3:3,3:3);
        mat34(1:1,counter:counter)=utility(3:3,4:4);
        mat23(1:1,counter:counter)=utility(2:2,3:3);
       
    end
   utility(:,:)
end
num=0;
fprintf('the optimal path is (%d,%d),',3,1);
    if utility(2:2,1:1)>=utility(3:3,2:2)
        fprintf('(%d,%d),(%d,%d),(%d,%d),(%d,%d),(%d,%d)',2,1,1,1,1,2,1,3,1,4);
    else
        fprintf('(%d,%d),(%d,%d),(%d,%d),%d,%d),(%d,%d)',3,2,3,3,2,3,1,3,1,4);
    end
hold on
title('The passive ADP learning curves for the 3*4 world');
xlabel('Number of trials');
ylabel('Utility estimates');
for i=1:iteration
    a1=plot(i,mat31(1:1,i:i),'r');m1='(3,1)';
    a2=plot(i,mat21(1:1,i:i),'b');m2='(2,1)';
    a3=plot(i,mat11(1:1,i:i),'g');m3='(1,1)';
    a4=plot(i,mat12(1:1,i:i),'color',[1,0.4,0.7]);m4='(1,2)';
    a5=plot(i,mat13(1:1,i:i),'color',[0,0.8,0.2]);m5='(1,3)';
    a6=plot(i,mat14(1:1,i:i),'colo',[0,0,0.4]);m6='(1,4)';
    a7=plot(i,mat32(1:1,i:i),'color',[1,1,0.3]);m7='(3,2)';
    a8=plot(i,mat33(1:1,i:i),'color',[0,0.3,0.9]);m8='(3,3)';
    a9=plot(i,mat34(1:1,i:i),'color',[0.3,0.9,0]);m9='(3,4)';
    a10=plot(i,mat23(1:1,i:i),'color',[0,1,0.1]);m10='(2,3)';
end
legend([a1,m1],[a2,m2],[a3,m3],[a4,m4],[a5,m5],[a6,m6],[a7,m7],[a9,m9],[a10,m10])
hold off
