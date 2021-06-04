
NUM=vpi(3);
DEN=vpi(2);
count=0;
x=1.5;
for i=1:1000
    
    num=2*DEN+NUM;
    DEN=DEN+NUM;
    NUM=num;
%     if gcd(NUM,DEN)~=1
%         1
%         break
%     end
%     if ceil(log10(double(NUM)+1))>ceil(log10(double(DEN)+1))
    if length(digits(NUM))>length(digits(DEN))
        count=count+1;
    end
%     x=1+1/(1+x);
end