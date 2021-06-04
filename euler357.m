N=10^8;
list=[1;2];
count=0;
list2=[1;2];
P=primes(N);
for i=3:length(P)
%     div=divisor(P(i)-1);
%     if all(isprime(div+fliplr(div)))
%         list=[list;[P(i)-1]];
% %         factor(P(i)-1)
%     end
n=P(i)-1;
%     p = primes(sqrt(n));
%     p=P(1:find(P>sqrt(n),1)-1);
    p=P(1:ceil(1.2*sqrt(n)/log(sqrt(n))));
f = [];
while n>1,
  d = find(rem(n,p)==0);
  if isempty(d)
    f = [f n];
    break; 
  end
  p = p(d);
  f = [f p];
  n = n/prod(p);
end

f = sort(f);





%     fac=factor(P(i)-1);
    fac=f;
    
    if ~any(sum(fac==fac')>1)
        oddfac=fac(2:end);
        digs=length(fac)-1;
%         div=divisor(P(i)-1);
        
%         div=zeros(2*ones(1,length(fac)));
% comp=P(1:i);
        for j=0:2^digs-1
            add=true;
            output=zeros(1,digs);
            for k=1:digs
                output(digs+1-k)=floor(mod(j,2^(k))/2^(k-1));
            end
%             t=2*prod(oddfac.^output)+prod(oddfac.^(1-output));
            if ~isprime(2*prod(oddfac.^output)+prod(oddfac.^(1-output)))
%             if ~any(2*prod(oddfac.^output)+prod(oddfac.^(1-output))==comp)
%             if ~(comp(find(comp>=t,1))==t)
                add=false;
                break
            end
        end
        if add
%             list=[list;[P(i)-1]];
            count=count+P(i)-1;
        end
        
        
%     if all(isprime(div+fliplr(div)))
%         list2=[list2;[P(i)-1]];
%     end
    end
end
% sum(list)
count+3