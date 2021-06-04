% n=100;
% factors=[];
% for i=1:n
%     factors=[factors,factor(i)];
% end
% sum(factors==2)
% sum(factors==5)



num=zeros(1,1001);
num_previous1=num;
num_previous2=num;
num_previous1(1)=1;
num_previous2(1)=1;
for i=3:10000
    num=num_previous1+num_previous2;
    for j=1:length(num)
        if num(j)>=10
            num(j+1)=num(j+1)+floor(num(j)/10);
            num(j)=num(j)-floor(num(j)/10)*10;
        end
    end
    num_previous2=num_previous1;
    num_previous1=num;
%     num(1:10)
    if num(1000)
        break
    end
end
