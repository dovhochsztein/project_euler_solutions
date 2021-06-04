N=3;
P=primes(10^N);
rel=cell(1,N);
partial_rel=rel;
rel{1}=primes(10);


SUM=sum(rel{1});
for i=2:N
    temp=[];
    for j=1:length(rel{i-1})
        for k=1:9
            new=rel{i-1}(j)+k*10^(i-1);
            if isprime(new)
                temp=[temp,new];
            end
        end
    end
    for j=1:length(partial_rel{i-1})
        for k=1:9
            new=partial_rel{i-1}(j,1)+k*10^(i-1);
            if isprime(new)
                temp=[temp,new];
            end
        end
    end
    rel{i}=[rel{i},unique(temp)];
    temp=unique(temp);
    for ITER=1:2
    for j=1:length(temp)
        d=temp(j);
        digs=i;
        A=zeros(1,digs);
        for k=1:digs
            A(digs+1-k)=floor(mod(d,10^(k))/10^(k-1));
        end
        for k=1:length(A)
            for l=1:9
                B=A;
                B(k)=l;
                new=10.^(i-1:-1:0)*B';
                if isprime(new)
                    if l<A(k)
                        partial_rel{i}=[partial_rel{i};[new,d]];
                    elseif l>A(k)
                    temp=[temp,new];
                    end
                end
            end
        end
    end
%     partial_rel{i}=setdiff(unique(partial_rel{i}),rel{i});
    rel{i}=[rel{i},unique(temp)];
    end
    rel{i}=unique(rel{i});
    SUM=SUM+sum(rel{i});
    
end
sum(P)-SUM

C=horzcat(rel{:});





% 
% N=3;
% P=primes(10^N);
% rel=cell(1,N);
% partial_rel=rel;
% rel{1}=primes(10);
% 
% 
% SUM=sum(rel{1});
% for i=2:N
%     temp=[];
%     for j=1:length(rel{i-1})
% %         k=0;
% %         new=10*rel{i-1}(j)+k;
% %         if isprime(new)
% %             temp=[temp,new];
% %         end
%         for k=1:9
% %             new=10*rel{i-1}(j)+k;
% %             if isprime(new)
% %                 temp=[temp,new];
% %             end
%             new=rel{i-1}(j)+k*10^(i-1);
%             if isprime(new)
%                 temp=[temp,new];
%             end
%         end
%     end
%     for j=1:length(partial_rel{i-1})
%         for k=1:9
%             new=partial_rel{i-1}(j)+k*10^(i-1);
%             if isprime(new)
%                 temp=[temp,new];
%             end
%         end
%     end
%     rel{i}=unique(temp);
%     temp=unique(temp);
%     for j=1:length(temp)
%         d=temp(j);
%         digs=i;
%         A=zeros(1,digs);
%         for k=1:digs
%             A(digs+1-k)=floor(mod(d,10^(k))/10^(k-1));
%         end
%         for k=1:length(A)
%             for l=(A(k)+1):9
%                 B=A;
%                 B(k)=l;
%                 new=10.^(i-1:-1:0)*B';
%                 if isprime(new)
%                     temp=[temp,new];
%                 end
%             end
%         end
%     end
%     rel{i}=unique(temp);
%     SUM=SUM+sum(rel{i});
% end
% sum(P)-SUM
% 
% C=horzcat(rel{:});