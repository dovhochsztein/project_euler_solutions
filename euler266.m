P=primes(190);
A=log(P);
target=sum(A)/2;
range=1:length(P);



pol=polyfit(range,P,5);
P_fit=polyval(pol,range);
figure;
plot(range,P_fit);

for i=1:2^42
    1;
end