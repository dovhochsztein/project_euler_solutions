N=3e10;

bspec0=2^2;
amax=floor((N/bspec0^3)^(1/2));
facs=cell(1,amax);
for a=2:amax
    facs{a}=factor(a);
end
M=[];
count=0;
list=[];
list_s=[];
for b=2:floor(N^(1/3))
    B=facs{b};
    i=1;
    special=false;
    multiplicities=[];
    while i<=length(B)
        num=sum(B==B(i));
        multiplicities=[multiplicities,num];
        i=i+num;
    end
    if max(multiplicities)>=2 && sum(multiplicities)>=3
        continue
    end
    if all(multiplicities>=2)
        special=true;
    end
    if special
    for a=2:floor((N/b^3)^(1/2))
%         A=factor(a);
        A=facs{a};
        i=1;
        multiplicities=[];
        while i<=length(A)
            if all(A(i)~=B)
                num=sum(A==A(i));
                multiplicities=[multiplicities,num];
            end
            i=i+num;
        end
        if any(multiplicities>2)
            [a,b,multiplicities]
        end
        count=count+1/(1+any(multiplicities>2));
        M=[M;[a,b,(1+sum(multiplicities>2))]];
%         list_s=[list_s,a^2*b^3];
    end
    else
        for a=2:floor((N/b^3)^(1/2))
%         A=factor(a);
%         list=[list,a^2*b^3];
        count=count+1;
    end
    end
    
end

count

% count=count+length(unique(list_s));
% list=[list,list_s];

% list2=unique(list);
% duplicates=[];
% for i=1:length(list)
%     if sum(list(i)==list)>1&~any(duplicates==list(i))
%         duplicates=[duplicates,list(i)];
%     end
%     if sum(list(i)==list)>2
%         sum(list(i)==list)
%         list(i)
%     end
% end