N=1000;
SUM=0;
A=2:N;
for i=2:N
    SUM=SUM+i-totient(i);
end
    
B=A-totient(A);
sum(B)*6
SUM*6