n=100;

% list=[];
% for i=1:10000000
%     if max(factor(i))<=n
%         list=[list,i];
%     end
% end

P=primes(n);
ex=9;
N=10^ex;
power_max=floor(ex./log10(P));

powers=cell(1,length(power_max));
for i=1:length(power_max)
    powers{i}=0:power_max(i);
end
POW=combvec(powers{:});


for i1=1:length(powers(1))