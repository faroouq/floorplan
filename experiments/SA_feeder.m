fID=fopen('trace.txt', 'r');
sn=1;
%============SAVE RESULTS===================
resultId=fopen('result.txt', 'w');  
fprintf(resultId,'SN.\t\tCuts\t\tCost\t\tOptimal Cost\t\tWidth\t\tHeight\t\tOpt. Width\t\tOpt. Height\t\tTime(s)\n');
fprintf(resultId,'===========================================================');
fprintf(resultId,'===========================================================');
fprintf(resultId,'\n');
fclose(resultId);

%============SAVE EXPRESSION===============
expId=fopen('expr.txt', 'w');  
fprintf(expId,'====================================================\n');
fprintf(expId,'Sn\t\tExpression\n');
fprintf(expId,'====================================================');
fprintf(expId,'====================================================');
fprintf(expId,'\n');
fclose(expId);


numCuts=str2num(fgetl(fID));
while (numCuts~=-1)
    boxW=str2num(fgetl(fID));
    boxH=str2num(fgetl(fID));
    expression=str2num(fgetl(fID));
    
    width=reshape(str2num(fgetl(fID)), numCuts+1,[]);
    height=reshape(str2num(fgetl(fID)), numCuts+1,[]);
    
    tic;
    [expr, cost, boxWidth, boxHeight]=SA(width, height);
    t=toc;
    
    %%%%%%%%%Save Expression%%%%%%%%%%%%%%
    expId=fopen('expr.txt', 'a'); 
    fprintf(expId,'%d.\t\t', sn);
    fprintf(expId,'%d\t', expr);
    fprintf(expId,'\n');
    fclose(expId);
    
    
    %%%%%%%%%Save result%%%%%%%%%%%%%%
    resultId=fopen('result.txt', 'a');  
    fprintf(resultId,'%d.\t\t', sn);
    fprintf(resultId,'%.2f\t\t', numCuts);
    fprintf(resultId,'%.2f\t\t', cost);
    fprintf(resultId,'%.2f\t\t', boxW*boxH);
    fprintf(resultId,'%.2f\t\t', boxWidth);
    fprintf(resultId,'%.2f\t\t', boxHeight);
    fprintf(resultId,'%.2f\t\t\t', boxW);
    fprintf(resultId,'%.2f\t\t\t', boxH);
    fprintf(resultId,'%.4f\t', t);
    fprintf(resultId,'\n');
    fclose(resultId);
    
    numCuts=str2num(fgetl(fID));        %update while loop
    sn=sn+1;
end

fclose(fID)
