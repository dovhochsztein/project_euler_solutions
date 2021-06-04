N=10^9;
n=1000;
xmin=@(f) (log(N)-n*log(1-f))/(log(1+2*f)-log(1-f));
f=fminbnd(xmin,0,1);
x=ceil(xmin(f))



prob=@(x) nchoosek(n,x)*.5^x*.5^(n-x);

P=0;
for i=x:n
    P=P+prob(i);
end
round(P,12)