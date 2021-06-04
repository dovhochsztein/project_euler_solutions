nums=[];
power=4;
for i=2:power*9^power
    digits=dec2base(i,10)- '0';
    if sum(digits.^power)==i
        nums=[nums,i];
    end
end
sum(nums)



%         for j=2:digits
%             if num(power+(i-2)*(N-1),j)>=10
%                 num(power+(i-2)*(N-1),j+1)=num(power+(i-2)*(N-1),j+1)+floor(num(power+(i-2)*(N-1),j)/10);
%                 num(power+(i-2)*(N-1),j)=num(power+(i-2)*(N-1),j)-floor(num(power+(i-2)*(N-1),j)/10)*10;
%             end
%         end
