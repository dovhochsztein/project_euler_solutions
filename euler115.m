n=1000;
m=50;
A=ones(1,n);
S=zeros(1,n);
A(m)=2;
A(m+1)=4;
S(m)=1;
S(m+1)=2;

for i=m+2:n
    for j=m:i-2
    S(i)=S(i)+A(i-j-1);
    end
    S(i)=S(i)+2;
    A(i)=sum(S(1:i))+1;
    if A(i)>10^6
        break
    end
end
i