P=primes(2*10^7);
P=P(find(P>10^7));

digit_matrix=zeros(10,7);
digit_matrix(0+1,[1,2,3,4,5,6])=1;
digit_matrix(1+1,[4,5])=1;
digit_matrix(2+1,[3,4,7,1,6])=1;
digit_matrix(3+1,[3,4,7,5,6])=1;
digit_matrix(4+1,[2,7,4,5])=1;
digit_matrix(5+1,[3,2,7,5,6])=1;
digit_matrix(6+1,[1,2,3,5,6,7])=1;
digit_matrix(7+1,[2,3,4,5])=1;
digit_matrix(8+1,[1,2,3,4,5,6,7])=1;
digit_matrix(9+1,[2,3,4,5,6,7])=1;

blank=sum(digit_matrix');
transcost=zeros(10,10);
for i=1:10
    for j=1:10
        transcost(i,j)=sum(xor(digit_matrix(i,:),digit_matrix(j,:)));
    end
end

costs0=zeros(1,64);
costm0=zeros(1,64);

decs=cell(1,64);

for d=1:64
    digsa=ceil(log10(d+1));
    A=zeros(1,digsa);
    for j=1:digsa
        A(digsa+1-j)=floor(mod(d,10^(j))/10^(j-1));
    end
    decs{d}=A;
    dold=d;
    
    while 1
        digsa=ceil(log10(dold+1));
        if digsa==1
            break
            
        end
        A=zeros(1,digsa);
        for j=1:digsa
            A(digsa+1-j)=floor(mod(dold,10^(j))/10^(j-1));
        end
        dnew=sum(A);
        digsb=ceil(log10(dnew+1));
        B=zeros(1,digsb);
        for j=1:digsb
            B(digsb+1-j)=floor(mod(dnew,10^(j))/10^(j-1));
        end
        for j=1:digsa-digsb
            costs0(d)=costs0(d)+blank(A(j)+1);
            costm0(d)=costm0(d)+blank(A(j)+1);
        end
        for j=1:digsb
            costs0(d)=costs0(d)+blank(A(j+digsa-digsb)+1)+blank(B(j)+1);
            costm0(d)=costm0(d)+transcost(A(j+digsa-digsb)+1,B(j)+1);
        end
        dold=dnew;
    end
    costs0(d)=costs0(d)+blank(dold+1);
    costm0(d)=costm0(d)+blank(dold+1);
end

costs=0;
costm=0;
for d=P
    digsa=8;
    A=zeros(1,digsa);
    for j=1:digsa
        A(digsa+1-j)=floor(mod(d,10^(j))/10^(j-1));
    end
    for j=1:digsa
        costs=costs+blank(A(j)+1);
        costm=costm+blank(A(j)+1);
    end
    new=sum(A);
    costs=costs+costs0(new);
    costm=costm+costm0(new);
    % digsb=ceil(log10(dnew+1));
    % B=zeros(1,digsb);
    % for j=1:digsb
    %     B(digsb+1-j)=floor(mod(dnew,10^(j))/10^(j-1));
    % end
    B=decs{new};
    digsb=length(B);
    for j=1:digsa-digsb
        costs=costs+blank(A(j)+1);
        costm=costm+blank(A(j)+1);
    end
    for j=1:digsb
        costs=costs+blank(A(j+digsa-digsb)+1)+blank(B(j)+1);
        costm=costm+transcost(A(j+digsa-digsb)+1,B(j)+1);
    end
end
costs-costm