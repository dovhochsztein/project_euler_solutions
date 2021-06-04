pdice=[1:4];
pn=9;


for i=pdice(1)*pn:pdice(end)*pn
end
syms x
syms P
syms C

P=x+x^2+x^3+x^4;
p=double(coeffs(expand(P^9)))/4^9;
pnums=9:36;
C=x+x^2+x^3+x^4+x^5+x^6;
c=double(coeffs(expand(C^6)))/6^6;
cnums=6:36;

prob=0;
for i=1:length(p)
    for j=1:length(c)
        if pnums(i)>cnums(j)
            prob=prob+p(i)*c(j);
        end
    end
end
round(prob,7)