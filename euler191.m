N=30;

absent=cell(1,N);
absent2=cell(1,N); %with an absent before them
for i=1:2
    absent{i}=zeros(1,N+1);
    absent2{i}=zeros(1,N+1);
    for j=1:i+1
        absent{i}(j)=nchoosek(i,j-1);
        absent2{i}(j)=nchoosek(i,j-1);
    end
end
absent2{2}(3)=0;


for i=3:N
    absent{i}=zeros(1,N+1);
    absent2{i}=zeros(1,N+1);
    absent{i}(1)=1;
    absent2{i}(1)=1;
    for j=2:i+1
        absent{i}(j)=absent{i-1}(j)+absent2{i-1}(j-1);
        absent2{i}(j)=absent{i-2}(j)+absent{i-2}(j-1)+absent2{i-2}(j-1);
    end
end

tot=0;
for j=1:i+1
    tot=tot+(N-(j-1)+1)*absent{N}(j);
end
int64(tot)
