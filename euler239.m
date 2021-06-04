SUM=0;
for i=0:21
    SUM=SUM+nchoosek(22,22-i)*nchoosek(97-22+i,i);
end
nchoosek(25,3)*SUM*factorial(75)/factorial(100)