P=[1,-1,1,-1,1,-1,1,-1,1,-1,1];
SUM=0;
for i=1:10
    x=[1:i];
    y=polyval(P,x);
    Pi=polyfit(x,y,i-1);
    FIT=polyval(Pi,i+1);
    SUM=SUM+FIT;
end