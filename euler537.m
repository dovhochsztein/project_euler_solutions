N=10;
P=primes(N);
A=1:N;
B=sum(P'<=A);


T=zeros(N,N);
T(1,1)=1;