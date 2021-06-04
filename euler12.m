N=100000;
A=1:N;
B=cumsum(A);
for i=1:N
    if length(divisors(B(i)))>500
        B(i)
        break
    end
end