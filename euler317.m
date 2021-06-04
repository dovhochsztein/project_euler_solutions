clear
syms x y th t phi g y0 v0
y=y0+v0*sin(th)*t-1/2*g*t^2;
v0=20;
g=9.81;
y0=100;

X=v0*cos(th)*t;
X=matlabFunction(subs(X));
Y=matlabFunction(subs(y));

TH=linspace(0,pi/2,15);
figure;
hold on
T=linspace(0,10,101);
for i=1:length(TH)
    XX=X(T,TH(i));
    YY=Y(T,TH(i));
    plot(XX,YY);
end
t=x/v0/cos(th);



y=subs(y);
% phi=atan(y/x);
% r=0*th+sqrt(x^2+y^2);

% d=diff(r,th);
d=diff(y,th);
% R=matlabFunction(r);


D=matlabFunction(d);




% eqn=diff(r,th)==0;
% solve(eqn,th)

Y=matlabFunction(y);
step=1;

x=(step:step:600);
% figure;
hold on
for i=1:length(x)
    
%     fplot(@(th) D(th,x(i)),[0,pi]);
    thmax(i)=fzero(@(th) D(th,x(i)),pi/4);
    ys(i)=Y(thmax(i),x(i));
end
% plot(x,ys)
% p=polyfit(x,ys,2)

c=100+(20/9.81)^2*9.81/2;
Yfin=@(x) -0.0122625000000.*x.^2  +  c;

xmax=fsolve(Yfin,100);

integrand=@(x) x.*Yfin(x);
2*pi*integral(integrand,0,xmax)
