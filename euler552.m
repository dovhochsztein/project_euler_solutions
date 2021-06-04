N=50;
P=vpi(primes(N));
n=length(P);
A=vpi(zeros(1,length(P)));
A(1)=vpi(1);
A(2)=vpi(5);

for i=3:length(P)
    A(i)=G(i,P(i),A(i-1),vpi(prod(P(1:i-1))));
%     A(i)=mod(A(i),P(i));
    
    
end

for i=1:length(P)
B{i}=int64(double(factor(A(i))));
end



function output=G(a,n,b,m)
[GCD,u,v]=gcd(int64(double(n)),int64(double(m)));
L=double(a-b)/double(GCD);
if mod(L,1)
    x=0;
else
x=mod(a-n*vpi(u)*L,n*m/GCD);
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