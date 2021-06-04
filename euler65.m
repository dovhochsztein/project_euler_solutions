
NUM=vpi(3);
DEN=vpi(2);
count=0;
x=1.5;
for i=1:1000
    
    num=2*DEN+NUM;
    DEN=DEN+NUM;
    NUM=num;
    if length(digits(NUM))>length(digits(DEN))
        count=count+1;
    end
%     x=1+1/(1+x);
end

N=100;
series=zeros(1,N);
series(1)=2;
for i=2:N
    if ~mod(i,3)
        series(i)=i/3*2;
    else
        series(i)=1;
    end
end
        

series=fliplr(series);
NUM=vpi(series(1)*series(2)+1);
DEN=vpi(series(1));
for i=3:length(series)
    num=series(i)*NUM+DEN;
    DEN=NUM;
    NUM=num;
end
sum(digits(NUM))