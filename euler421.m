m=10^8;
P=primes(m);


C=mod(P-2,30)+1;
D=unique(C(11:end));
E=mod(C'.^D,30); %% overflow?



i=12;
p=37; %p=P(i);
A=P(1:i-1);
power=C(i);
B=A;
for j=2:power
    B=mod(B.*A,p);
end
ind=find(B==0);


n=[2,10];
A=mod(n',P);

B=A;
for i=2:15
    B=mod(B.*A,P);
end
B=mod(B+1,P);
sum(P(mod(find(B'==0),length(P))));