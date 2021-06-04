for i=1235738580:10:10^+1414213560
    digs=19;
A=zeros(1,digs);
for j=1:digs
    A(digs+1-j)=floor(mod(i,10^(j))/10^(j-1));
end
A=A*i;
for j=digs:-1:1
    if A(j)>=10
        A(j-1)=A(j-1)+floor(A(j)/10);
        A(j)=A(j)-floor(A(j)/10)*10;
    end
end
if A(1)==1 && A(3)==2 && A(5)==3 && A(7)==4 && A(9)==5 && A(11)==6 && A(13)==7 && A(15)==8 && A(17)==9 && A(19)==0
    break
end
end
i