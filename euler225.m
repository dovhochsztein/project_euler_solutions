N=1000000;
A=zeros(1,N);
A(1)=1;A(2)=1;A(3)=1;
list=[];
for n=27:2:10001
for i=4:N
    A(i)=mod(A(i-1)+A(i-2)+A(i-3),n);
    if A(i)==0
        break
    end
    if A(i)==1 && A(i-1)==1 && A(i-2)==1
        list=[list,n];
        break
    end
end
end
list(124)