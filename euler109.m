A=[1:20,25];
B=[1:20];
C=25;
possible=sort([A,A*2,B*3]);
pairs=possible'+possible;
pairs=triu(pairs);
pairs=pairs(:);
pairs=sort(pairs(pairs>0));
list={};

count=0;
for n=1:99
    for i=1:21
        finish=2*A(i);
        if finish>n
            continue
        elseif finish==n
%             list=[list,{[finish]}];
            count=count+1;
        else
            count=count+sum(possible==(n-finish))+sum(pairs==(n-finish));
        end
    end
end
count