N=500;
P=ones(N,1)*.002004;
P(1)=P(2)/2;
P(500)=P(2)/2;
% P=1/N*ones(N,1);
A=sparse(N,N);
for i=2:N-1
    A(i,i+1)=.5;
    A(i,i-1)=.5;
end
A(1,2)=1;
A(500,499)=1;


for j=1:10000000
    Pold=P;
    P=A'*P;
    if sum(abs(P-Pold))<1e-6;
        break
    end
end

figure;
plot(2:N-1,P(2:N-1));


PP=


pr=primes(N);
Pprime=0;
for i=1:N
    if any(i==pr)
        Pprime=Pprime+P(i);
    end
end
syms p
syms q
pri=p/q;
p=19038/2;
q=50000;


prob=(2/3*Pprime+1/3*(1-Pprime))^10*(1/3*Pprime+2/3*(1-Pprime))^5;
factorprob=(2/3*pri+1/3*(1-pri))^10*(1/3*pri+2/3*(1-pri))^5;
subs(factorprob)==prob
