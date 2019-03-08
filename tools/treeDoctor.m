function [t]=treeDoctor(tree, expression)
    %-------------------------TREE DOCTOR---------------------------------
    temp=not(tree==0);                          %lets check tree for anomalies
    myNodes=sum(sum(temp));                     %number of nodes
    temp=(tree==0);                             %similarly for leaf nodes
    myLeafs=sum(sum(temp));                     %get their number
    temp=(tree<0);                              %get instances where H\V is leaf node
    crazies=sum(sum(temp));
          
    a=1:size(expression,2)-1;                   %-------Tree anatomy------  
    out= histc(tree(:,:), a);
    counts=sum(out,2);
    multiples=size(find(counts>1),1);           %let make sure no repetition
    notMentioned=size(find(counts==0),1);       %is there a node not mentioned?
    
    
    oprands=size(find(expression>0),2);         %balloting property
    operators=size(expression,2)-oprands;
    
    %hence if:
    %   1) there is a node with one child or 
    %   2) a leaf node with child or 
    %   3) H and/or V property as a leaf node 
    %   4) no node should appear more than once
    %   5) no node should be absent, 
    %   6) Baloting property
    % then send error flag.
    if (mod(myNodes,2)>0)
        t=-21;
    elseif (mod(myLeafs,2)>0)
        t=-22;
    elseif (crazies>0)
        t=-23;
    elseif (multiples>0)
        t=-24;
    elseif (notMentioned>0)
        t=-25;
    elseif (oprands<operators)
        t=-26;
    else
        t=tree;
    end  
end 