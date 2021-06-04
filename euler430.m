N=100;
M=10;

pflip=@(N,i) 1-(i./N.*(N-i+1)./N*2-1./N^2);

P=cell(N,M);
E=zeros(N,M);
m=1;
for n=1:N
    P{n,m}=pflip(n,[1:n]);
    E(n,m)=sum(P{n,m});
end
for m=2:M
    for n=1:N
        P{n,m}=(1-P{n,m-1}).*(1-P{n,1})+(P{n,m-1}).*(P{n,1});
        E(n,m)=sum(P{n,m});
    end
end
E(end)