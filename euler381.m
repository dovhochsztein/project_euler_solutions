P=primes(10^8);
% P=[3,5,7];

tot=0;
for p=P(3:end)
%     p=uint32(p);
    SUM=0;
    prev=1;
%     A=1;
    for i=2:4
%         A=A*(p-i);
%         a=A;
        a=p-i;
        b=p;
        
        x0=0; x1=1; y0=1;y1=0;
        while a ~= 0
            q=floor(b/a);temp=b;b=a;a=mod(temp,a);
            y1=y0 - q * y1;y0=y1;
            temp=x0;x0=x1;x1=temp - q * x1;
        end
        SUM=SUM+prev*x0;
        prev=mod(prev*x0,p);
    end
    tot=tot+mod(SUM,p);
end
tot