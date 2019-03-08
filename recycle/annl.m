%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Description:   This function implments Simulated Annealing for floor
%               planning. It takes expression, tree for the expression
%               and width and hieght for the leafs and return the optimal
%               expression.
%
%Dependences:   getBox.m, swap.m, polish2tree.m
%
%Author:        Jameel Ahmad, Farouq Aliyu
%
%Date:          23rd December, 2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function annl=annl(expression, tree, dimWidth, dimHeight)
 
M=5;alpha=0.7;beta=1.0;T0=1000 ;
% global N   k w trycount; trycount=0;
global Best_Cost;
 
 
 S0=expression
 
MaxTime=200000; 
 

[annl,best,ll]=annealing(S0, T0, alpha, beta, M, MaxTime, tree, dimWidth, dimHeight) 
x=[1:ll-1];
[bb,y]=min(best);
% xx=y+200
% ymax=max(best)+5
% ymin=min(best)-5 
plot(x,best);
grid on
%   axis([ 0  bb+200  ymin  ymax])%bb+200
%------------------------------------------------------------------------------------------%
 
%------------------------------------------------------------------------------------------%
function [annealing,best,ll]=annealing(S0, T0, alpha, beta, M, MaxTime, tree, dimWidth, dimHeight)
T=T0; S=S0; Time=0;
i=1;
R=0;
 fileID = fopen('result.txt','w');
while(true)
         S=Metopolis(S, T, M , tree, dimWidth, dimHeight);
%         if R<Cost(S)
        [nw, nh, area]=getBox(S, tree, dimWidth, dimHeight);
        best(i)=area;
%         R=Cost(S);
        i=i+1;
%         end;
         Time=Time+100*M;
         %---------------------------------
        % Save the best Solution
         fileID3 = fopen('SA_S_result.txt','w');
         fprintf(fileID3,'%d \t',  S );
         fclose(fileID3);
     %---------------------------

      fprintf(fileID,'%0.2f \t', best(i-1) );%save the best so far to file
 

        T=alpha*T;
        M=beta*M;
        ll=i;
        if (Time>=MaxTime)
            fclose(fileID);
            break;
        end;
end;
%Best=S
annealing=S;%'Best solution found';

%------------------------------------------------------------------------------------------%

%------------------------------------------------------------------------------------------%
function  S=Metopolis(S, T, M, tree, dimWidth, dimHeight)
% global N    w trycount;
ll=1;
ii=1;
while (true)
%     trycount=trycount+1;
[nw, nh, Cost]=getBox(S, tree, dimWidth, dimHeight);

   NewS=swap(S);
   vv=NewS-S;
   tree =polish2tree(NewS);
 [nw, nh, new_Cost]=getBox(NewS, tree, dimWidth, dimHeight);
 
 
    dh= new_Cost-Cost; 
    r=rand();
%  rr(ii)=dh;
%  ii=ii+1;
    if(dh<0)    
         S=NewS; %Accept the solution;
%           Best_Cost(ll)=Cost(S, N, w,k);
          ll=ll+1;
    elseif(r<exp(-dh/T))
         S=NewS; %Accept the solution;
    end;
  
    M=M-1;
    if (M<1)
      break;
    end;
 
 best=S;        
end;
%------------------------------------------------------------------------------------------%

%------------------------------------------------------------------------------------------%

 
