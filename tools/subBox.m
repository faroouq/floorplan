%--------------------------------------------------------------------------
%
% w=[1 2 3 4; 2 5 3 6];     %width of two children   
% H=[2 1 4 3; 5 2 6 3];     %Height of two children
%                   %(2,6)(3,7)(4,8)(5,3)(6,4)
%                               H 
%                              /  \
%                             /    \
%                            /      \    
%                           /        \
%                          1          2 
%           (1,2)(2,1)(3,4)(4,3)  (2,5)(5,2)(3,6)(6,3)
%
%
%Authors:   Gamil Ahmad
%           Farouq Aliyu
%           Dr. Sadiq Sait
%Date:      25th November, 2018
%-------------------------------------------------------------------------- 
function [nw, nh]=Box1(W,H,op)        
nw=[]; nh=[];    %Declair empty array


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


 % Calculate all possible pairs, excluding zeros
for i=1:length(W) 
   w1=W(1,i);    h1=H(1,i);                                   
   for j=1:length(H)
     w2=W(2,j);  h2=H(2,j);
         if op==-1                     %Horizontal Cut
             NW(i,j)=max(w1,w2);       %Maximium of width
             NH(i,j)=h1+h2;            %Sum of Height             
         elseif op==-2                 %Vertical Cut
           NH(i,j)=max(h1,h2);         %Maximium of height
           NW(i,j)=w1+w2 ;             %Sum of width 
         end
    end
end
%-----------------------------------------------
 
    
 for i=1:length(NW)
    for j=1:length(NW)-1
        if NW(j,i)==NW(j+1,i)                   %if a width is same 
            NH(j:j+1,i)=min(NH(j,i),NH(j+1,i)); %Choose min height
         
        end
        if NH(j,i)==NH(j+1,i)                   %if a height is same 
            NW(j:j+1,i)=min(NW(j,i),NW(j+1,i)); %Choose min width
            
        end
    end;
end;
 
%----------------------------------------
%       Remove Redendant pairs
%----------------------------------------
k=1;
for i=1:length(NW)
    for j=1:length(NW)
       nw2(k)= NW(i,j) ;
       nh2(k)=NH(i,j);
         k=k+1    ;
        
    end;
end; 
 
nw3=sort(nw2) ;
l=1;
k=0;
while k<length(nw3)-1
    k=k+1;
    while nw3(k)==nw3(k+1)& k<(length(nw3)-1)
        k=k+1;
    end
 nw(l)=nw3(k);
 l=l+1;
end
for i=1: length(nw)
    v=nw(i);
    index=find(nw2==v);
    nh(i)=min(nh2(index));      %nh(i)=nh2(index(1)); modified on 30th Nov, 2018
end
% for j=1:length(nw)-1
%         if nw(j)==nw(j+1)                   %if a width is same 
%             nh(j:j+1)=min(nh(j),nh(j+1)); %Choose min height
%         end
%         if nh(j)==nh(j+1)                   %if a width is same 
%             nw(j:j+1)=min(nw(j),nw(j+1)); %Choose min height
%         end
%     end
end