N=50;

A=ones(1,N);
S=zeros(1,N);
A(3)=2;
A(4)=4;
S(3)=1;
S(4)=2;

for i=5:N
    for j=3:i-2
    S(i)=S(i)+A(i-j-1);
    end
    S(i)=S(i)+2;
    A(i)=sum(S(1:i))+1;
end
int64(A(end))