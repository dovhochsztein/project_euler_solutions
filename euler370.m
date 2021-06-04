% LIM=100000;
% phi=(1+sqrt(5))/2;
% num=0;
% list=[];
% 
% for a=1:floor(LIM/3)
%     
% %     A=factor(a);
% %     i=1;
% %     odds=[];
% %     while i<=length(A)
% %         count=sum(A==A(i));
% %         if mod(count,2)
% %             odds=[odds,A(i)];
% %         end
% %         i=i+count;
% %     end
% %     cmult=prod(odds);
% %     cmin=a;
%     phimax=min(phi,-.5+sqrt(1+4*(LIM/a-1))/2);
%     for b=a:floor(a*phimax)
%     if ~(mod(mod(b,a)*b,a))
%         num=num+1;
%     end
%     end
% end
% num







LIM=10000000;
phi=(1+sqrt(5))/2;
num=0;
list=[];

for a=1:floor(LIM/3)
    
    A=factor(a);
    i=1;
    odds=[];
    while i<=length(A)
        count=sum(A==A(i));
        if mod(count,2)
            odds=[odds,A(i)];
        end
        i=i+count;
    end
    cmult=prod(odds);
    cmin=a;
    phimax=min(phi,-.5+sqrt(1+4*(LIM/a-1))/2);
    cmax=floor(a*phimax^2);
    smin=sqrt(cmin/cmult);
    smax=floor(sqrt(cmax/cmult));
    for s=smin:smax
%         c=cmult*s^2;
%         b=sqrt(a*c);
        num=num+1;
    end
end
num