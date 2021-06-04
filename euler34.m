nums=[];
for A=3:100000
    
    dec=dec2base(A,10) - '0';
    if A==sum(factorial(dec))
        nums=[nums,A];
    end
end
sum(nums)