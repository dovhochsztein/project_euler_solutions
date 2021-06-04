% r=@(a,b) a.*b*sqrt(3)/2./(a+b+sqrt(a.^2+b.^2-a.*b));
% [A,B]=meshgrid([1:10],[1:10]);
% R=r(A,B);
% figure;
% surf(A,B,R);
%
% d=c-a
% a=1;
% d=5;
% b=(a+sqrt(a^2+8*a*d+4*d^2))/2;
% a=(b^2-d^2)/(2*d+b);

rmax=1000;
bmax=ceil(2*rmax/sqrt(3));

breaker=false;
list=[];
L=100000;
for b=setdiff(1:L,primes(L))%*bmax
    %(b*sqrt(3)-4*rmax)
    %dmin=(-3*b*rmax+sqrt(9*b^2*rmax^2+(4*rmax+b*sqrt(3)-4*rmax)*(b*sqrt(3)-4*rmax)))/(4*rmax+b*sqrt(3)-4*rmax)*(b*sqrt(3)-4*rmax);
    dmin=max(1,ceil(b-6*rmax/sqrt(3)));
%     if dmin>1
%         a=(b^2-dmin^2)/(2*dmin+b);
%         if a*b*sqrt(3)/(2*(a+b+a+dmin))>rmax
%             break;
%         end
%     end
    if mod(b,2)
        range=dmin:b-1;
    else
        range=dmin+mod(dmin,2):2:b-2;
    end
    for d=range
        if mod(b^2-d^2,2*d+b)
            continue
        end
        a=(b^2-d^2)/(2*d+b);
        
%         if mod(a,1)
%             continue
%         end
        c=a+d;
        c=sqrt(a^2+b^2-a*b);
        r=a*b*sqrt(3)/(2*(a+b+c));
        if r>rmax
            break
        end
        list=[list;[a,b,c,d,b-d,r,length(factor(b))]];
    end
    if breaker
        break
    end
end





for d=dmin:b-1
    a=(b^2-d^2)/(2*d+b);
    %         if d==dmin && d>1 && a*b*sqrt(3)/(2*(a+b+a+d))>rmax && b>1000
    %                 breaker=true;
    %             end
%     if mod(a,1)
%         continue
%     end
    c=a+d;
    c=sqrt(a^2+b^2-a*b);
    r(d-dmin+1)=a*b*sqrt(3)/(2*(a+b+c));
%     if r>rmax
%         break
%     end
end