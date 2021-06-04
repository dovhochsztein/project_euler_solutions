N=100;

optimal=zeros(N+1,N+1);
prob=zeros(N+1,N+1);
prob(:,1)=ones(N+1,1);
optimal(2,2)=1;
prob(2,2)=.5+.5*pi/6;

for a=1:2*N-1
    for i=2+max(0,a-N):N-max(0,N-a)+1
        j=a-i+3;
% i=2;
% j=2;
Tmax=ceil(log2(j-1))+1;
prob_temp=zeros(1,Tmax);
for T=1:Tmax
    jtarget=max(1,j-2^(T-1));
    prob_temp(T)=(1/2^(T+1)*(prob(i-1,jtarget)+prob(i,jtarget))+(2^T-1)/2^(T+1)*prob(i-1,j))/(1-(2^T-1)/2^(T+1));
end
prob(i,j)=max(prob_temp);
optimal(i,j)=find(prob_temp==prob(i,j),1);

    end
end

round(.5*(prob(end,end)+prob(end-1,end)),8)
