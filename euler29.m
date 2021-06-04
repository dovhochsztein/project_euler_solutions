% 
digits=202;
N=100;
num=zeros((N-1)^2,digits);

for i=2:N
    num(2+(i-2)*(N-1),2)=i^2;
    for j=2:digits
            if num(2+(i-2)*(N-1),j)>=10
                num(2+(i-2)*(N-1),j+1)=num(2+(i-2)*(N-1),j+1)+floor(num(2+(i-2)*(N-1),j)/10);
                num(2+(i-2)*(N-1),j)=num(2+(i-2)*(N-1),j)-floor(num(2+(i-2)*(N-1),j)/10)*10;
            end
        end
    for power=3:N
        num(power+(i-2)*(N-1),:)=num(power+(i-2)*(N-1)-1,:)*i;
        for j=2:digits
            if num(power+(i-2)*(N-1),j)>=10
                num(power+(i-2)*(N-1),j+1)=num(power+(i-2)*(N-1),j+1)+floor(num(power+(i-2)*(N-1),j)/10);
                num(power+(i-2)*(N-1),j)=num(power+(i-2)*(N-1),j)-floor(num(power+(i-2)*(N-1),j)/10)*10;
            end
        end
    end
end

num=num(2:end,2:end);


% X=randi(2,[200000,200]);
Y=unique(num,'rows');
size(Y,1)