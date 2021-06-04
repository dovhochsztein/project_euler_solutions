clear;
N=10000000;
N=999999;

bouncy=0;
non_bouncy=0;
% bouncy=zeros(1,N);
% proportion=zeros(1,N);
As=1:N;
for A=As
    digs=ceil(log10(A+1));
    dec=zeros(1,digs);
    for j=1:digs
        dec(digs+1-j)=floor(mod(A,10^(j))/10^(j-1));
    end
    inc=sign(dec(1:end-1)-dec(2:end));
    if any(inc==-1) && any (inc==1)
        %         bouncy(A)=true;
        bouncy=bouncy+1;
    else
        %         bouncy(A)=false;
        non_bouncy=non_bouncy+1;
    end
    %     proportion(A)=sum(bouncy==true)/A;
    proportion=bouncy/(bouncy+non_bouncy);
    if proportion>=.99
        break
    end
end
A
% proportion(A);
% plot(As,proportion)