SUM=0;
M=100000;
factor_list=cell(1,M);
factor_list{2}=2;
% for m=2:M
%     factor_list{m}=[];
%     for i=2:m
%         factor_list{m}=[factor_list{m},factor(i)];
%     end
% end

for m=3:M
    factor_list{m}=[factor_list{m-1},factor(m)];
end


for n=2:100000
    nprime=factor(n);
    for m=max(nprime):M
        
%         mprime=[];
%         for i=2:m
%             mprime=[mprime,factor(i)];
%         end
        mprime=factor_list{m};
        failed=false;
        for i=1:length(nprime)
            matches=mprime==nprime(i);
            if any(matches)
                locs=find(matches);
                mprime=[mprime(1:locs(1)-1),mprime(locs(1)+1:end)];
            else
                failed=true;
                break
            end
        end
        if ~failed
            break
        end
    end
    if ~failed
        SUM=SUM+m;
    else
        n
    end
end