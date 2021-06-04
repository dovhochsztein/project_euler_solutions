N=51;
list=[];
for i=0:N-1
    for j=0:i
        fac=factor(nchoosek(i,j));
        k=1;
    multiplicities=[];
    while k<=length(fac)
        num=sum(fac==fac(k));
        multiplicities=[multiplicities,num];
        k=k+num;
    end
    if ~any(multiplicities>1)
        list=[list,nchoosek(i,j)];
    end
    end
end
sum(vpi(unique(list)))