N=250250;
N=100000;
A=[1:N];
B=A;

A250=A;
for i=1:250
    A250=mod(A250.*A,250);
end
num250=floor(A/250);
REM250=rem(A,250);

B=ones(1,N);
for i=1:max(num250)
    B=mod(B.*A250.^(num250>i),250);
end



for i=1:N
    B=mod(B.*A.^(A>i),250);
end
C=mod(A.^A,250);