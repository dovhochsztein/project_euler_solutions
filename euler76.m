P=1:100;
N=100;

a=cell(1,N);
a{1}=1;
a{2}=[2,1]; %2
a{3}=[3,1,1]; %3


nstart=3;
index=2; %number of primes less than n
LIM=1; %num primes less than or equal to n/2

for n=nstart:N
    
    if n==P(index+1)
        index=index+1;
        a{n}=ones(1,index);
    else
        a{n}=zeros(1,index);
    end
    to_add=a{n-P(1)}(1);
    a{n}=a{n}+[to_add,zeros(1,length(a{n})-length(to_add))];
    if n/2==P(LIM+1)
        LIM=LIM+1;
    end
        
    for i=2:LIM
        without=a{n-P(i)}(i);
        to_add=ones(1,i)*without;
        a{n}=a{n}+[to_add,zeros(1,length(a{n})-length(to_add))];
    end
end



a{100}(1)-1