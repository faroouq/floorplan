%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Description:   Polish2tree is a function that takes a normalized polish 
%               tree and convert it to a tree
%
%Dependencies:  treeDoctor.m
%
%Date:          26th November, 2018
%
%Example:       Expression =>	[1 2 H 3 4 V H]
%                                ^ ^ ^ ^ ^ ^ ^
%               Indices =>      [1 2 3 4 5 6 7]
%                                        
%               Tree =>                       H(7)
%               indeces in brackets         /     \
%                                       (3)H       V(6)
%                                         / \     / \
%                                        1   2   3   4
%                                       (1) (2) (4) (5)
%               
%               Tree representation => |==================================|
%               by MATLAB:             | Parent | left Child | Right Child|
%               The first column is    |----------------------------------|
%               the row index of nx2   |     1  |     0      |     0      |
%               matrix. Where "n" is   |----------------------------------|
%               the number nodes in    |     2  |     0	     |     0      |
%               tree/expression        |----------------------------------|
%                                      |     3  |     1	     |     2      |
%                                      |----------------------------------|
%                                      |     4  |     0	     |     0      |
%                                      |----------------------------------|
%                                      |     5  |     0	     |     0      |
%                                      |----------------------------------|
%                                      |     6  |     4	     |     5      |
%                                      |----------------------------------|
%                                      |     7  |     3	     |     6      |
%                                      |________|____________|____________|
%
%Authors:   Farouq Aliyu
%           Gamil Ahmad
%           Dr. Sadiq Sait
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [tree]=polish2tree(expression)
    top=size(expression,2);  %location of root
    index=top;               %index of individula polish expression
    tree=zeros(index, 2);    %tree has n=rows where n is size of expression 
                             %and 2 columns where  1 is left and 2 is right
                             
                             
    %++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    %go from right to left
    %to fill the right side of the tree
    %++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    temp=expression;
    temp=fliplr(temp);
    
    for i=1:(size(expression,2)-1)      	
        if(and(temp(i)<0, temp(i+1)<0)) 	%if leter (i.e. V or H)
            tree(index, 2)=index-1;         %letter after letter is right
        elseif (and(temp(i)<0, temp(i+1)>0))
            tree(index, 2)=index-1;         %no after letter is to the right
                                            %letter after no is leaf node
        end                                 %which is the default (4rm init.)    
        
        index=index-1;                      %move to next harf
    end
    
    
        
    %++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	%then left to right
    %to fill the right side of the tree
    %++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    
    for i=2:(size(expression,2))                        %left-to-right     
        if and(expression(i)<0,expression(i-1)>0)       %letter->no. == parent of (i-2)
            tree(i, 1)=i-2;
        elseif and(expression(i)<0,expression(i-1)<0)   %letter->letter == next largest index available
            nextLarge=i-1;                              %exclusing myself
            while (size(find(tree==nextLarge),1)>0)     %finiding next largest index available
                nextLarge=nextLarge-1;      
            end
            
            tree(i, 1)=nextLarge;                       %alloc
        end
    end
    
    
    tree=treeDoctor(tree, expression);                  %check the health of your tree   
end