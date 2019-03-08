%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Description:   This function generates a floorplan when given the   
%               width (W) and the height (H) and the number of compartments 
%               needed (cuts). The variable Ph ([0 1]) is the propotion of 
%               horizotal cuts to vertical cuts when they are uniformly 
%               distributed. Mode allows us to generate solutions without 
%               rotation (0), with rotation for all boxes (1), with some 
%               portion (Pr) rotated (2).
%
%
%Test Cases:    
%    1) box2polish(10, 10, 6, 0.5,0,0)
%
%
%Authors:       Farouq Aliyu
%               Gamil Ahmad
%               Dr. Sadiq Sait
%Date:          03rd December, 2018
%
%Dependencies:  Rect()
%Use the commands below to test code
% cuts=5;
% Width=40;
% Height=10;
% box2polish(Width, Height, cuts, 0.7, 0, 0, 1)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [expression, width, height]=box2polish (boxW, boxH, cuts, Ph, mode, Pr, display)
left=1;                     %positions of left and right of tree in the 
right=2;                    %table (i.e. array)
down=left;                  %similar rank for up and down
up=right;
op=3;                       %resulting operation

H=-1;                       %Remember: H=-1, V=-2
V=-2;

operators=cuts;
oprands=operators+1;        %Get a paper and try it B-)
nodes=operators+oprands;	%No. of nodes in the tree. If you don't agree ask you teacher


width=zeros(cuts+1, 4);     %widths and heights of leaf nodes
height=zeros(cuts+1, 4);

tree=zeros(operators, 3);   %Expressions tree
bW=zeros(nodes, 1);          %width and Height of boxes
bH=zeros(nodes, 1);

bW(nodes)=boxW;              %start recording from the root node
bH(nodes)=boxH;


currentNode=nodes;
lastNode=nodes;                             %lets keep track the last operator cut
for ops=1:operators                         %lets start cutting: Bruum, bruum
    if(rand() <= Ph)                        %probability of getting a horizontal cut
        tree(currentNode,left)=lastNode-2;	%for horizontal left b/4 right
        tree(currentNode,right)=lastNode-1;
        tree(currentNode,op)=H;
        
        bW(lastNode-1)=bW(currentNode);     %calculate widht and height of partitions   
        bH(lastNode-1)=bH(currentNode)/2;
        bW(lastNode-2)=bW(currentNode);
        bH(lastNode-2)=bH(currentNode)/2;
    else                                   	%if not horizontal, it must be vertical
        tree(currentNode,down)=lastNode-2;	%for vertical down b/4 up
        tree(currentNode,up)=lastNode-1;
        tree(currentNode,op)=V;
        
        bW(lastNode-1)=bW(currentNode)/2;   %calculate widht and height of partitions   
        bH(lastNode-1)=bH(currentNode);
        bW(lastNode-2)=bW(currentNode)/2;
        bH(lastNode-2)=bH(currentNode);
    end
    area=[bW bH]; 
    currentNode=currentNode-1;
    lastNode=lastNode-2;
end

serviced=zeros(1,nodes);                    %keeps track of nodes treated
expression=zeros(1, nodes);                 %lets create the expression
i=nodes;                                    %starting from the root
leftFlag=0;                                 %1 if you want to go to the left
expPtr=nodes;
while (i>0)
    if(and(tree(i,op)~=0, leftFlag==0))     %if right is not leaf  
        expression(expPtr)=tree(i,op);   	%if then record operation & keep going
        serviced(i)=1;                      %record node as serviced
        i=tree(i,right);                    %go to next node to the right
        leftFlag=0;                         %keep right. put your sit belt :-)
        expPtr=expPtr-1;
        
    elseif (and(tree(i,op)==0, leftFlag==0))%for leaf nodes, 
        expression(expPtr)=i;               %store the node itself, they are the final children
        serviced(i)=1;                      %record node as serviced
     	leftFlag=1;                         %it is time to go left
        expPtr=expPtr-1;
        
        check=sum(serviced);                %how many serviced so far?
        if(check<nodes)                     %if there are remaining nodes
            [i, ~]=find(tree==i);          	%go back to the father
            while(serviced(tree(i,left)))  	%keep going up if left is serviced
                [i, ~]=find(tree==i);     	%go back to the father
            end
        else                              	%else...
            i=0;                            %end expression creation
        end
    elseif(leftFlag==1)                     %an instruction to write down the left
        i=tree(i,left);                                 %force left node in
        leftFlag=0;                                     %clear flag 
    end                                                 %next available position
end


w=area(1:cuts+1,1);
h=area(1:cuts+1,2);
if(mode==0)
    for i=1:cuts+1
        width(i,:)=[w(i) 0 0 0];
        height(i,:)=[h(i) 0 0 0];
    end
elseif(mode==1)
    for i=1:cuts+1
        width(i,:)=[w(i) h(i) 0 0];
        height(i,:)=[h(i) w(i) 0 0];
    end  
elseif(mode==2)
    for i=1:cuts+1
        if (rand()<Pr)
            width(i,:)=[w(i) 0 0 0];
            height(i,:)=[h(i) 0 0 0];
        else
            width(i,:)=[w(i) h(i) 0 0];
            height(i,:)=[h(i) w(i) 0 0];
        end
    end
end


if (display==1)	%display boxes
  	A=w.*h;
    Rect(A);	%display cut box
end
end