N=10;
A=cell(1,N+1);
A{1}=[1,1;1,1];
A{2}=[1,1;1,1];
A{3}=[2,1;1,2];


for n=3:4
    A{n+1}=zeros(2,2);
    for i=1:n
        A{n+1}(1,1)=A{n+1}(1,1)+A{i}(2,1)*A{n-i+1}(1,2)*nchoosek(n-1,i-1);
    end
    for i=1:n-1 %RIGHT SIDE BLOCKED
        A{n+1}(1,2)=A{n+1}(1,2)+A{i}(2,2)*A{n-i+1}(1,2)*nchoosek(n-1,i-1);
    end
    for i=2:n %LEFT SIDE BLOCKED
        A{n+1}(2,1)=A{n+1}(2,1)+A{i}(1,2)*A{n-i+1}(2,2)*nchoosek(n-1,i-1);
    end
    for i=2:n-1 %BOTH SIDES BLOCKED
        A{n+1}(2,2)=A{n+1}(2,2)+A{i}(2,2)*A{n-i+1}(2,2)*nchoosek(n-1,i-1);
    end
end