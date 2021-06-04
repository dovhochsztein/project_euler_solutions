tot=0;
MAX=1/(1-log(9)/log(10));


for n=1:floor(MAX)
lowbound=10^((n-1)/n);
tot=tot+10-ceil(lowbound)
end