
% p=1000;
% list=[];
% for a=1:floor(.4*p)
%     b=(p^2-2*p*a)/(2*(p-a));
%     for b=a:floor(.8*p)
%         c=sqrt(a^2+b^2);
%         if a+b+c>p
%             break
%         
%         elseif a+b+c==p
%             list=[list;[a,b,c]];
%         end
%     end
% end
% 
lens=[];
for p=1:1000
list=[];
for a=1:p
    b=(p^2-2*p*a)/(2*(p-a));
    if b>a && floor(b)==b
        list=[list;[a,b,p-a-b]];
    end
end
lens=[lens,length(list)];
end
find(lens==max(lens))