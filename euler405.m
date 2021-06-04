N=10;

f=zeros(1,N);
for n=1:N
for i=1:4^n
    inds=cell(1,n);
    [inds{:}]=ind2sub(4*ones(1,n),i);
end
end
   