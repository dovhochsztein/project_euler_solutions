list=[];
list1=[];

% pow=4;
% for T=10^12:10^13
%     B=ceil(T/sqrt(2));
%     B1=floor(B/10^(2*pow))*10^(2*pow);
%     B2=floor((B-B1)/10^pow)*10^pow;
%     B3=B-B1-B2;
%     part1=(B1/T)+B2/T+B3/T;
%     part2=(B1/(T-1))+(B2)/(T-1)+(B3-1)/(T-1);
% %     if B/T*(B-1)/(T-1)==.5
%     (part1-sqrt(2)/2)*(part2-sqrt(2)/2)+(sqrt(2)/2*(part1+part2))==1
%     if part1==.5/part2
%         break
%     end
% end
% T
% 
% for Tnum=1.007584772537000e+12:10^13

inc=[1.276142365091053   1.522407735363463   1.828427109575865   1.640754475616748];
inc=[1.276142373229805   1.522407747428692   1.828427122143374   1.640754475616748];
    counter=1;

approx=0.146446628496051;
Tnum=1;
MAX=10^13;
while Tnum<=MAX
%     temp=Tnum/sqrt(2);
%     Bnum=ceil(temp);
    if abs(ceil(Tnum/sqrt(2))-Tnum/sqrt(2)-approx)>1/Tnum
        Tnum=Tnum+1;
        continue
    end
    list1=[list1,Tnum];
%     if Tnum>1000
%     inc(counter)=Tnum/list1(end-1);
%     end
     Bnum=ceil(Tnum/sqrt(2));
%     digs=floor(log10(Tnum))+1;
%     T=zeros(1,digs);
%     B=zeros(1,digs);
%     for j=1:digs
%         T(digs+1-j)=floor(mod(Tnum,10^(j))/10^(j-1));
%         B(digs+1-j)=floor(mod(Bnum,10^(j))/10^(j-1));
%     end
% %     T=(dec2base(Tnum,10)-'0');
% %     B=(dec2base(Bnum,10)-'0');
% %     if length(B)~=length(T)
% %         B=[0,B];
% %     end
%     LHS=(Bnum-1)*B;
%     RHS=(Tnum-1)*T/2;
%     for j=length(RHS):-1:2
%         if RHS(j)>=10
%             RHS(j-1)=RHS(j-1)+floor(RHS(j)/10);
%             RHS(j)=RHS(j)-floor(RHS(j)/10)*10;
%         end
%         if LHS(j)>=10
%             LHS(j-1)=LHS(j-1)+floor(LHS(j)/10);
%             LHS(j)=LHS(j)-floor(LHS(j)/10)*10;
%         end
%     end
    
    B=vpi(Bnum);
    T=vpi(Tnum);
    LHS=(B-1)*B;
    RHS=(T-1)*T/2;
    if all(RHS==LHS)
        list=[list,Tnum];
        approx=Bnum-Tnum/sqrt(2);
%         break
    end
%     Tnum=Tnum+1;
    Tnum=max(Tnum+1,floor(Tnum*((inc(counter)-1)*(1-1.9^(-Tnum))+1)));
    counter=mod(counter,4)+1;
end