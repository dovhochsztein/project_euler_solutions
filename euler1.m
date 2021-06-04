SUM=0;
for i=1:999;
    if ~mod(i,3) || ~mod(i,5)
        SUM=SUM+i;
    end
end