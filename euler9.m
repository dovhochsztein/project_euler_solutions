for i=1:1000
    for j=1:1000
        for k=1:1000
            if i+j+k==1000 && i^2+j^2==k^2
                i*j*k
            end
        end
    end
end