nums=[];
s=60;
for n=2:2:100000000
%     a=1:n;
    a=2;
    for j=1:s+1
        a=2*a-1-floor((a-1)/(n/2))*(n-1);
%         if all(a==1:n)
%             break
%         end
        if a==2
            break
        end
    end
    if j==s
        nums=[nums,n];
    end
end

