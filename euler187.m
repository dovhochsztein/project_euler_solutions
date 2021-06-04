N=10^8;

P=primes(N/2);
P2=primes(sqrt(N));
count=0;

for i=1:length(P2)
    count=count+sum(P(i:end)<=floor(N/P2(i)));
end
count


% count2=0;
% for i=1:N
%     if length(factor(i))==2
%     count2=count2+1;
%     end
% end
% count2