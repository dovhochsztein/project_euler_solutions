N=30;
% list={};
% for i=1:2^N-1
%     B=zeros(1,N+2);
%     for k=1:3
%         A=zeros(1,N+2);
%         for j=1:N+2
%             A(N+1-j+2)=floor(mod(i*k,2^(j))/2^(j-1));
%         end
%         B=B+A;
%     end
%     if all(~mod(B,2))
%         list=[list,dec2bin(i)];
%     end
% end


SUM=0;
for i=1:ceil(N/2)
    SUM=SUM+nchoosek(N-i+1,i)
end
SUM+1