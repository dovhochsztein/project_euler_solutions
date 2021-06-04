% phi=( 1 + sqrt(5) ) / 2;
% digits=20500;
% N=floor(digits/log10(phi))-100;
% fibs=zeros(N,digits); %% need to solve space issue
% fibs(1,1)=1;
% fibs(2,1)=1;
% pandig=[];
% for i=3:N
%     fibs(i,:)=fibs(i-2,:)+fibs(i-1,:);
%     for j=1:digits
%         if fibs(i,j)>=10
%             fibs(i,j+1)=fibs(i,j+1)+floor(fibs(i,j)/10);
%             fibs(i,j)=fibs(i,j)-floor(fibs(i,j)/10)*10;
%         end
%     end
%     num_digits=digits - find(fliplr(fibs(i,:))~=0,1)+1;
%     if num_digits>9
%         last9=fibs(i,1:9);
%         first9=fibs(i,(num_digits-8):num_digits);
%         unlast=unique(last9);
%         unfirst=unique(first9);
%         if length(unlast)==9 && all(unlast ==[1:9]) %&& length(unfirst)==9 && all(unfirst==[1:9])
%             pandig=[pandig,i]
%         end
%     end
% end



phi=( 1 + sqrt(5) ) / 2;
digits=1000000;
digits_start=10;
N=floor(digits/log10(phi))-100;
fibs=zeros(1,digits_start);
fibsold1=zeros(1,digits_start); %% need to solve space issue
fibsold1(1)=1;
fibsold2=zeros(1,digits_start);
fibsold2(1)=1;
pandig=[];
L=length(fibs);
for i=3:N
    num_digits=L - find(fliplr(fibs)~=0,1)+1;
    if num_digits==L
        fibs=[fibs,zeros(1,L*9)];
        fibsold1=[fibsold1,zeros(1,L*9)];
        fibsold2=[fibsold2,zeros(1,L*9)];
        L=L*10;    
    end
    fibs=fibsold1+fibsold2;
    for j=1:num_digits
        if fibs(j)>=10
            fibs(j+1)=fibs(j+1)+floor(fibs(j)/10);
            fibs(j)=fibs(j)-floor(fibs(j)/10)*10;
        end
    end
    
    if num_digits>9
        last9=fibs(1:9);
        unlast=unique(last9);
        if length(unlast)==9 && all(unlast ==[1:9])
            num_digits=L - find(fliplr(fibs)~=0,1)+1;
            first9=fibs((num_digits-8):num_digits);
            unfirst=unique(first9);
            if length(unfirst)==9 && all(unfirst==[1:9])
                pandig=[pandig,i]
                break
            end
        end
    end
    fibsold2=fibsold1;
    fibsold1=fibs;
end
