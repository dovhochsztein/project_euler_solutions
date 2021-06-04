digs=[0:9]
N=length(digs);
lex=10^6;

result=zeros(1,N);
for i=1:N
    ind=ceil(lex/factorial(N-i));
    lex=lex-factorial(N-i)*(ind-1);
    result(i)=digs(ind);
    digs(digs==digs(ind))=[];
end

result