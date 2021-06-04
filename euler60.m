numconcat=@(a,b) a*10^floor(log10(b)+1)+b;
N=10000;
p=primes(N^2);
n=5;
SET=cell(1,n);
SET{1}=primes(N);


SET{2}=[];
L(1)=length(SET{1});
for i=1:L(1)
    for j=i+1:L(1)
        if isprime2(p,numconcat(SET{1}(i),SET{1}(j))) && isprime2(p,numconcat(SET{1}(j),SET{1}(i)))
            SET{2}=[SET{2},[SET{1}(i);SET{1}(j)]];
        end
    end
end

for P=3:3

SET{P}=[];
for i=1:L(P-2)
    sub=SET{P-1}(P-1,SET{P-1}(1:P-2,:)==SET{P-2}(:,i));
    l=length(sub);
    for j=1:l
        for k=j+1:l
            if any(all(SET{2}==[sub(j);sub(k)]))
                SET{P}=[SET{P},[SET{P-2}(i);sub(j);sub(k)]];
            end
        end
    end
end

L(P-1)=length(SET{P-1});

SET{4}=[];
for i=1:L(2)
    sub=SET{3}(3,all(SET{3}(1:2,:)==SET{2}(:,i)));
    l=length(sub);
    for j=1:l
        for k=j+1:l
            if any(all(SET{2}==[sub(j);sub(k)]))
                SET{4}=[SET{4},[SET{2}(:,i);sub(j);sub(k)]];
            end
        end
    end
end

L(3)=length(SET{3});

SET{5}=[];
for i=1:L(3)
    sub=SET{4}(4,all(SET{4}(1:3,:)==SET{3}(:,i)));
%     if length(sub)>0
%         break
%     end
    l=length(sub);
    for j=1:l
        for k=j+1:l
            if any(all(SET{2}==[sub(j);sub(k)]))
                SET{5}=[SET{5},[SET{3}(:,i);sub(j);sub(k)]];
            end
        end
    end
end
            
end


function isp = isprime2(p,X)
% isp = all(rem(X, p));
% isp=all(mod(double(X-int64(floor(double(X)./p).*p)),p));
if X<1000
    isp=isprime(X);
else
    upper=min(ceil(1.25506*(sqrt(double(X))/log(sqrt(double(X))))),length(p));
    isp=all(X-int64(floor(double(X)./p(1:upper)).*p(1:upper)));
end
end
sum(SET{5})