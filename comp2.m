function output=comp2(x)
if (x(1)==x(2))
    comp1=@(x) mod([0,1]+x,3)+1;
    output=comp1(x(1));
else
    output=(6-sum(x));
end
end