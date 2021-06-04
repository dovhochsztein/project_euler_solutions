M=20000000;
N=15000000;

ints=zeros(1,M-N);
denom=1:N/4;
for i=1:M-N
    if ~mod(1-i,4)
        ints(i)=4;
    else
        ints(i)=M+1-i;
    end
end

SUM=0;
for i=1:length(ints)
    SUM=SUM+sum(factor(ints(i)));
end
for i=1:length(denom)
    SUM=SUM-sum(factor(denom(i)));
end
vpi(SUM)+1
sum(factor(nchoosek(M,N)))