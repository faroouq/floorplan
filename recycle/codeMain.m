% -1 is horizontal (H) and -2 is vertical (V)
%[1 2 H 3 H 4 5 V 6 7 H V H][1 2 V 3 4 H V 5 6 V 7 8 H H V]
%[1 2 V 3 4 5 6 V H V H][1 2 V 3 H 4 5 V H 6 7 V V]
%[1 2 H 3 4 V H]
%[1 8 V  H 2 3 H 4 5 V 6 7 H V H] err
% expression=[1 2 H 3 4 V 5 6 7 V H H V];
% dimWidth= [2 1 4 8; 1 1 0 0; 1 1 1 1; 2 1 0 0; 1 4 16 4; 1 1 0 0; 1 1 2 2];
% dimHeight=[4 8 2 1; 4 4 0 0; 1 1 1 1; 8 16 0 0; 16 4 1 4; 1 1 0 0; 2 2 1 1];


H=-1;
V=-2;
% expression=[2 1 H 4 3 V 5 6 V H V];
% dimWidth=   [8 2 0 0; 6 12 6 3; 1 3 0 0; 8 2 8 32; 4 16 0 0; 12 18 0 0];
% dimHeight=  [1 4 0 0; 6 3 6 12; 9 3 0 0; 8 32 8 2; 4 1 0 0; 3 2 0 0];

expression=[7 1 2 V H 3 4 V 5 6 V H H];
dimWidth= [2 1 4 8; 1 1 0 0; 8 2 4 1; 2 1 0 0; 1 4 16 4; 4 4 0 0; 1 1 2 2];
dimHeight=[4 8 2 1; 4 4 0 0; 1 4 2 8; 8 16 0 0; 16 4 1 4; 4 4 0 0; 2 2 1 1];

t=polish2tree(expression);
[boxWidth, boxHeight, area]=getBox(expression, t, dimWidth, dimHeight);

Best_area= annl(expression, t, dimWidth, dimHeight);