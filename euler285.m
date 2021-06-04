% syms k
% syms a

N=10^5;
abstol=1.e-16;
reltol=1.e-10;

result=@(k,a,b) sqrt((k*a+1)^2+(k*b+1)^2);

amax=@(k) (sqrt((k+.5).^2-1)-1)/k;
bmax=@(k,a) (sqrt((k+.5).^2-(k*a+1).^2)-1)/k;
bmin=@(k,a) (sqrt((k-.5).^2-(k*a+1).^2)-1)/k;

prob=zeros(1,N);
k=1;
int1=@(a) bmax(k,a);

prob(1)=integral(int1,0,amax(k));


for k=2:N

acrit=max(0,(sqrt((k-.5).^2-1)-1)/k);

int1=@(a) bmax(k,a);
int2=@(a) bmax(k,a)-bmin(k,a);



prob(k)=integral(int2,0,acrit,'AbsTol',abstol,'RelTol',reltol)+integral(int1,acrit,amax(k),'AbsTol',abstol,'RelTol',reltol);




end

sum(prob.*(1:N))

% figure;
% hold on
% fplot(@(a) bmin(k,a),[0,1])
% fplot(@(a) bmax(k,a),[0,1])
% plot(acrit,0,'ro')
% xlim([.99,1])
% ylim([0,.01])
% 
% figure;
% plot(1:N,prob.*(1:N))