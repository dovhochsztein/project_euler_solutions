list=[];
for a=11:99
    digs=2;
    A=zeros(1,digs);
    for j=1:digs
        A(digs+1-j)=floor(mod(a,10^(j))/10^(j-1));
    end
    if any(A==0)
        continue
    end
    for b=111:999
        digs=3;
        B=zeros(1,digs);
        for j=1:digs
            B(digs+1-j)=floor(mod(b,10^(j))/10^(j-1));
        end
        if any(B==0) || length(unique([A,B]))~=(length(A)+length(B))
            continue
        end
        c=a*b;
        if c>9999
            break
        end
        digs=4;
        C=zeros(1,digs);
        for j=1:digs
            C(digs+1-j)=floor(mod(c,10^(j))/10^(j-1));
        end
        if any(C==0)
            continue
        end
        pands=unique([A,B,C]);
        if length(pands)~=9 || ~all(pands==[1:9])
            continue
        end
        list=[list;[a,b,c]];
    end
end


for a=1:9
    digs=1;
    A=zeros(1,digs);
    for j=1:digs
        A(digs+1-j)=floor(mod(a,10^(j))/10^(j-1));
    end
    if any(A==0)
        continue
    end
    for b=1111:9999
        digs=4;
        B=zeros(1,digs);
        for j=1:digs
            B(digs+1-j)=floor(mod(b,10^(j))/10^(j-1));
        end
        if any(B==0) || length(unique([A,B]))~=(length(A)+length(B))
            continue
        end
        c=a*b;
        if c>9999
            break
        end
        digs=4;
        C=zeros(1,digs);
        for j=1:digs
            C(digs+1-j)=floor(mod(c,10^(j))/10^(j-1));
        end
        if any(C==0)
            continue
        end
        pands=unique([A,B,C]);
        if length(pands)~=9 || ~all(pands==[1:9])
            continue
        end
        list=[list;[a,b,c]];
    end
end
sum(unique(list(:,3)))