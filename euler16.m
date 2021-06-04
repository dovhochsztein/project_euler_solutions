num=zeros(1,305);
num(1)=1;
for i=1:1000
    num=num*2;
    for j=1:length(num)
        if num(j)>=10
            num(j)=num(j)-10;
            num(j+1)=num(j+1)+1;
        end
    end
end
sum(num)