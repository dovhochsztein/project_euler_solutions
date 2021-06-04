SUM=0;
for i=1:999;
    I=3*i;
    if fibonacci(I)<4000000
        if ~mod(fibonacci(I),2)
            SUM=SUM+fibonacci(I);
        end
    else
        break
    end
end