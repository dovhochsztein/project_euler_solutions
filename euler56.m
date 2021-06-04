N=100;
MAX=0;
for a=1:N
    digs=ceil(log10(a+1));
    A0=zeros(1,200);
    for j=1:digs
        A0(200+1-j)=floor(mod(a,10^(j))/10^(j-1));
    end
    A=A0;
    for b=2:N
        A=A*a;
        for j=200:-1:2
            if A(j)>=10
                A(j-1)=A(j-1)+floor(A(j)/10);
                A(j)=A(j)-floor(A(j)/10)*10;
            end
        end
        if sum(A)>MAX
            MAX=sum(A);
        end
    end
end
MAX