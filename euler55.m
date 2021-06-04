list=[];
for i=1:10000
    digs=ceil(log10(i+1));
    A=zeros(1,digs);
    for j=1:digs
        A(digs+1-j)=floor(mod(i,10^(j))/10^(j-1));
    end
    broke=false;
    for iter=1:50
        S=A+A(end:-1:1);
        for j=digs:-1:2
            if S(j)>=10
                S(j-1)=S(j-1)+floor(S(j)/10);
                S(j)=S(j)-floor(S(j)/10)*10;
            end
        end
        if S(1)>=10
            S=[0,S];
            S(1)=floor(S(2)/10);
            S(2)=S(2)-floor(S(2)/10)*10;
            digs=digs+1;
        end
        if all(S==S(end:-1:1))
            broke=true;
            break
        end
        A=S;
    end
    if ~broke
        list=[list,i];
    end
end
length(list)