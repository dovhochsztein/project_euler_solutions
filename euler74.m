

nums=[];
factorials=factorial([0:9]);
for A=1:1000000
    chain=A;
    for i=2:70
        new=sum(factorials((dec2base(chain(i-1),10) - '0')+1));
        if any(chain==new)
            break
        end
        chain=[chain,new];
    end
    if length(chain)==60;
        nums=[nums,A];
    end
end

length(nums)