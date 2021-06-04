

SUM=int64(0);
% G(totn,n,totm,m)
% G(3,4,4,6)
% G(2,4,4,6)
% G(576,1003215,56674,1004998)
lower=1000000;
upper=1005000;

tot=int64(zeros(1,upper-lower));
for i=1:length(tot)
    tot(i)=totient(lower+i-1);
end

for n=int64(lower:upper-2)
    totn=tot(n-lower+1);
    for m=int64(n+1:upper-1)
        totm=tot(m-lower+1);
        SUM=SUM+G(totn,n,totm,m);
    end
end

SUM


function output=G(a,n,b,m)
[GCD,u,v]=gcd(n,m);
L=double(a-b)/double(GCD);
if mod(L,1)
    x=0;
else
x=mod(a-n*u*L,n*m/GCD);
end
% 
% g = [a,b];
% b = [n/GCD,m/GCD]; % the bases should be relativly prime
% 
% [bx by] = meshgrid(b, b);
% bb = gcd(bx,by)-diag(b);
% pp = ~sum(sum(bb>1)); 
% 
% if (pp)
%     xo = by-diag(b-1);
%     Mk = prod(xo);
%     [Gk, nk, Nk] = gcd ( b, Mk ) ;
%     Sum_g_Nk_Mk = sum ( (g .* Nk) .* Mk ) ;
%     x = mod(Sum_g_Nk_Mk,prod(b));
%     
%     display(['The Number [lowest unique value] is: x=''' num2str(x) '''' ])
% else
%     display('The Bases are NOT Relprime.')
% end
output=x;
end