a=[1,-90,2,0,-90];
b=[90,0,1,90,2];
L=[0 -1;1 0];
R=[0 1;-1 0];
N=10;
D0=[0,1];
D=cell(1,N);
D{1}=[];
for i=1:length(D0)
    if D0(i)==1
        D{1}=[D{1},a];
    elseif D0(i)==2
        D{1}=[D{1},b];
    else
        D{1}=[D{1},D0(i)];
    end
end

for n=2:N
   D{n}=[];
for i=1:length(D{n-1})
    if D{n-1}(i)==1
        D{n}=[D{n},a];
    elseif D{n-1}(i)==2
        D{n}=[D{n},b];
    else
        D{n}=[D{n},D{n-1}(i)];
    end
end 
end
cmnds=D{end}(find(D{end}~=1 & D{end}~=2));
position=[0,0]';
direction=[0,1]';

count=0;
for i=1:length(cmnds)
    if count==500
        break
    end
    if cmnds(i)==0
        position=position+direction;
        count=count+1;
    elseif cmnds(i)==90
        direction=L*direction;
    elseif cmnds(i)==-90
        direction=R*direction;
    end
    
end
