SUM=0;
R=30;
for C=3:40
M=ones(1,R);
M(1)=2;
for i=2:R
    n=ceil((M(i-1)-1)/(C-2));
    M(i)=M(i-1)+2*n-1;
end
SUM=SUM+M(end);
end
SUM