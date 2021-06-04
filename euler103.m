N=6;
sets=cell(1,N);
sets{1}={[1]};
% sets{2}={[1,2]};

for i=2:N
    sets{i}=cell(1);
    first=true;
    for j=1:length(sets{i-1})
%         for k=1:length(sets{i-1}{j})            
%             new=[0,sets{i-1}{j}]+sets{i-1}{j}(k);
        for k=1:sets{i-1}{j}(end)+1
            new=[0,sets{i-1}{j}]+k;
            if check(new)
                if ~first
                    sets{i}=[sets{i},cell(1)];
                else
                    first=false;
                end
                sets{i}{end}=[sets{i}{end},new];
            end
        end
    end
end


SUMS=zeros(1,length(sets{end}));
for i=1:length(sets{end})
    SUMS(i)=sum(sets{end}{i});
end
    


check([2,3,4,5,6])
check([6,9,11,12,13])



function output=check(A)
N=length(A);
B=cell(1,N);
output=true;
for i=1:N
    B{i}=[0,1,2];
end
C=combvec(B{:});

for i=1:size(C,2)
    vec=C(:,i);
    if (~any(vec==1)) || (~any(vec==2)) || find(vec==1,1)<find(vec==2,1)
        continue
    end
    set1=A(find(vec==1));
    set2=A(find(vec==2));
    if length(set1)>length(set2)
        if sum(set2)>=sum(set1)
            output=false;
            break
        end
    elseif length(set2)>length(set1)
        if sum(set1)>=sum(set2)
            output=false;
            break
        end
    else
        if sum(set1)==sum(set2)
            output=false;
            break
        end
    end
end
end
        