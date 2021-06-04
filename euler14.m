N=1000000;
chains=zeros(1,N);
for i=1:N
    n=i;
    for counter=1:100000
        if n==1
            break
        end
        if mod(n,2)
            n=3*n+1;
        else
            n=n/2;
        end
    end
    chains(i)=counter;
end
find(chains==max(chains))