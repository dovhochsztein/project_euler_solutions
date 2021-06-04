for i=3:2:10001
    if isprime(i)
        continue
    end
    P=primes(i);
    sqs=2*[1:floor(sqrt(i))].^2;
    SUMS=P+sqs';
    if any(SUMS(:)==i)
        continue
    else
        i
        break
    end
end
        