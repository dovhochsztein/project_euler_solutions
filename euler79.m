A=[319
    680
    180
    690
    129
    620
    762
    689
    762
    318
    368
    710
    720
    710
    629
    168
    160
    689
    716
    731
    736
    729
    316
    729
    729
    710
    769
    290
    719
    680
    318
    389
    162
    289
    162
    718
    729
    319
    790
    680
    890
    362
    319
    760
    316
    729
    380
    319
    728
    716];

B=cell(50,1);
for i=1:50
    temp=num2str(A(i));
    for j=1:3
        B{i}(j)=str2num(temp(j));
    end
end

code=[];
for iter=1:10
for i=0:9
    broke=false;
    first=false;
    for j=1:50
        if any(B{j}(2:end)==i)
            broke=true;
            break
        end
    end
    for j=1:50
        if ~isempty(B{j}) && B{j}(1)==i
            first=true;
            break
        end
    end
    if ~broke && first
        code=[code,i];
        for j=1:50
            if ~isempty(B{j}) && B{j}(1)==i
                B{j}=B{j}(2:end);
            end
        end
    end
end
end

code