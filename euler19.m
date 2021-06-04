count=0;
for i=1901:2000
    for j=1:12
        if weekday(datestr([i,j,1,0,0,0]))==1
            count=count+1;
        end
    end
end