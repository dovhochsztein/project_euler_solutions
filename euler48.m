% 
digits=3001;
N=1000;
num=zeros(1,digits);
for i=1:N
    new_num=zeros(1,digits);
    new_num(1)=1;
    for j=1:i
        new_num=new_num*i;
        for k=1:digits
            if new_num(k)>=10
                new_num(k+1)=new_num(k+1)+floor(new_num(k)/10);
                new_num(k)=new_num(k)-floor(new_num(k)/10)*10;
            end
        end
    end
    num=num+new_num;
    for k=1:digits
        if num(k)>=10
            num(k+1)=num(k+1)+floor(num(k)/10);
            num(k)=num(k)-floor(num(k)/10)*10;
        end
    end
end
fliplr(num(1:10))