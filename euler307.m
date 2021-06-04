k=3;
n=7;

num=0;
for doub=0:floor(k/2)
    sing=k-2*doub
    num=num+nchoosek(n,sing)*nchoosek(n-sing,doub)*factorial(k)/2^doub;
end
1-num/n^k