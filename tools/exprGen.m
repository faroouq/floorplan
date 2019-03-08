%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Descritpion:   This function generates an expression and a polish tree
%               for sets of blocks. Arragnment are totally random and 
%               expression is tested before returning it to the caller
%
%Date:          28th December, 2018
%Author:        Farouq Aliyu, Gamil Ahmad
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [expr, tree]=exprGen(blocks)
    operators=blocks-1;
    sz=blocks+operators;
    expr=zeros(1,sz);
    

    
    %NOW, lets put them in a mixer
    blockCnt=1;
    opsCnt=1;
    exprCnt=1;
    Pb=0.7;                         %probability of block
    error=1;
    while (error~=0)
     	myBlocks=randperm(blocks);              %getnerate random arrangment of blocks
        ops=-1*randi(2, 1, operators);          %random combination of operators
    
        for i=1:sz
           if and(rand()<=Pb, blockCnt<=blocks)
               expr(exprCnt)=myBlocks(blockCnt);
               blockCnt=blockCnt+1;
               exprCnt=exprCnt+1;
           elseif and(rand()>Pb, opsCnt<=operators)
               expr(exprCnt)=ops(opsCnt);
               opsCnt=opsCnt+1;
               exprCnt=exprCnt+1;
           end
        end
        
        [error, tree]=exprDoctor(expr);
    end
end