% for i=1:1000
last=[];
for a=[true,false]
    for b=[true,false]
        for c=[true,false]
            last=[last;[a,b,c,xor(a,(b&&c))]];
        end
    end
end
% end

R=cell(64,2);
Q=zeros(64,2);
for i=0:63
digs=6;
    A=zeros(1,digs);
    for j=1:digs
        A(digs+1-j)=floor(mod(i,2^(j))/2^(j-1));
    end
    B=[A(2),A(3),A(4),A(5),A(6),xor(A(1),(A(2)&&A(3)))];
    R{i+1,1}=A;
    R{i+1,2}=B;
    Q(i+1,1)=sum(2.^[5:-1:0].*A);
    Q(i+1,2)=sum(2.^[5:-1:0].*B);
    
    
end


runs=cell(1,64);
for i=1:64
    runs{i}=Q(i,1);
    while 1
        new=Q(runs{i}(end)+1,2);
        if any(runs{i}==new)
            break
        else
            runs{i}=[runs{i},new];
        end
    end
    runs{i}=sort(runs{i});
end
un_runs={};
for i=1:64
    add=true;
    for j=1:length(un_runs)
        if length(runs{i})==length(un_runs{j}) && all(runs{i}==un_runs{j})
            add=false;
            break
        end
    end
    if add
        un_runs=[un_runs,runs{i}];
    end
end

row=zeros(1,46);
circle=zeros(1,46);
row(1)=1;
row(2)=3;
row(3)=5;
circle(1)=1;
circle(2)=3;
circle(3)=4;
for i=4:46
    row(i)=row(i-1)+row(i-2);
    circle(i)=row(i-3)+row(i-1); %lucas numbers
end

choices=zeros(1,length(un_runs));
for i=1:length(un_runs)
    L=length(un_runs{i});
%     if ~mod(L,2)
%         
%     else
        choices(i)=circle(L);
%     end
end
uint64(prod(choices))