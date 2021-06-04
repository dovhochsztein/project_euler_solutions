N=10^7;
rat=1000;
ANS=0;
for n=2:N
    phi=totient(n);
    digs=ceil(log10(n+1));
    if ceil(log10(phi+1))~=digs
        continue
    end
    A=zeros(1,digs);
    B=zeros(1,digs);
for j=1:digs
    A(digs+1-j)=floor(mod(n,10^(j))/10^(j-1));
    B(digs+1-j)=floor(mod(phi,10^(j))/10^(j-1));
end
    if all(sort(A)==sort(B))
        if n/phi<rat
            rat=n/phi;
            ANS=n;
        end
    end
end
ANS