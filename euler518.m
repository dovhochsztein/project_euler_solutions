N=10^8;
% P=primes(N);
% SUM=0;
% list=[];
% for i=1:length(P)-2
%     a=P(i);
%     fac=factor(a+1);
%     j=1;
%     div=1;
%     while j<=length(fac)
%         num=sum(fac==fac(j));
%         div=div*fac(j)^floor(num/2);
%         j=j+num;
%     end
%     for j=i+1:length(P)-1
%         b=P(j);
%         mult=(b+1)/(a+1);
%         if (b+1)*mult>N
%             break
%         end
%         if ~mod(div*(b+1)/(a+1),1)
%             c=uint32(b+1)^2/uint32(a+1)-1;
%             if any(c==P)
%                 SUM=SUM+a+b+c;
% %                 list=[list;[a,b,c]];
%             end
%         end
%     end
% end

% tol=10^-6;
P=primes(N);
% P0=primes(sqrt(N));
SUM2=0;
list2=[];
for i=1:length(P)-2
    a=P(i);
    fac=factor(a+1);
    j=1;
    div=1;
    while j<=length(fac)
        num=sum(fac==fac(j));
        div=div*fac(j)^floor(num/2);
        j=j+num;
    end
    for mult=div+1:floor(sqrt(N/(a+1))*div)
        b=uint32(a+1)/uint32(div)*mult-1;
        if b<17
            lower=1;
        else
            lower=(double(b)/log(double(b)));
        end
        upper=min(ceil(1.25506*(double(b)/log(double(b)))),length(P)); %prime bounds
        lower=min(floor(lower),length(P));
        
%         bbounds=log(b)+log(log(b))
        
        if any(b==P(lower:upper))
            c=uint32(a+1)/uint32(div)^2*mult^2-1;
            if c<17
            lower=1;
        else
            lower=(double(c)/log(double(c)));
        end
        upper=min(ceil(1.25506*(double(c)/log(double(c)))),length(P));
        lower=min(floor(lower),length(P));
            if any(c==P(lower:upper))
%         cond=false;
%         for k=1:length(P)
%             if P(k)==b
%                 cond=true;
%                 break
%             elseif P(k)>b
%                 break
%             end
%         end
%         if cond && ismember(c,P)
%         if ismember(b,P) && ismember(c,P)
%             if isprime(b) && isprime(c)
%         if any(abs(b-P)<tol) && any(abs(c-P)<tol)
            SUM2=SUM2+a+b+c;
%             list2=[list2;[a,b,c]];
%             a,b,c
            end
        end
    end
end
SUM2
