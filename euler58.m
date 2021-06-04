count=0;
tot=1;
num=1;
for i=2:1000000
    for j=1:4
        num=num+2*(i-1);
        if isprime(num)
            count=count+1;
        end
    end
    tot=tot+4;
    if count/tot<.1
        break
    end
end
side=2*i-1