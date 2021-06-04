N=5;
nums=1:2*N;
highest_sum=(sum(nums(1:N))+sum(nums(N+1:end))*2)/N;
lowest_sum=(sum(nums(1:N)*2)+sum(nums(N+1:end)))/N;
%must be 14 because the 10 would be outside (16 digits)

S=14;
outside=[6,7,8,9,10];

list=[];
digs=[];
inner=perms([1,2,3,4,5]);
for i=1:size(inner,1)
    outer=zeros(1,5);
    for j=1:5
        outer(j)=S-inner(i,j)-inner(i,mod(j,5)+1);
    end
    un=unique(outer);
    if length(un)==5 && all(un==outside)
        list=[list;[inner(i,:),outer]];
        dig=[];
        for j=1:5
            dig=[dig,outer(j),inner(i,j),inner(i,mod(j,5)+1)];
        end
        digs=[digs;[dig]];
    end
end

%find one that starts with 6 and is max after that!
sol=num2str(digs(1,:));
sol=sol(sol~=' ')