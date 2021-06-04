n=4;

nums=[];
for i=1:1000000
    breaker=false;
    for j=1:n
        if length(unique(factor(i-1+j)))>=n
            continue
        else
            breaker=true;
            break
        end
    end
    if j==n & ~breaker
        nums=[nums,i];
        break
    end
end