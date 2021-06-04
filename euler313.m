m=5;
n=4;
near=m-2+n-2+1;
diag=3*(2*min(m,n)-2)-2;
rest=3+5*(m-n-1);
% 8*n-11
6*m+2*n-13;


p=3;
mmin=2;
m=2;
mmax=floor(p^2+13-2*2)/6;
n=(p^2+13-6*m)/2;

list=[];
count=0;
P=primes(10^6);
for p=P(2:end)
    mmin=2;
    mmax=floor((p^2+13-2*2)/6);
    mmin=ceil((p^2+13)/8+.01);
count=count+mmax-mmin+1;
%     for m=mmin:mmax
%         n=(p^2+13-6*m)/2;
%         if n<m
% %             count=count+1;
% %         list=[list;[p,m,n]];
%         end
%     end
end
count*2