n=1:100000;
TRI=n.*(n+1)/2;
PENT=n.*(3*n-1)/2;
HEX=n.*(2*n-1);
A=intersect(TRI,PENT);
C=intersect(HEX,A)
C(end)