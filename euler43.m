n=9;
P=perms([0:n]);
pandig=[];
for i=1:size(P,1)
    num=P(i,:);
    if ~mod(num(4),2) && ~mod(sum(num(3:5)),3) && ~mod(num(6),5) && ~mod(polyval(num(5:7),10),7) && ~mod(polyval(num(6:8),10),11) && ~mod(polyval(num(7:9),10),13) && ~mod(polyval(num(8:10),10),17)
        p=polyval(P(i,:),10);
        pandig=[pandig,p];
    end
end
sum(pandig)