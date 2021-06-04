N=30;

% NCHOOSEK=zeros(101);
% for i=0:100
%     for j=0:i
%         NCHOOSEK(i+1,j+1)=nchoosek(i,j);
%     end
% end

bincomb=@(A,B) fliplr(sum(spdiags(A'*B,[1-length(A):length(B)-1])));
bincomb=@(A,B) sum(spdiags(fliplr(A)'*B,[1-length(A):length(B)-1]));
% bincomb=@(A,B) faster_diag(A'*B);
fix0 = @(A) [1-sum(A(2:end)),A(2:end)];
% fix1=1;

tol=10^-35;

E=ones(N);
P=cell(N);
for i=1:N^2
    P{i}=[0,1];
end
U=zeros(N);


for r=1:50
    Enew=zeros(N);
    Unew=ones(N);
    Pnew=cell(N);
    for i=1:N^2
        Pnew{i}=[1,0];
    end
    for i=1:N
        for j=1:N
            adj={};
            if i~=1
                adj=[adj;{i-1,j}];
            end
            if i~=N
                adj=[adj;{i+1,j}];
            end
            if j~=1
                adj=[adj;{i,j-1}];
            end
            if j~=N
                adj=[adj;{i,j+1}];
            end
            num_adj=size(adj,1);
            for k=1:num_adj
                ind=adj(k,:);
                matind=cell2mat(ind);
                num_adj2=4-sum(sum((matind==N)+(matind==1)));
                Enew(i,j)=Enew(i,j) + E(ind{:})/num_adj2;
                
                A=P{ind{:}};
                p=1/num_adj2;
                output=zeros(1,length(A));
                for I=1:length(A)
                    for J=1:I
                        output(J)=output(J)+A(I)*NCHOOSEK(I-1+1,J-1+1)*p^(J-1)*(1-p)^(I-J);
                    end
                end
                if abs(1-(sum(output)))>10^-6
                    error('3')
                end
                output=[output(1:end-1),1-sum(output(1:end-1))];
                if k==1
                    Pnew{i,j}=output;
                else
%                 Pnew{i,j}= faster_diag(Pnew{i,j},fix0(P{ind{:}}/num_adj2));
%                     F=fix1(P{ind{:}},1/num_adj2);
%                     F=output;
                    Pnew{i,j}= faster_diag(Pnew{i,j},output);
                    Pnew{i,j}=[Pnew{i,j}(1:end-1),1-sum(Pnew{i,j}(1:end-1))];
                end
                b=find(Pnew{i,j}<tol,1);
                if ~isempty(b)
                    if b==1
                        error('1')
                    end
                    Pnew{i,j}=Pnew{i,j}(1:b);
                    Pnew{i,j}=[Pnew{i,j}(1:end-1),1-sum(Pnew{i,j}(1:end-1))];
                end
            end
                
        end
    end
    E=Enew;
    P=Pnew;
    EX=0;
for i=1:N^2
    EX=EX+P{i}(1);
    if abs(sum(P{i})-1)>10^-6
        error('2')
    end
end
EX
end

EX=0;
for i=1:N^2
    EX=EX+P{i}(1);
%     sum(P{i})
end
% EX

for i=1:N
    for j=1:N
        test(i,j)=Pnew{i,j}*(0:length(Pnew{i,j})-1)';
    end
end



A=[.1,.2,.3,.4];
B=[.3,.4,.3];
d=[1-length(A):length(B)-1];
C=fliplr(sum(spdiags(A'*B,d)));




% for r=1:1
%     Enew=zeros(N);
%     Unew=ones(N);
%     for i=1:N
%         for j=1:N
%             adj={};
%             if i~=1
%                 adj=[adj;{i-1,j}];
%             end
%             if i~=N
%                 adj=[adj;{i+1,j}];
%             end
%             if j~=1
%                 adj=[adj;{i,j-1}];
%             end
%             if j~=N
%                 adj=[adj;{i,j+1}];
%             end
%             num_adj=size(adj,1);
%             for k=1:num_adj
%                 ind=adj(k,:);
%                 matind=cell2mat(ind);
%                 num_adj2=4-sum(sum((matind==N)+(matind==1)));
%                 Enew(i,j)=Enew(i,j) + E(ind{:})/num_adj2;
% %                 Unew(i,j)=Unew(i,j) * E;
%             end
%                 
%         end
%     end
%     E=Enew;
% end
% faster_diag(A'*B)

A=[1,0];
B=[0,1];


% R=rand(1,150);
% R=R/sum(R)
% S=fix1(R,.5)
% sum(S)


function output=fix1(A,p)
output=zeros(1,length(A));
for i=1:length(A)
    for j=1:i
        output(j)=output(j)+A(i)*nchoosek(i-1,j-1)*p^(j-1)*(1-p)^(i-j);
    end
end
end


function output=faster_diag(A,B)
    A=A'*B;
    [I,J]=size(A);
    output=zeros(1,I+J-1);
    for K=1:I+J-1
        for L=1:min(K,min(J,min(I,I+J-K)))
        output(K)=output(K)+A(min(K,I)-L+1,max(0,K-I)+L);
        end
    end
end