d=1000000;
count=0;
for i=1:d
    facs=unique(factor(i));
    for j=1:i-1
        breaker=false;
        for k=1:length(facs)
            if ~mod(j,facs(k))
                breaker=true;
                break
            end
            
        end
        if breaker
            continue
        end
        count=count+1;
    end
end
count