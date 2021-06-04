n=7;
P=perms([1:n]);
pandig=[];
for i=1:size(P,1)
    p=polyval(P(i,:),10);
    if isprime(p)
        pandig=[pandig,p];
    end
end
max(pandig)