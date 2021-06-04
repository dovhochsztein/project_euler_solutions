% x=linspace(0,2,101);
% y=2-x;
% P=x.*y.^2;
% figure;
% plot(x,P)
% p=@(x) x*(2-x)^2;
% p(2/3)
% M=find(P==max(P(:)));
% x(M)
% y(M)
%
%
% x=linspace(0,3,101);
% [X,Y]=meshgrid(x,x);
% Z=(3-X-Y).*(3-X-Y>0);
% P=X.*Y.^2.*Z.^3;
% figure;
% surf(X,Y,P)
% M=find(P==max(P(:)));
% X(M)
% Y(M)
% Z(M)


tot=0;
for m=1:14
    vec=2:m;
    P=@(x) -(m-sum(x))*prod(x.^vec);
    x0=ones(1,m);
    options = optimoptions('fminunc','Algorithm','trust-region','SpecifyObjectiveGradient',true,'display','off');
    P = @euler190f;
    x=fminunc(P,x0)
    % [f,g]=euler190f(1.333333)
    -P(x)
    if m==1
        diffs(m)=x-1;
    else
        diffs(m)=x(end)-x(end-1);
    end
    x=linspace(0,2,m+3);
    x=x(3:end-1);
    -P(x)
    tot=tot-ceil(P(x));
end
int64(tot)