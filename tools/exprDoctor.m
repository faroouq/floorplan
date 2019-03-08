%Description:   This function checks the validity of a polish expression.
%Date:          23rd December, 2018

function [validity, tree]=exprDoctor(expression)
    tree=polish2tree(expression);
    validity=treeDoctor(tree, expression);
    
    if (tree==validity)                   	%return 1 if expression is true
        validity=0;                         %else return error code
    end
end