N=60000000;
LIM=vpi(10)^18;
div=zeros(1,N);
facold=factor(2);
less_than=zeros(1,N);
% less_inds=cell(1,N);
count=vpi(0);
for i=3:N+1
    facnew=factor(i);
    I=sort([facold,facnew]);
    I=I(2:end);
    multiplicitiesi=[];
    l=1;
    while l<=length(I)
        num=sum(I==I(l));
        multiplicitiesi=[multiplicitiesi,num];
        l=l+num;
    end
    div(i-1)=prod(multiplicitiesi+1);
%     less_inds{i-1}=find(div(1:i-2)>div(i-1));
    less_than(i-1)=(sum(div(1:i-2)>div(i-1)));
    count=mod(count+vpi(sum(less_than(find(div(1:i-2)>div(i-1))))),LIM);
%     new(i)=sum(less_than(find(div(1:i-2)>div(i-1))));
%     count=count+sum(less_than(less_inds{i-1}));
    facold=facnew;
end
count







% N=100;
% list=[];
% for i=2:N
%     I=factor(i*(i+1)/2);
%     multiplicitiesi=[];
%     l=1;
%     while l<=length(I)
%         num=sum(I==I(l));
%         multiplicitiesi=[multiplicitiesi,num];
%         l=l+num;
%     end
%     divI=prod(multiplicitiesi+1);
%     for j=i+1:N
%         J=factor(j*(j+1)/2);
%         multiplicitiesj=[];
%         l=1;
%         while l<=length(J)
%             num=sum(J==J(l));
%             multiplicitiesj=[multiplicitiesj,num];
%             l=l+num;
%         end
%         divJ=prod(multiplicitiesj+1);
%         for k=j+1:N
%             K=factor(k*(k+1)/2);
%             l=1;
%             multiplicitiesk=[];
%             while l<=length(K)
%                 num=sum(K==K(l));
%                 multiplicitiesk=[multiplicitiesk,num];
%                 l=l+num;
%             end
%             divK=prod(multiplicitiesk+1);
%             
%             if divI>divJ && divJ>divK
%                 list=[list;[i,j,k]];
%             end
%         end
%     end
% end