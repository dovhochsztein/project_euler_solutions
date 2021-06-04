N=10^6;
offset=100;
P=primes(N);
IJK=[];
for i=P
    for j=1:length(P)-offset-1
        SUM=sum(P(j:j+offset-1));
        for k=offset:i-j%%
            SUM=SUM+P(j+k);
            if SUM>i
                break
            end
            if SUM==i
                if k>offset
                    IJK=[IJK;i,P(j),k+1];
                end
                break
            end
        end
    end
end
IJK(find(IJK(:,3)==max(IJK(:,3)),1))