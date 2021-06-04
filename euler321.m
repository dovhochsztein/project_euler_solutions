N=9e15;
list=[];
ns=[];
for n=1:100
    M=n*(n+2);
    cand=floor(sqrt(2*M))+[0,1];
    tri=false;
    for j=1:2
        if cand(j)*(cand(j)+1)/2==M
            tri=true;
            break
        end
    end
    if tri
        list=[list,n];
    end
end
n=101;

ratio=[2.093836757357024,2.783613603884288];
upto=2;

while n<N
    ns=[ns,n];
    M=vpi(n)*vpi(n+2);
    cand=vpi(floor(sqrt(double(2*n*(n+2)))));
%     tri=false;
    %     for j=1
    if cand*(cand+1)/2==M
%         tri=true;
        %             break
        %         end
        % %     endW
        %     if tri
        list=[list,n];
        if length(list)==40
            break
        end
        n=floor(ratio(upto)*n*(1-.5^log(n)));
        upto=3-upto;
        if n>10^8
            ratio(upto)=list(end)/list(end-1);
        end
    else
        n=n+1;
    end
end
sum(vpi(list))