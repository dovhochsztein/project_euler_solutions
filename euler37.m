truncable=[];
for i=primes(10^6);
    if i<10
        continue
    end
    digs=dec2base(i,10)- '0';
    fail=false;
    for j=1:length(digs)-1
         if ~isprime(polyval(digs(1:end-j),10))
             fail=true;
             break
         end
         if ~isprime(polyval(digs(1+j:end),10))
             fail=true;
             break
         end
    end
    if ~fail
        truncable=[truncable,i];
    end
end
sum(truncable)

