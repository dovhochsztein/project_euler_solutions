f=@(t) 4.^t-2.^t;
% fplot(f,[1,2])
% % ylim([0,5])
% 
% n=[2:20];
% t=[2:20];
% t=log2(n);
% k=f(t);
% plot(t,k)
% fsolve(@(x) f(x)-3,0)

perf=0;
for n=2:10000000
    t=log2(n);
    
    if ~mod(t,1)
        perf=perf+1;
    end
    if perf/(n-1)<1/12345
        k=f(t);
        break
        
    end
end