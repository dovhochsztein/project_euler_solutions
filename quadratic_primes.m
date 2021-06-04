%Euler ID: 27

b=[];
for i=1:1000
    if isprime(i) & i>41
        b=[b,i];
    end
end
a=[-1000:1000];

results=zeros(length(a),length(b));
for i=1:length(a);
    for j =1:length(b)
        results(i,j)=i+j;
        for n=0:1000
            S=n^2+a(i)*n+b(j);
            if S<0 || ~isprime(S)
                break
            end
            results(i,j)=n+1;
        end
    end
end

MAX=max(results(:));
ind=find(results==MAX);
[I,J]=ind2sub([length(a),length(b)],ind);
A=a(I); B=b(J);

S=zeros(1,MAX+10);
prime=zeros(1,MAX+10);
for n=0:MAX+10
    S(n+1)=n^2+A*n+B;
    if S(n+1)<0 || ~isprime(S(n+1))
        prime(n+1)=1;
    end
end
A*B