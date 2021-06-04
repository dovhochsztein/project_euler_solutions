d=12000;
count=0;
for i=1:d
    facs=unique(factor(i));
    for j=ceil((i+.00001)/3):floor((i-.00001)/2)
        breaker=false;
        for k=1:length(facs)
            if ~mod(j,facs(k))
                breaker=true;
                break
            end
            
        end
        if breaker
            continue
        end
        count=count+1;
    end
end
count


% d=100;
% list=[];
% count=0;
% for i=1:d
%     for j=1:i-1
%         if gcd(i,j)==1
%             %list=[list;[j,i]];
%             count=count+1;
%         end
%     end
% end