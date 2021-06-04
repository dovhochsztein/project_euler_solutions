count=0;
N=50;

for x=1:N
    for y=1:N
        count=count+3;
    end
end
% for x=1:N
%     if ~mod(x,2)
%         count=count+2;
%     end
% end
for x=1:N
    for y=1:N
        g=gcd(x,y);
        for n=1:N*g*4
            if x>=n*y/g && y+n*x/g<=N
                count=count+2;
            end
        end
    end
end
count