soln=[];
cusp=10^9;
for D=2:1000
    if ~mod(sqrt(D),1)
        soln=[soln;[D,0,0]];
    else
        for y=1:cusp
            x=sqrt(D*y^2+1);
            if ~mod(x,1)
                digs=ceil(log10(x+1));
                A=zeros(1,digs);
                for j=1:digs
                    A(digs+1-j)=floor(mod(x,10^(j))/10^(j-1));
                end
                A=reduce(A*x);
                
                
                B=zeros(1,digs);
                for j=1:digs
                    B(digs+1-j)=floor(mod(y,10^(j))/10^(j-1));
                end
                B=D*B*y;
                B(end)=B(end)+1;
                B=reduce(B);
                if all(A==B)
                    soln=[soln;[D,x,y]];
                    break
                end
            end
        end
%         if y==cusp
%             ystart=ceil(cusp*sqrt(D));
%             yinc=sqrt(D);
% %             for y=
%             1;
%         end
    end
end
find(soln(:,2)==max(soln(:,2)));
inds=find(soln(:,2)>10^9);

ind_list=[];

for i=1:length(inds)
    D=soln(inds(i),1);
    x=soln(inds(i),2);
    y=soln(inds(i),3);
    digs=ceil(log10(x+1));
    A=zeros(1,digs);
    for j=1:digs
        A(digs+1-j)=floor(mod(x,10^(j))/10^(j-1));
    end
    A=reduce(A*x);
    
    
    B=zeros(1,digs);
    for j=1:digs
        B(digs+1-j)=floor(mod(y,10^(j))/10^(j-1));
    end
    B=D*B*y;
    B(end)=B(end)+1;
    B=reduce(B);
    
    if ~all(A==B)
        ind_list=[ind_list,i];
    end
end



% soln=[];
% for D=2:100
%     if ~mod(sqrt(D),1)
%         soln=[soln;[D,0,0]];
%     else
%         for x=2:100000000
%             y=sqrt((x^2-1)/D);
%             if ~mod(y,1)
%                 soln=[soln;[D,x,y]];
%                 break
%             end
%         end
%     end
% end


% soln=[];
% for D=2:15
%     if ~mod(sqrt(D),1)
%         soln=[soln;[D,0,0]];
%     else
%         for x=2:1000000
%             y=sqrt((x^2-1)/D);
%             if ~mod(y,1)
%                 soln=[soln;[D,x,y]];
%                 break
%             end
%         end
%     end
% end