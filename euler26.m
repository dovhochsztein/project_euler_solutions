N=1000;
cycle=zeros(1,N);
L=1000;


for D=1:1000
    prime=factor(D);
    if all((prime==2)|(prime==5))
        cycle(D)=0;
    else
        num=D/2^sum(prime==2)/5^sum(prime==5);
        REM=0;
        for i=1:L
            REM=rem(10*REM+9,num);
            if REM==0
                cycle(D)=i;
                break
            end
        end
        if i==1000
            i
        end
    end
end
