period=2000;

g=ones(1,period);
for i=period+1:10^6
    g(i)=g(i-period)+g(i-period+1);
end
g(2:period-1:2+(period-1)*10)