%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Descritpion:	This function recives an expression, the tree, the 
%               respective width and height of the leafs and it returns the 
%               area of the bounding
%
%Dependencies:  subBox.m
%
%Authors:       Farouq Aliyu, Jameel Ahmad
%Date:          23rd December, 2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [nw, nh, area]=getBox(expression, tree, dimWidth, dimHeight)
    left=1;                         %base on tree structure pls see Polish for info
    right=2;
    treeSize = size(tree, 1);
    
    recordsCols=size(dimWidth,2);	%gives us the current columnsize of record
    recordsRows=size(tree,1);       %gives us the current rowsize of record
    W=zeros(recordsRows, recordsCols); %get rows from tree and col from dimension
    H=W;
    for node=1:treeSize             %for each node calculate box
        if(and(tree(node, left)~=0, tree(node, right)~=0))
            
        	myWidth=[W(tree(node, left),:); W(tree(node, right),:)];
            myHeight=[H(tree(node, left),:); H(tree(node, right),:)];
            
            %u r not leaf. remember: V=-2 and H=-1
          	[tempWidth, tempHeight]=subBox(myWidth, myHeight, expression(node));  
            wSize=size(tempWidth,2);
            hSize=size(tempHeight,2);
            newSize=max(wSize, hSize);
            
            if(recordsCols<newSize)                     %if record is short 
                newCols=newSize-recordsCols;            %expand by this much!!!
                expansion=zeros(recordsRows, newCols);  %expand before you save
                W=[W expansion];
                H=[H expansion];
            end
            
            
            W(node, 1:wSize)=tempWidth;                 %record the data
            H(node, 1:hSize)=tempHeight;     
            
   
        else                        %leaf nodes' dimension does not change
            W(node,1:size(dimWidth,2))=dimWidth(expression(node), :);
            H(node,1:size(dimHeight,2))=dimHeight(expression(node), :);
        end
    end
    
    area=W.*H;
    area(area==0)=Inf;                      %trim zeros
    bestArea=min(area(recordsRows, :));     %root is always the last one
    [~,c]=find(area(recordsRows, :)==bestArea);
    
    nh=H(recordsRows,c);
    nw=W(recordsRows,c);
    area=bestArea;
end