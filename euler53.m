combins=zeros(100,100)
for n=1:100
    for r=1:n
        combins(n,r)=nchoosek(n,r);
    end
end
sum(sum(combins>=1000000))