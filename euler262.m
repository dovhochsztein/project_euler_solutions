syms x y
h=( 5000-0.005*(x.*x+y.*y+x.*y)+12.5*(x+y) ) * exp( -abs(0.000001*(x.*x+y.*y)-0.0015*(x+y)+0.7));
grad=[diff(h,x),diff(h,y)];




x=0;
grad=subs(grad);
eqn=grad(2)==0;
ycrit=vpasolve(eqn,y,600);

H=@(x,y) ( 5000-0.005*(x.*x+y.*y+x.*y)+12.5*(x+y) ) .* exp( -abs(0.000001*(x.*x+y.*y)-0.0015*(x+y)+0.7));

Hcrit=double(H(0,ycrit));


% Hcrit=max(H(200,200),H(1400,1400));
[X,Y]=meshgrid([-100:1:1600],[-100:1:1600]);
Z=H(X,Y);
F=find(Z>Hcrit);
XX=X(F);
YY=Y(F);
plot(XX,YY,'r*');

eqn=h==Hcrit;