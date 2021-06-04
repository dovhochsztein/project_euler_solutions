circs=[];
for i=primes(10^6);
    digits=dec2base(i,10)- '0';
    fail=false;
    for j=1:length(digits)-1
        digits=[digits(end),digits(1:end-1)];
        if ~isprime(polyval(digits,10))
            fail=true;
            break
        end
    end
    if ~fail
        circs=[circs,i];
    end
        
end




%         for j=2:digits
%             if num(power+(i-2)*(N-1),j)>=10
%                 num(power+(i-2)*(N-1),j+1)=num(power+(i-2)*(N-1),j+1)+floor(num(power+(i-2)*(N-1),j)/10);
%                 num(power+(i-2)*(N-1),j)=num(power+(i-2)*(N-1),j)-floor(num(power+(i-2)*(N-1),j)/10)*10;
%             end
%         end
