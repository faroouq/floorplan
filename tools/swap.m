function swap=swap(expresion)

 
flg=0;
while flg==0
p=randi(max(expresion),1);
q=randi(max(expresion),1);
flg=and(expresion(p)>0 ,expresion(q)>0);
end;
flg=0;
 while flg==0
p1=randi(max(expresion),1);
q1=randi(max(expresion),1);
flg=and(expresion(p1)<0 ,expresion(q1)<0);
end;
if rand()<0.8
x=expresion(p);
expresion(p)=expresion(q);
expresion(q)=x;
else
 x=expresion(p1);
expresion(p1)=expresion(q1);
expresion(q1)=x;
end
    
 
swap=expresion;
end