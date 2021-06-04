N=5;
P=primes(10^N);
B=find(P(4:end)-P(1:end-3)==8);


grand=0;
n=0;
for i=length(B):-1:floor(length(B)*.2)
    if P(B(i))*6<grand
        break
    end
p=P(B(i));
SUM=0;
for j=0:8
    fac=factor(p+j);
    SUM=SUM+fac(end);
end
if SUM>grand
    grand=SUM;
    n=P(B(i));
end
end



for i=1:10^N
    TPC=i^2-1;
    for j=fliplr(primes(TPC^(1/4)))
        if ~mod(TPC/j,1)
            1;
        end
    end
end