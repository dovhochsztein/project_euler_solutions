A=zeros(1,11);
A(11)=1;

for i=1:7830457
    A=A*2;
    if ~mod(i,48)
        for j=1:length(A)-1
            if A(end+1-j)>=10
                A(end-j)=A(end-j)+floor(A(end+1-j)/10);
                A(end+1-j)=A(end+1-j)-10*floor(A(end+1-j)/10);
            end
        end
        A(1)=0;
    end
end

A=A*28433;
A(end)=A(end)+1;
for j=1:length(A)-1
    if A(end+1-j)>=10
        A(end-j)=A(end-j)+floor(A(end+1-j)/10);
        A(end+1-j)=A(end+1-j)-10*floor(A(end+1-j)/10);
    end
end
A(1)=0;
uint64(sum(10.^[10:-1:0].*A))