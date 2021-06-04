p=5;
q=2;
m=p^2-q^2;
n=2*p*q;
s=p^2+q^2;
a=abs(m^2-n^2);
b=2*m*n;
c=s^2;
area=1/2*a*b

area=@(p,q) 2*p.^7.*q-14.*p.^5.*q.^3+14.*p.^3.*q.^5-2.*p.*q.^7
area/6
area/28


mod([1:30].^2,3)