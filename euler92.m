list1=[];
list2=[];
count=0;

for N=1:10000000
    n=N;
    while 1
        digs=ceil(log10(n+1));
        A=zeros(1,digs);
        for j=1:digs
            A(digs+1-j)=floor(mod(n,10^(j))/10^(j-1));
        end
        n=sum(A.^2);
        if n==1
            %list1=[list1,N]
            break
        end
        if n==89
            %list2=[list2,N];
            count=count+1;
            break
        end
    end
end
count