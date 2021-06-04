frac=15499/94744;
% frac=4/10;
% frac=.20;
P=primes(1000);
% d=1;
% T=1;
% for i=2:length(P)
%     d=d*P(i);
% %     T=totient(d);
%     T=T*(1-1/P(i));
%     if T<frac
%         break
%     end
% end


% for d=1:100000
% %     d=d*P(i);
%     T=totient(d);
% %     T=T*(1-1/P(i));
%     if T/(d-1)<frac
% %     if T<frac
%         break
%     end
% end
% d


d=6;
max_prime=2;
F=totient(d)/(d-1);

while 1
    
%     ps=P(1:max_prime);
    ps=2:P(max_prime+1);
    
    
    mult_by_next=(1-1/P(max_prime+1))*P(max_prime+1)*(d-1)/(P(max_prime+1)*d-1);
    mult_by_ex=ps*(d-1)./(ps*d-1);
    mult_by_ex(end)=mult_by_next;
    
    if F*mult_by_next>frac
        F=F*mult_by_next;
        d=d*P(max_prime+1);
        max_prime=max_prime+1;
%         ps=P(1:max_prime);
        ps=2:P(max_prime+1);
    else
        ind=find(F*mult_by_ex<frac,1);
        F=F*mult_by_ex(ind);
        d=d*ps(ind);
        break
    end
end
d
