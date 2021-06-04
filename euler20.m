% n=100;
% factors=[];
% for i=1:n
%     factors=[factors,factor(i)];
% end
% sum(factors==2)
% sum(factors==5)



num=zeros(1,160);
num(1)=1;
for i=1:100
    num=num*i;
    for j=1:length(num)
        if num(j)>=10
            num(j+1)=num(j+1)+floor(num(j)/10);
            num(j)=num(j)-floor(num(j)/10)*10;
        end
    end
end
sum(num)