function output= dec2vec(d)
digs=ceil(log10(d+1));
output=zeros(1,digs);
for j=1:digs
    output(digs+1-j)=floor(mod(d,10^(j))/10^(j-1));
end
end