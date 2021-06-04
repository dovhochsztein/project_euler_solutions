palin=[];
for i=1:(10^6);
    digits10=dec2base(i,10)- '0';
    if all(digits10==fliplr(digits10))
         digits2=dec2base(i,2)- '0';
         if all(digits2==fliplr(digits2))
              palin=[palin,i];
         end
    end
end
sum(palin)

