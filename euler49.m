for i=1000:9999
    if isprime(i)
        for j=1:floor((10000-i)/2-.001)
            if isprime(i+j) && isprime(i+2*j)
                digit1=dec2base(i,10) -'0';
                digit2=dec2base(i+j,10) -'0';
                digit3=dec2base(i+2*j,10) -'0';
                if all(sort(digit1)==sort(digit2)) && all(sort(digit1)==sort(digit3))
                    i,i+j,i+2*j
                end
            end
        end
    end
end