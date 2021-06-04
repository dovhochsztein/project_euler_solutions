amicable=[];
for i=1:10000
    pair=sum(divisor(i))-i;
    if pair~=i && sum(divisor(pair))-pair==i
        amicable=[amicable,i,pair];
    end
end
sum(unique(amicable))