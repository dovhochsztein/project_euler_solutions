n=10000000;
nums=[1:n];
P=nums.*(3*nums-1)/2;
A=P;
D=P';

S=70;
ispent= @(n) ~mod((1+sqrt(1+24.*n))/6,1);

diffs=[];
list=[];
for i=1:floor(sqrt(n)/3)
    d=D(i);
    for j=1:ceil((d-1)/3)+1
        a=A(j);
        b=d+a;
        if ispent(b)
            list=[list;[d,a,b]];
            S=a+b;
            if ispent(S)
                diffs=[diffs,d];
                error('break');
            end
        end
    end
end

% for i=1:n
%     for j=1:n
%         B=A(i)+D(j);
%         S=A(i)+B;
%         if any(B==P) && any(S==P)
%             diffs=[diffs,D(j)];
%         end
%     end
% end