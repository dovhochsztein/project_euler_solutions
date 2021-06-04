N=5;
img=false(2^N);
for i=1:2^N
    for j=1:2^N
        x=i-1;
        y=j-1;
        img(i,j)=(x-2^(N-1))^2+(y-2^(N-1))^2<=2^(2*N-2);
    end
end
        
