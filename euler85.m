A=100;
B=100;

counts=zeros(2,100);
Bs=zeros(1,100);
for A=1:100
    for B=1:10000
        count=0;
        for a=1:A
            for b=1:B
                count=count+(A+1-a)*(B+1-b);
            end
        end
        if count>2000000
            break
        end
    end
    Bs(A)=B;
    counts(2,A)=count;
    B=B-1;
    count=0;
    for a=1:A
        for b=1:B
            count=count+(A+1-a)*(B+1-b);
        end
    end
    counts(1,A)=count;
end

diffs=abs(counts-2000000);
indices=find(diffs==min(min(diffs)));
if counts(indices(1))<2000000
    index=ceil(indices(1)/2);
    offset=-1;
else
    index=ceil(indices(1)/2);
    offset=0;
end
A=index;
B=Bs(index)+offset;
A*B