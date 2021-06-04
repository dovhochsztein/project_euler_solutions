% Euler problem 51
N=5;
range=1:2^N-1;
MIN=10^(N-1);
MAX=10^(N)-1;
forms=zeros(length(range),N);
for i=range
    binary=de2bi(i);
    forms(i,1:length(binary))=binary;
end
breaker=false;
thresh=7;
property=[];
family={};


for i=range
    
end

















for num=MIN:MAX
    if breaker
        break
    end
    if ~isprime(num) | any(property==num)
        continue
    end
    
    numstr=num2str(num);
    for i=range
        if breaker
            break
        end
        replace=find(forms(i,:));
        new_nums=cell(1,10);
        for j=0:9
            new_nums{j+1}=numstr;
            for k=1:length(replace)
                new_nums{j+1}(k)=num2str(j);
            end
            new_nums{j+1}=str2num(new_nums{j+1});
        end
        new_nums=cell2mat(new_nums);
        primes=isprime(new_nums);
        if sum(primes)>=thresh
            family=[family,new_nums(find(primes))];
            property=[property,new_nums(find(primes))];
            breaker=true;
            break
        end
    end
end