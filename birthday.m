%Euler ID:645

%brute force
% D=365;
% N=1000;
% t=zeros(1,N);
% for K=1:N
%     H=false(1,D);
%     for i=1:10000
%         E=randi([1,D]);
%         H(E)=true;
%         if H(1) & H(end-1)
%             H(end)=true;
%         end
%         if H(2) & H(end)
%             H(1)=true;
%         end
%         for j=2:D-1
%             if H(j-1) & H(j+1)
%                 H(j)=true;
%             end
%         end
%         if all(H)
%             break
%         end
%     end
%     t(K)=i;
% end
% mean(t)

E(1)=1;
E(2)=1;
for i=3:10
    E(i)=1+E(i-1)*(i)/(i-1);
end