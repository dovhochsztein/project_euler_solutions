
% n=[100:10:150,200,250,300,400,500,600];
n=200;
t=zeros(1,length(n));
for i=1:length(n)
    tic
ranges = {[1:n(i)],[1:n(i)]};
a=1;
b=2;
inputs={a,b};
inputs={'a','b';a,b};
N=length(ranges);
dinputs=cell(1,N);
[dinputs{1:N}]=ndgrid(ranges{:});
dinputs=[{'axes';dinputs}];

clear dinputs
dinputs=cell(1,N);
[dinputs{1:N}]=ndgrid(ranges{:});
dinputs=[{'X','Y'};dinputs];
X=dinputs{2,1};
Y=dinputs{2,2};
[X,Y]=ndgrid(ranges{:});
[axes{1:N}]=ndgrid(ranges{:});
% clear dinputs
% clear inputs
lpcmnds={'A',@(a,b,X,Y) a*X + b*Y,{'a',{'input',2},'X',{'dinput',2}};...
         'B',@(a,b,X,Y,A) b*X + a*Y+A,{{'input',1},'b',{'dinput',1},'Y',{'output',1}}};
lpcmnds={'A',@(a,b,X,Y) a*X + b*Y,[];...
         'B',@(a,b,X,Y,A) b*X + a*Y+A,[]};
lpcmnds={'A',@(a,b,X,Y) a*X + b*Y;...
         'B',@(a,b,X,Y,A) b*X + a*Y+A};
lpcmnds={'A',@(X,Y) a*X + b*Y;...
         'B',@(X,Y,A) b*X + a*Y+A};
lpcmnds={'A',@(axes) sum([a,b].*axes);...
         'B',@(axes,A) sum([b,a].*axes)+A};
lpcmnds={'A',@(axes) norm(axes)};
%[A,B] = ndloop(ranges,lpcmnds,dinputs,inputs);
ndloop(ranges,lpcmnds);
t(i)=toc;
end

% figure;
% hold on
% % plot(n,t)
% l=polyfit(n,t,3);
% fplot(@(x) polyval(l,x))
% f=fit(n',t','power1')
% plot(f,n,t);