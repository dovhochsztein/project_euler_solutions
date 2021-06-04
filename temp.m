n=5;

list=[];
for i=1:10000000
    if max(factor(i))<=n
        list=[list,i];
    end
end