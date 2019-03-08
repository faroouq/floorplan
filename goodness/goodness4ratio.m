%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Description:   This code calculates goodness of a pair of boxes as a
%               ratio of their width (for horizontal operator) and the 
%               ratio of their height (for vertical operator).
%
%Author:        Farouq Aliyu, Gamil Ahamad
%
%Date:          29th Decemeber, 2018
%
% Validation:
% W=[1 2 3 1;3 5 2 4];
% H=[2 5 4 3; 1 2 5 3];
% 
% op=-1;
% [h,w,g]=Gdness(W,H,op);
% gd=mean(g)
% W=[3 1 3 1; 3 5 2 4];
% H=[1 1 4 3; 1 2 5 3];
% [h,w,g1]=Gdness(W,H,op);
% gd1=mean(g1)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [gm]=goodness4ratio(W, H, Op)
    %Lets remove all zeros
    concW1=W(1,W(1,:)~=0);
    concW2=W(2,W(2,:)~=0);    
    concH1=H(1,H(1,:)~=0);
    concH2=H(2,H(2,:)~=0);


    if(length(concW1)~=length(W(1,:)))
        W(1,:)=[concW1 repmat(concW1(1,1), 1, length(W(1,:))-length(concW1(1,:)))];
    end
    if(length(concW2)~=length(W(2,:)))
        W(2,:)=[concW2 repmat(concW2(1,1), 1, length(W(2,:))-length(concW2(1,:)))];
    end
    if(length(concH1)~=length(H(1,:)))
        H(1,:)=[concH1 repmat(concH1(1,1), 1, length(H(1,:))-length(concH1(1,:)))];
    end
    if(length(concH2)~=length(H(2,:)))
        H(2,:)=[concH2 repmat(concH2(1,1), 1, length(H(2,:))-length(concH2(1,:)))];
    end 
    %-----------------------------Zeros Removed----------------------------

    %combo1=[];
    %combo2=[];
    if(Op==-1)              %for horizontal, we take ratio of widths
        combo1=W(1,:);      %else we take the ration of heights
        combo2=W(2,:);
    else
        combo1=H(1,:);
        combo2=H(2,:);
    end
    
    sz=size(combo1,2)*size(combo2,2);
    gm=zeros(1,sz);             %initializing variables with the right
                                %size improves the performance of MATLAB
    cnt=1;                  	%index to the gm
    for L=combo1            	%for all combinations lets find the ratio
        for R=combo2
            if(L>R)
                gm(cnt)=R/L;
            else
                gm(cnt)=L/R;
            end
            cnt=cnt+1;
       end
    end
end