syms P0
syms P1
syms P2
syms P3
syms t
syms v
Q0=P0+(P1-P0)*t;
Q1=P1+(P2-P1)*t;
Q2=P2+(P3-P2)*t;

R0=Q0+(Q1-Q0)*t;
R1=Q1+(Q2-Q1)*t;

B=R0+(R1-R0)*t;

P0=[1,0];
P1=[1,v];
P2=[v,1];
P3=[0,1];

B=subs(B);
integrand=B(1)*diff(B(2),t);
area=int(integrand,t,0,1);

area=matlabFunction(area);
eqn=area(v)==pi/4;
sol=solve(eqn,v);
V=double(sol);

% V=fsolve(@(v) area(v)-pi/4,.5);

arcint=sqrt(diff(B(1),t)^2+diff(B(2),t)^2);
arcint=matlabFunction(arcint);
arc=integral(@(t) arcint(t,V(1)),0,1,'RelTol',1e-15,'AbsTol',1e-20)

% subs(arc)
100*(arc-pi/2)/(pi/2)

X0=matlabFunction(B(1));
X=@(t) X0(t,V(1));
Y0=matlabFunction(B(2));
Y=@(t) Y0(t,V(1));
t=linspace(0,1,10001);
x=X(t);
y=Y(t);
figure;
hold on
plot(x,sqrt(1-x.^2),'-.');
plot(x,y,':');
plot(P0(1),P0(2),'ro');
v=V(1);
P1=subs(P1);
P2=subs(P2);
plot(P1(1),P1(2),'ro');
plot(P2(1),P2(2),'ro');
plot(P3(1),P3(2),'ro');