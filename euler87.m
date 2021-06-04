N=50000000;
% N=5000000;
P2=primes(sqrt(N));
list=[];
for i=1:length(P2)
    Rem=N-P2(i)^2;
    P3=primes((Rem)^(1/3));
    for j=1:length(P3)
    Rem2=Rem-P3(j)^3;
    P4=primes((Rem2)^(1/4));
    for k=1:length(P4)
        new=P2(i)^2+P3(j)^3+P4(k)^4;
        if new<=N %&& ~any(list==new)
%             list=[list;[P2(i),P3(j),P4(k),P2(i)^2+P3(j)^3+P4(k)^4]];
            list=[list,new];
        end
    end
    end
end
list=unique(list);

length(list)
