prods=zeros(990,990);
for i=10:999
    for j=10:999
        product=i*j;
        string=num2str(product);
        if strcmp(string,reverse(string))
            prods(i-9,j-9)=product;
        end
    end
end
max(max(max(prods)))