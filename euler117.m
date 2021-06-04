N=50;

R=ones(1,N);
G=ones(1,N);
B=ones(1,N);
R(2)=2;
R(3)=3;
R(4)=5;

G(3)=2;
G(4)=3;

B(4)=2;

for i=5:N
    R(i)=R(i-2)+R(i-3)+R(i-2);
    if i>5
    G(i)=G(i-3)+G(i-4)+G(i-5)+G(i-3);
    else
        G(i)=G(i-3)+G(i-4)+1+G(i-3);
    end
    B(i)=B(i-4)*2;
    for j=5:7
       if j==i
           B(i)=B(i)+1;
       elseif j<i
           B(i)=B(i)+B(i-j);
       end
    end
end

int64(B(end)+G(end)+R(end)-3)


T=zeros(1,N);
T(1)=1;
T(2)=2;
T(3)=4;
T(4)=8;
for i=5:N
    T(i)=T(i-4)+T(i-3)+T(i-2)+T(i-1);
end
int64(T(end))