

N=100000;
part=zeros(1,N);
part(1)=1;

K=100000;
ks=(-1).^((1:K)+1).*ceil((1:K)/2);

for i=2:N
    for k=ks
        pent=k*(3*k-1)/2;
        if pent>=i
            break
        end
        part(i)=mod(part(i)+(-1)^(k+1)*part(i-pent),10^6);
    end
    if k==ks(end)
        error('')
    end
    if part(i)==0
        break
    end
end
i-1
