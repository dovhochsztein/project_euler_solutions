digit_lengths=[0,3,3,5,4,4,3,5,5,4];
tens_lengths=[length('twenty'),length('thirty'),length('forty'),length('fifty'),length('sixty'),length('seventy'),length('eighty'),length('ninety')];
teens_lengths=[length('ten'),length('eleven'),length('twelve'),length('thirteen'),length('fourteen'),length('fifteen'),length('sixteen'),length('seventeen'),length('eighteen'),length('nineteen')];

count=0;
for i=1:1000
    digs=ceil(log10(i+1));
    A=zeros(1,digs);
    for j=1:digs
        A(digs+1-j)=floor(mod(i,10^(j))/10^(j-1));
    end
    if digs==1
        count=count+digit_lengths(i+1);
    elseif digs==2
        if A(1)==1
            count=count+teens_lengths(A(2)+1);
        else
            count=count+tens_lengths(A(1)-1)+digit_lengths(A(2)+1);
        end
    elseif digs==3
        count=count+digit_lengths(A(1)+1)+length('hundred');
        if A(2)+A(3)>0
            count=count+length('and');
            if A(2)==1
                count=count+teens_lengths(A(3)+1);
            elseif A(2)==0
                count=count+digit_lengths(A(3)+1);
            else
                count=count+tens_lengths(A(2)-1)+digit_lengths(A(3)+1);
            end
        end
    else
        count=count+length('onethousand');
    end
end
count
