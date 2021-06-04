function [f,g]=euler190f(x)

m=length(x)+1;
vec=2:m;
pr=prod(x.^vec);
f=-(m-sum(x))*pr;
if f>0
    f=0;
end
if nargout>1
    for i=1:m-1
        if f>0
            g(i)=-1;
        else
            g(i)=-(m-sum(x))*pr*(i+1)/x(i)-pr;
        end
    end
end
end