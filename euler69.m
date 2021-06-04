% num=10000;
% ratio=zeros(1,num);
% for N=2:num
%     n=1:N-1;
%     ind = gcd(n,N)==1;
%     tot = sum(ind);
%     ratio(N)=N/tot;
% end
% find(ratio==max(ratio))

A=primes(17);
N=prod(A)
n=1:N-1;
ind = gcd(n,N)==1;
tot = sum(ind);
N/tot