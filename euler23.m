N=28123;
abundant=[];
for i=1:N
    pair=sum(divisor(i))-i;
    if pair>i
        abundant=[abundant,i];
    end
end
A=abundant+abundant';
% L=length(A);
% un=zeros(1,L*(L+1)/2);
% ind=1;
% for i=1:length(A)
%     for j=1:length(A)
%         if i>=j
%             un(ind)=A(i,j);
%             ind=ind+1;
%         end
%     end
% end
% B=triu(A);
% sums=A(:);
sums=unique(A(:));
% cannot=[];
% for j=1:N
%     if ~any(sums==j)
%         cannot=[cannot,j];
%     end
% end
cannot2=setdiff(1:N,sums);
