


D=10000;
tol=10^-6;
n=10000;
period=zeros(1,n);
for N=1:n
    %     list=zeros(1,D);
    % REM=zeros(1,D);
    list=[];
    REM=[];
    broke=false;
    list(1)=floor(sqrt(N));
    REM(1)=sqrt(N)-list(1);
    if REM(1)==0
        continue
    end
    candidates=[];
    for i=2:D
        list(i)=floor(1/REM(i-1));
        new=1/REM(i-1)-list(i);
        for j=1:length(candidates)
            if list(i)==list(i-candidates(j)) && abs(new-REM(i-candidates(j)))<tol
                broke=true;
                period(N)=candidates(j);
                break
            else
            end
        end
        if broke
            break
        end
        if any(abs(REM-new)<tol)
            candidates=[candidates,i-(find(abs(REM-new)<tol))];
        end
        
        REM(i)=new;
    end
    if ~broke
        error('D not enough')
    end
end
sum(mod(period,2))
