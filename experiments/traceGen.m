%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Description:   This function generates trace fiels for experiments using
%               the function "box2polish".
%
%               box2polish: a floorplan when given the width (W) and the  
%               height (H) and the number of compartments needed (cuts). 
%               horizotal The variable Ph ([0 1]) is the propotion of 
%               cuts to vertical cuts when they are uniformly 
%               distributed. Mode allows us to generate solutions without 
%               rotation (0), with rotation for all boxes (1), with some 
%               portion (Pr) rotated (2).

function traceGen(stop, start, step, rotate, rotateRatio, boxW, boxH)
indx=1;     %index to move through the tables

randomBox=0;
if (or(boxW==-1, boxH==-1))
    randomBox=1
end

tA = fopen('trace.txt', 'w');
    for i=start:step:stop
        if(randomBox==1)            %Generate random with and height
            boxW=round(rand()*100);
            boxH=round(rand()*100);
        end 
       [expression, width, height]=box2polish (boxW, boxH, i, rand(), rotate, rotateRatio, 0);
        fprintf(tA, '%d\n%.2f\n%.2f\n%d', i, boxW, boxH);
        fprintf(tA, '%d\t',  expression);
        fprintf(tA, '\n');
        fprintf(tA, '%.2f\t', width);
        fprintf(tA, '\n');
        fprintf(tA, '%.2f\t', height);
        fprintf(tA, '\n');
    end
    
    fclose(tA);
end