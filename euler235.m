u=@(k,r) (900-3*k).*r.^(k-1);
s=@(r) sum(u(1:5000,r));
target=-600000000000;
fzero(@(r) s(r)-target,1)