%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Descritpion:   This function generates an expression and a polish tree
%               for sets of blocks. Nodes and operators are random but the 
%               tree is built with all object at the left side of the tree.
%               This function is faster than exprGen since the first
%               expression generated is error free.
%               
%
%               eg:                                       
%               Tree =>     	 H
%                             	/ \
%                              1   V
%                                 / \
%                             	 2   H
%                                  	/ \
%                                  3   4
%
%Date:          28th December, 2018
%Author:        Farouq Aliyu, Gamil Ahmad
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [expr, tree]=exprGenFast(blocks)
    operators=blocks-1;
    sz=blocks+operators;
    expr=zeros(1,sz);
    

	myBlocks=randperm(blocks);              %getnerate random arrangment of blocks
	ops=-1*randi(2, 1, operators);          %random combination of operators
    %expr=[myBlocks(1:2) ops(1) myBlocks(3:blocks) ops(2:operators)];
    expr=[myBlocks ops];
    tree=polish2tree(expr);
end