P=primes(1000);
N=200;

a=cell(1,N);
a{1}=0;
a{2}=1; %2
a{3}=[1,1]; %3
a{4}=[1,0]; %2,2
a{5}=[2,1,1]; % 2,3; 5
a{6}=[2,1,0]; % 2,2,2; 3,3
a{7}=[3,1,1,1]; % 2,2,3; 2,5; 7
a{8}=[3,1,0,0]; % 2,2,2,2; 2,3,3; 3,5
a{9}=[4,1,0,0]; % 2,2,2,3; 2,2,5; 2,7; 3,3,3

a{10}=[5,2,1,0]; % 2,2,2,2,2; 2,2,3,3; 2,3,5; 3,7; 5,5
a{11}=[6,2,1,1,1]; %2,2,2,2,3; 2,3,3,3; 2,2,2,5; 2,2,7; 3,3,5; 11

nstart=5;
prime_index=2; %number of primes less than n
LIM=1; %num primes less than or equal to n/2

for n=nstart:N
    
    if n==P(prime_index+1)
        prime_index=prime_index+1;
        a{n}=ones(1,prime_index);
    else
        a{n}=zeros(1,prime_index);
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
    if a{n}(1)>5000
        break
    end
end






% n=10;
% primeupto=4;
% a{n}=zeros(1,primeupto);
% i=1;
% to_add=a{n-P(i)};
% to_add(2)=0;
% a{n}=a{n}+[to_add,zeros(1,length(a{n})-length(to_add))];
% for i=2:3
%     to_add=a{n-P(i)};
%     to_add(1:i+1)=0;
%     a{n}=a{n}+[to_add,zeros(1,length(a{n})-length(to_add))];
% end
