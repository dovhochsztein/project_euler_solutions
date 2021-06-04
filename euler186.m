L=200000;

S=zeros(2,L);
for k=1:55
    S(k)=mod(100003 - 200003*k + 300007*k^3,1000000);
end
for k=56:2*L
    S(k)=mod(S(k-24)+S(k-55),1000000);
end

A=cell(1,L);
A{1}=unique(S(:));
for i=1:L
    if S(1,i)==S(2,i)
        continue
    end
    for j=1:2
        for k=1:L
            if any(any(S(j,i)==A{k}))
                match(j,:)=[k,mod(find(S(j,i)==A{k}),size(A{k},1))];
                break
            end
        end
    end
    for j=1:2
        
    end
end