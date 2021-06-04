N=100;
F=zeros(1,N);
F(1)=1;
F(2)=1;
match=0;
for i=3:N
    F(i)=mod(F(i-1)+F(i-2),10^5);
end