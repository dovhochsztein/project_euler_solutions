% for i=1:50
%     ODD=2*i-1;
%     A=

M=100;
list0=[];
for a=1:M
    for b=a:M
        for c=b:M
            A=a+b;
            C=sqrt((A^2+c^2));
            if floor(C)==C
                list0=[list0;[a,b,c]];
            end
        end
    end
end

U=[1,2,2;-2,-1,-2;2,2,3];
A=[1,2,2,;2,1,2;2,2,3];
D=[-1,-2,-2;2,1,2;2,2,3];
mats={U,A,D};

L=10;
trips=cell(1,L);
trips{1}=[3,4,5];
trip_mat=[];
for i=2:L
    for j=1:size(trips{i-1},1)
        for k=1:3
            new=trips{i-1}(j,:)*mats{k};
            if (new(1)<=M | new(2)<=M) && new(1)<=2*M && new(2)<=2*M
            trips{i}=[trips{i};new];
            trip_mat=[trip_mat;new];
            end
        end
    end
end
