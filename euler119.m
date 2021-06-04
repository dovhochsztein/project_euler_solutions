a0=2;
% A=[];
list=[];
for p0=46:45
    T=a0^p0;
    T=[];
    for p=2:p0-1%:-1:1
        for a=ceil(2^((p0-1)/p)):floor(2^(p0/p))
            T=[T,a^p];
        end
    end
    A=[A,unique(T)];
end
for i=2:length(A)
    d=A(i);
    if d==(A(i-1))
        continue
    end
    if d<=10
        continue
    end
    digs=ceil(log10(d+1));
    SUM=0;
    for j=1:digs
        SUM=SUM+floor(mod(d,10^(j))/10^(j-1));
    end
    if SUM>1 && (SUM)^round(log(d)/log(SUM),0)==d%~mod(log(d)/log(SUM),1)
        list=[list,d];
        if length(list)==30
            break
        end
    end
end
% 
% list2=[];
% for d=10:10^6
%     digs=ceil(log10(d+1));
%     SUM=0;
%     for j=1:digs
%         SUM=SUM+floor(mod(d,10^(j))/10^(j-1));
%     end
%     if SUM>1 && (SUM)^round(log(d)/log(SUM),0)==d%~mod(log(d)/log(SUM),1)
%         list2=[list2,d];
%         if length(list2)==30
%             break
%         end
%     end
% end