m=10;
p=10;
fixed=cell(m,p);
for k=1:p
    for s=1:k-1
        
        M=zeros(1,m);
        for i=1:m%m-k:m
            n=i;
            if n==m
                n=n-s;
            else
            embed=2;
            while embed>0
                if n>m
                    n=n-s;
                    embed=embed-1;
                else
                    n=n+k;
                    embed=embed+1;
                end
            end
            end
            M(i)=n;
        end
        fixed{k,s}=M(M==1:m);
    end
end

list=[];
SUM=0;
a=0;
for i=1:m
    for j=1:p
if length(fixed{i,j})>0
    list=[list;[i,j,length(fixed{i,j})]];
    SUM=SUM+sum(fixed{i,j});
    a=a+length(fixed{i,j});
end
    end
end
