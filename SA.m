function [expr, cost, boxWidth, boxHeight]=SA(width, height)
    left=1;                 %for traversing the tree
    right=2;
    goodnessType=1;         %1=goodness due to area, 2=goodness due to portion
                            %3=goodness due to ratio
    
    B=0;                    %Bias selection
    
    blocks=size(width,1);   %from the dimensions we can conclude number of blocks
    operators=blocks-1;     %operators are one less than the blocks
    
     eS=blocks+operators;                        
     gms=zeros(1,eS);     	%population set
     Ps=zeros(1,eS);        %selected set
     Pr=zeros(1,eS);        %rejected set   
     gm=zeros(1, eS);     	%goodness of populations
    
    iteration=0;            %we are using number of iteration as stopping criteria
    maxIteration=500;
    

%============================Main code===================================
[expr, tree]=exprGenFast(blocks);               %Get initial expression
                                                %lets get the tree for the expression
                              


%--simulated anealing
T=700;                                          %initial temperature
Tini=T;                                         %for printing legend
alpha=0.99;                                     %cooling rate
y=0.005;                                      	%static method, the higher 
                                                %the better the result
equilibrium=round(T*y);                         %no of itr. until equil. st.

%get the cost of selection 
[boxWidth, boxHeight, cost0]=getBox(expr, tree, width, height); 	

count=0;
track=[];
while (T>0.01)
   for j=1:equilibrium
            %let's get width and height of each node in tree
        [W, H]=getAllBoxes(expr,tree,width, height);    
        for i=1:eS                                      %for each movable element,
            if and(tree(i, left)~=0, tree(i, right)~=0) %for every subtree 
                oprand=expr(i);
                operatorLeft=tree(i, left);
                operatorRight=tree(i, right);
                subWidth=[W(operatorLeft,:);W(operatorRight,:)];
                subHeight=[H(operatorLeft,:);H(operatorRight,:)];
                if(goodnessType==1)
                    [~,~,gmm]=goodness4area(subWidth, subHeight, oprand);
                    gm(operatorLeft)=max(gmm);
                    gm(operatorRight)=max(gmm);
                elseif (goodnessType==2)
                    [gmL, gmR]=goodness4portion(subWidth, subHeight, oprand);
                    gm(operatorLeft)=max(gmL);
                    gm(operatorRight)=max(gmR);
                elseif (goodnessType==3)
                    [gmm]=goodness4ratio(subWidth, subHeight, oprand);
                    gm(operatorLeft)=max(gmm);
                    gm(operatorRight)=max(gmm);
                end 
            end
        end
        gm(eS)=1;           %the root is lonley, 
                        	%make it fixed with high goodness
        
        tempExpr=expr;
        for i=1:eS                              %for each movable element,
             if and(rand()<gm(i), tempExpr(i)>0)    %we exclude operators from moves
                 temp=tempExpr(i);
                 k=randi(eS);
                 while or(tempExpr(k)<=0, k==i)
                     k=randi(eS);
                 end
                 tempExpr(i)=tempExpr(k);               %making a move
                 tempExpr(k)=temp;
             end
        end
    
    %let get ist cost
    [boxWidth, boxHeight, cost]=getBox(tempExpr, tree, width, height); 
    E=cost-cost0;                                	%change in cost
     
     R=rand();              %toss a coin
     if (E<=0)              %if cost is lower
         expr=tempExpr;  	%just accept
         cost0=cost;        %update cost
     elseif (R<exp(-E/T))   %else...
         expr=tempExpr; 	%accept with a certain probabilty
         cost0=cost;        %update cost
     end
   end
   
   T=T*alpha;               %lower temperature
   count=count+1;           %lets record data update for display
   track(count)=cost0;       %track will be ploted afterwards
end

fprintf('Expr=[');             %Printing solution
fprintf('%d\t', expr);
fprintf(']\n');


plot(track);                        %ploting graph
if(goodnessType==1)                 %customizing title for bonus marks
    str1='Goodness based on Area';
elseif(goodnessType==2)
    str1='Goodness based on proportion';
elseif(goodnessType==3)
    str1='Goodness based on Ratio';
end
str=sprintf('Plot Cost vs Iteration for %d Rectangles (%s)', blocks, str1);
strLegend=sprintf('T=%0.2f\nalpha=%0.2f\nM=%0.2f', Tini,alpha,equilibrium);
title(str);
xlabel('Iterations');
ylabel('Cost');
legend(strLegend);
%xlim([0 inf]);
%ylim([0 inf]);
grid on;
%=============================The END====================================  
end