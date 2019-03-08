%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Description:   This function takes area of boxes and create a floorplan
%               for those boxes.
%
%
%Dependencies:  buildRelations, transClosure, transReduction,
%               optimalPlacement, 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Rect(a)
% a = [70; 20; 40; 15; 100; 20; 230; 35; 145; 25];
%   cut=5
%   a = randperm(100,cut+1)%[10; 20; 40; 25; 10];
% %   a=[8; 12; 8 ;12; 20; 24; 30; 30; 16; 20;77;85;66;10;20;12;5;25;28; 44]
% a=[6.2500;    6.2500;    6.2500;    6.2500;   12.5000]

% a=a'
%============================================================================
[ L, U ] = buildRelations(a);
%-----------------------------------------------
 
  
%------------------------------------------------------
    H = transReduction(L);
    V = transReduction(U);

%   gH = drawgraph(H); view(gH);
%   gV = drawgraph(V); view(gV);

   [ x, y, w, h, Rect_W, Rect_H ] = optimalPlacement(H,V,a);
% Rect_W=ceil(Rect_W)
% Rect_H=ceil(Rect_H)
n = length(a);
%   x=ceil(x)
for i=1:n
    fill([x(i); x(i)+w(i); x(i)+w(i); x(i)],[y(i);y(i);y(i)+h(i);y(i)+h(i)],0.90*[1 1 1]);
    hold on;
end
area=[];
for i=1:n
    xx=x(i)+w(i)/2;
    yy=y(i)+h(i)/2;
    t = text(xx, yy,[int2str(i)]);
    set(t, 'HorizontalAlignment', 'center');
    set(t, 'VerticalAlignment', 'middle');
%     set(t, 'BackgroundColor', 'white');
    set(t, 'FontWeight', 'bold');
    set(t, 'FontName', 'Cambria');
    area(i,:)= [x(i)+w(i)/2   y(i)+h(i)/2  ];
end

axis([0 Rect_W 0 Rect_H]);
axis equal; axis off;