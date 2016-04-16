clc
format long g
iteration=500;
reward=[0,0,0,1,0,-100,0,-1,0,0,0,0];
Q=[-1000,0,-1000,0,0;-1000,-1000,0,0,0;-1000,0,0,1,0;-1000,-1000,-1000,-1000,0;0,0,-1000,-1000,0;-1000,-1000,-1000,-1000,0;0,0,-1000,-1,0;-1000,-1000,-1000,-1000,0;
    0,-1000,-1000,0,0;-1000,-1000,0,0,0;0,-1000,0,0,0;-1,-1000,0,-1000,0];
%r=0;%intial reward
a=5;%initial action
N=zeros(12,5);
mat3s=zeros(1,iteration);
mat7n=zeros(1,iteration);
mat11n=zeros(1,iteration);
mat9n=zeros(1,iteration);
mat9e=zeros(1,iteration);
mat4=zeros(1,iteration);
mat8=zeros(1,iteration);

for counter=1:iteration
    %x=3;
    %y=1;
    %a=;
    a=5;
    start=9;
    alpha=1/(counter+1)
    gamma=0.9;
    next_pos=5;
    r=reward(start);
    agent=start;
    while(true)
        max=-10000;
        %num=x*10+y;
        fprintf('iteraation %d',counter);
        for i=1:4
            m=@fun;
            Q(agent:agent,i:i);
            N(agent:agent,i:i);
            %fprintf('iteraation %d',i);
            if Q(agent:agent,i:i)<0
                continue;
            end    
            f=m(Q(next_pos:next_pos,i:i),N(next_pos:next_pos,i:i));
            if max < f
                a=i
                max=f;
                
            elseif max==f
                t=randi([1,2]);
                if t==1
                    a=i
                end
            end
        end
        if a==1
            next_pos=agent-4;
        elseif a==2
            next_pos=agent+4;
        elseif a==3
            next_pos=agent-1;
        elseif a==4
            next_pos=agent+1;
        end
       if next_pos <1 || next_pos >12
           next_pos=agent;
       end
       next_pos
     Q(:,:)
        if next_pos == 4 || next_pos == 8
           
            fprintf('end if iteraation\n' );
            break;
        else
            N(agent:agent,a:a)= N(agent:agent,a:a)+1;
            q=-10000;
            for i=1:4
                next_pos=next_pos;
                Q(next_pos:next_pos,i:i);
                if q<Q(next_pos:next_pos,i:i)
                    q=Q(next_pos:next_pos,i:i);
                    %next_a=i;
             
                end
            end
            Q(agent:agent,a:a)=Q(agent:agent,a:a)+alpha*N(agent:agent,a:a)*(r+gamma*q-Q(agent:agent,a:a));
            
            
        end
        r=reward(next_pos);
        agent=next_pos;
        %a=next_a;
        
        mat3s(1:1,counter:counter)=Q(3:3,2:2);
        mat7n(1:1,counter:counter)=Q(7:7,1:1);
        mat11n(1:1,counter:counter)=Q(11:11,1:1);
        mat9n(1:1,counter:counter)=Q(9:9,1:1);
        mat9e(1:1,counter:counter)=Q(9:9,4:4);
        mat4(1:1,counter:counter)=1;
        mat8(1:1,counter:counter)=-1;
    
    end
    Q(:,:)
end
hold on
%title('The passive ADP learning curves for the 3*4 world');
xlabel('Number of trials');
ylabel('Q-values');
for i=1:iteration
    a1=plot(i,mat3s(1:1,i:i),'r--');m1='3 south';
    a2=plot(i,mat7n(1:1,i:i),'b--');m2='7 north';
    a3=plot(i,mat11n(1:1,i:i),'g--');m3='11 north';
    a4=plot(i,mat9n(1:1,i:i),'c--');m4='9 north';
    a5=plot(i,mat9e(1:1,i:i),'m--');m5='9 east';
    a6=plot(i,mat4(1:1,i:i),'y--');m6='goal';
    a7=plot(i,mat8(1:1,i:i),'k--');m7='dead state';
    
end
legend([a1,m1],[a2,m2],[a3,m3],[a4,m4],[a5,m5],[a6,m6],[a7,m7])
hold off
