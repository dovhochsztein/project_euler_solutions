pandig=[];
for i=1:100000
        digs=[];
    for j=1:5
        new=dec2base(i*j,10)- '0';
        digs=[digs,new];
        if any(new==0) || length(digs)>9 || length(unique(new))~=length(new)
            break
        end
        un=unique(digs);
        if length(digs)==9 && length(un)==9 && all(un==[1:9])
           pandig=[pandig,polyval(digs,10)];
           break
        end
    end
end
max(pandig)