% N=1;
% C{N}(1,:)=[7,53,183,94,369,56,1];
% C{N}(2,:)=[2383,3563,5079,42,212,344,2];
% C{N}(3,:)=[2393,3583,5099,100,272,404,3];
LIM=20;
L=1;

C=cell(1,LIM);
C{1}=zeros(L,7);

S=zeros(1,6*L);
for k=1:55
    S(k)=mod(100003 - 200003*k + 300007*k^3,1000000);
end
for k=56:6*L
    S(k)=mod(S(k-24)+S(k-55),1000000);
end
for n=1:L
    C{1}(n,:)=[mod([S(6*n-5),S(6*n-4),S(6*n-3)],10000),1+mod([S(6*n-2),S(6*n-1),S(6*n)],399),n];
end


for N=1:LIM-1
    C{N+1}=[];
    
    
    for j=1:size(C{N},1)
        %     for i=1:size(C{1},1)
        for i=1:min([size(C{1},1),C{N}(j,7:end)-1])
            %         if any(C{1}(i,7)>=C{N}(j,7:end))
            %             continue
            %         end
            xdiff=C{1}(i,1)-C{N}(j,1);
            if (xdiff > 0 && xdiff < C{N}(j,4))
                xoverlap=[C{1}(i,1),min(C{1}(i,1)+C{1}(i,4),C{N}(j,1)+C{N}(j,4))-C{1}(i,1)];
            elseif (xdiff < 0 && -xdiff < C{1}(i,4))
                xoverlap=[C{N}(j,1),min(C{1}(i,1)+C{1}(i,4),C{N}(j,1)+C{N}(j,4))-C{N}(j,1)];
            else
                continue
            end
            ydiff=C{1}(i,2)-C{N}(j,2);
            if (ydiff > 0 && ydiff < C{N}(j,5))
                yoverlap=[C{1}(i,2),min(C{1}(i,2)+C{1}(i,5),C{N}(j,2)+C{N}(j,5))-C{1}(i,2)];
            elseif (ydiff < 0 && -ydiff < C{1}(i,5))
                yoverlap=[C{N}(j,2),min(C{1}(i,2)+C{1}(i,5),C{N}(j,2)+C{N}(j,5))-C{N}(j,2)];
            else
                continue
            end
            zdiff=C{1}(i,3)-C{N}(j,3);
            if (zdiff > 0 && zdiff < C{N}(j,6))
                zoverlap=[C{1}(i,3),min(C{1}(i,3)+C{1}(i,6),C{N}(j,3)+C{N}(j,6))-C{1}(i,3)];
            elseif(zdiff < 0 && -zdiff < C{1}(i,6))
                zoverlap=[C{N}(j,3),min(C{1}(i,3)+C{1}(i,6),C{N}(j,3)+C{N}(j,6))-C{N}(j,3)];
            else
                continue
            end
            C{N+1}=[C{N+1};[xoverlap(1),yoverlap(1),zoverlap(1),xoverlap(2),yoverlap(2),zoverlap(2),C{1}(i,7:end),C{N}(j,7:end)]];
        end
    end
    if length(C{N+1})==0
        C=C(1:N);
        break
    end
end

vol=0;
for N=1:length(C)
    for i=1:size(C{N},1)
        vol=vol-prod(C{N}(i,4:6))*(-1)^N;
    end
    vol
end

figure;
axis(10399*[0,1,0,1,0,1]);
hold on
for i=1:L   
cube_plot(C{1}(i,1:3),C{1}(i,4),C{1}(i,5),C{1}(i,6),'r')
end
for i=[20,59,23,89] 
cube_plot(C{1}(i,1:3),C{1}(i,4),C{1}(i,5),C{1}(i,6),'g')
end
% for i=1:size(C{9},1)
% cube_plot(C{9}(i,1:3),C{9}(i,4),C{9}(i,5),C{9}(i,6),'b')
% for j=7:15
%     ind=C{9}(i,j);
%     cube_plot(C{1}(ind,1:3),C{1}(ind,4),C{1}(ind,5),C{1}(ind,6),'r')
% end
% end


for i=1:size(C{3},1)
cube_plot(C{3}(i,1:3),C{3}(i,4),C{3}(i,5),C{3}(i,6),'b')
for j=7:9
    ind=C{3}(i,j);
    cube_plot(C{1}(ind,1:3),C{1}(ind,4),C{1}(ind,5),C{1}(ind,6),'r')
end
end