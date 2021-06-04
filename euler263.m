N=10^10;
P=primes(N);
Pdiff=P(2:end)-P(1:end-1);
tp=(Pdiff(1:end-2)==6) & (Pdiff(2:end-1)==6) & (Pdiff(3:end)==6);
tp=find(tp==1);

list=[];
count=0;
for i=tp
   n=P(i)+9;
   breaker=false;
   for k=n+[-8:4:8]
       D=divisor(k);
       upto=3;
       for j=3:length(D);
           if D(j)>upto+1
               breaker=true;
               break
           else
               upto=upto+D(j);
           end
       end
       if breaker
           break
       end
   end
   if ~breaker
       list=[list,n];
       count=count+1;
       if count==4
           break
       end
   end
end
sum(list)




k=7;
breaker=false;
D=divisor(k);
upto=3;
for j=3:length(D);
    if D(j)>(upto+1)
        breaker=true;
        break
    else
        upto=upto+D(j);
    end
end