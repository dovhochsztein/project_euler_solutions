N=10^3;
u=zeros(1,N);
f=@(x) floor(2^(30.403243784-x^2))*10^-9;
u(1)=f(-1);
for i=2:N
    u(i)=f(u(i-1));
end

g=@(x) f(f(x));
h=@(x) g(x)-x;
ucrit=fzero(h,u(end));
ucrit+f(ucrit)
