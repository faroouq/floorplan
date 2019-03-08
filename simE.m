function expr=simE(width, height)
    left=1;                 %for traversing the tree
    right=2;
    goodnessType=2;         %1=goodness due to area, 2=goodness due to portion
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
    
    %INITIALIZATION
    [expr, tree]=exprGenFast(blocks);	%Get initial expression
                                    %lets get the tree for the expression

    while (iteration<maxIteration)  %iteration begins
        %EVALUATION:
        %===========
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
        
        %SELECTION:
        %==========
        cntPs=1;          	%index for selected movable elements
        cntPr=1;            %index for remaining movable elements
        for i=1:eS          %for each m <= M
           if selection (gm(i), B) 
               Ps(cntPs)=expr(i);
               gms(cntPs)=gm(i);
               cntPs=cntPs+1;
           else
               Pr(cntPr)=expr(i);
               gms(cntPr)=gm(i);
               cntPr=cntPr+1;
           end
        end
    end
    
    
    
end



%==========================================================================
%Check Iterative Computer Algorithm for Applications and Engineering, Sadiq
%Sait et al.
%==========================================================================
function sel=selection(m, B)
    if rand()<=(1-m+B)
        sel=true;
    else
        sel=false;
    end
end