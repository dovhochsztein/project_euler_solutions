N=14;
H=cell(1,N);
S=cell(1,N);
SRTHP=[];
H{1}=1:9;
for i=2:N
    for j=1:length(H{i-1})
        strong=false;
        if any(S{i-1}==H{i-1}(j))
            strong=true;
        end
        for k=0:9
            d=H{i-1}(j)*10+k;
            if strong
                if isprime(d)
                    SRTHP=[SRTHP,d];
                end
            end
            digs=i;
            A=zeros(1,digs);
            for l=1:digs
                A(digs+1-l)=floor(mod(d,10^(l))/10^(l-1));
            end
            div=d/sum(A);
            if ~mod(div,1)
                H{i}=[H{i},d];
                if isprime(div)
                    S{i}=[S{i},d];
                end
            end
        end
    end
end
sum(SRTHP)