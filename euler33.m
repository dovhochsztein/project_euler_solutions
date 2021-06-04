list=[];
for a=1:9
    for b=0:9
        for c=1:9
            if c==a
                continue
            end
            for d=0:9
                frac=(10*a+b)/(10*c+d);
                set=[a,b,c,d];
                for cancel=unique(set)
                    if cancel~=0 && sum(set==cancel)==2 && sum([a,b]==cancel)==1
                        NUM=[]; DENOM=[];
                        if a==cancel
                            NUM=b;
                        else
                            NUM=a;
                        end
                        if c==cancel
                            DENOM=d;
                        else
                            DENOM=c;
                        end
                        if (10*a+b)/(10*c+d)==NUM/DENOM
                            list=[list;NUM,DENOM];
                        end
                    end
                end
            end
        end
    end
end
pruned=list(1:4,:);
