N=10;

P=primes(10^N);
p=find(P>10^(N-1),1);
P=P(p:end);
L=length(P);

M=zeros(1,10);
S=zeros(1,10);
A=zeros(1,N);
% nums=zeros(10,L);
for i=1:L
%     A=zeros(1,N);
    for j=1:N
        A(N+1-j)=floor(mod(P(i),10^(j))/10^(j-1));
    end
    for d=0:9
%         s=sum(A==d);
        %         nums(d+1,i)=sum(A==d);
        if sum(A==d)>=M(d+1)
            s=sum(A==d);
            if s==M(d+1)
                S(d+1)=S(d+1)+P(i);
            else
                M(d+1)=s;
                S(d+1)=P(i);
            end
        end
    end
end

% SUM=0;
% for i=1:10
%     MAX=max(nums(i,:));
%     SUM=SUM+sum(P(find(nums(i,:)==MAX)));
% end
int64(sum(S))
% SUM