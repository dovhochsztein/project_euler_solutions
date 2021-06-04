a{1}=1;
a{2}=2;
a{3}=[3,3];
for i=4:15
    a{i}=zeros(1,length(a{i-1})+1-~mod(i,2));
end

comp1=@(x) mod([0,1]+x,3)+1;
%comp2=@(x) (x(1)==x(2)) * comp1(x(1)) + ~(x(1)==x(2)) * (6-sum(x));


count=0;
list=[];
possibilities=cell(1,15);


i=3;
L=length(a{i});
if ~mod(i,2)
    possibilities{i}=cell(1,L+1);
    possibilities{i}{1}=comp1(a{i}(1));
    possibilities{i}{end}=comp1(a{i}(end));
    for j=2:L
        possibilities{i}{j}=comp2([a{i}(j-1),a{i}(j)]);
    end
else
    possibilities{i}=cell(1,L);
    for j=1:L
        possibilities{i}{j}=comp1(a{i}(j));
    end
end

possibilities{i}=combvec(possibilities{i}{:});
for j=1:size(possibilities{i},2)
    i=3;
    a{i+1}=possibilities{i}(:,j);
    

    
    
i=4;
L=length(a{i});
if ~mod(i,2)
    possibilities{i}=cell(1,L+1);
    possibilities{i}{1}=comp1(a{i}(1));
    possibilities{i}{end}=comp1(a{i}(end));
    for j=2:L
        possibilities{i}{j}=comp2([a{i}(j-1),a{i}(j)]);
    end
else
    possibilities{i}=cell(1,L);
    for j=1:L
        possibilities{i}{j}=comp1(a{i}(j));
    end
end
possibilities{i}=combvec(possibilities{i}{:});
for j=1:size(possibilities{i},2)
    i=4;
    a{i+1}=possibilities{i}(:,j);
    

    
    
i=5;
L=length(a{i});
if ~mod(i,2)
    possibilities{i}=cell(1,L+1);
    possibilities{i}{1}=comp1(a{i}(1));
    possibilities{i}{end}=comp1(a{i}(end));
    for j=2:L
        possibilities{i}{j}=comp2([a{i}(j-1),a{i}(j)]);
    end
else
    possibilities{i}=cell(1,L);
    for j=1:L
        possibilities{i}{j}=comp1(a{i}(j));
    end
end
possibilities{i}=combvec(possibilities{i}{:});
for j=1:size(possibilities{i},2)
    i=5;
    a{i+1}=possibilities{i}(:,j);  
    

    
    
i=6;
L=length(a{i});
if ~mod(i,2)
    possibilities{i}=cell(1,L+1);
    possibilities{i}{1}=comp1(a{i}(1));
    possibilities{i}{end}=comp1(a{i}(end));
    for j=2:L
        possibilities{i}{j}=comp2([a{i}(j-1),a{i}(j)]);
    end
else
    possibilities{i}=cell(1,L);
    for j=1:L
        possibilities{i}{j}=comp1(a{i}(j));
    end
end
possibilities{i}=combvec(possibilities{i}{:});
for j=1:size(possibilities{i},2)
    i=6;
    a{i+1}=possibilities{i}(:,j);  
    

    
    
i=7;
L=length(a{i});
if ~mod(i,2)
    possibilities{i}=cell(1,L+1);
    possibilities{i}{1}=comp1(a{i}(1));
    possibilities{i}{end}=comp1(a{i}(end));
    for j=2:L
        possibilities{i}{j}=comp2([a{i}(j-1),a{i}(j)]);
    end
else
    possibilities{i}=cell(1,L);
    for j=1:L
        possibilities{i}{j}=comp1(a{i}(j));
    end
end
possibilities{i}=combvec(possibilities{i}{:});
for j=1:size(possibilities{i},2)
    i=7;
    a{i+1}=possibilities{i}(:,j);  
    

    
    
i=8;
L=length(a{i});
if ~mod(i,2)
    possibilities{i}=cell(1,L+1);
    possibilities{i}{1}=comp1(a{i}(1));
    possibilities{i}{end}=comp1(a{i}(end));
    for j=2:L
        possibilities{i}{j}=comp2([a{i}(j-1),a{i}(j)]);
    end
else
    possibilities{i}=cell(1,L);
    for j=1:L
        possibilities{i}{j}=comp1(a{i}(j));
    end
end
possibilities{i}=combvec(possibilities{i}{:});
for j=1:size(possibilities{i},2)
    i=8;
    a{i+1}=possibilities{i}(:,j);  
    

    
    
i=9;
L=length(a{i});
if ~mod(i,2)
    possibilities{i}=cell(1,L+1);
    possibilities{i}{1}=comp1(a{i}(1));
    possibilities{i}{end}=comp1(a{i}(end));
    for j=2:L
        possibilities{i}{j}=comp2([a{i}(j-1),a{i}(j)]);
    end
else
    possibilities{i}=cell(1,L);
    for j=1:L
        possibilities{i}{j}=comp1(a{i}(j));
    end
end
possibilities{i}=combvec(possibilities{i}{:});
for j=1:size(possibilities{i},2)
    i=9;
    a{i+1}=possibilities{i}(:,j);  
%     
% 
%     
%     
% i=10;
% L=length(a{i});
% if ~mod(i,2)
%     possibilities{i}=cell(1,L+1);
%     possibilities{i}{1}=comp1(a{i}(1));
%     possibilities{i}{end}=comp1(a{i}(end));
%     for j=2:L
%         possibilities{i}{j}=comp2([a{i}(j-1),a{i}(j)]);
%     end
% else
%     possibilities{i}=cell(1,L);
%     for j=1:L
%         possibilities{i}{j}=comp1(a{i}(j));
%     end
% end
% possibilities{i}=combvec(possibilities{i}{:});
% for j=1:size(possibilities{i},2)
%     i=10;
%     a{i+1}=possibilities{i}(:,j);  
    

    
    
% i=11;
% L=length(a{i});
% if ~mod(i,2)
%     possibilities{i}=cell(1,L+1);
%     possibilities{i}{1}=comp1(a{i}(1));
%     possibilities{i}{end}=comp1(a{i}(end));
%     for j=2:L
%         possibilities{i}{j}=comp2([a{i}(j-1),a{i}(j)]);
%     end
% else
%     possibilities{i}=cell(1,L);
%     for j=1:L
%         possibilities{i}{j}=comp1(a{i}(j));
%     end
% end
% possibilities{i}=combvec(possibilities{i}{:});
% for j=1:size(possibilities{i},2)
%     i=11;
%     a{i+1}=possibilities{i}(:,j);  
    

    
    
% i=12;
% L=length(a{i});
% if ~mod(i,2)
%     possibilities{i}=cell(1,L+1);
%     possibilities{i}{1}=comp1(a{i}(1));
%     possibilities{i}{end}=comp1(a{i}(end));
%     for j=2:L
%         possibilities{i}{j}=comp2([a{i}(j-1),a{i}(j)]);
%     end
% else
%     possibilities{i}=cell(1,L);
%     for j=1:L
%         possibilities{i}{j}=comp1(a{i}(j));
%     end
% end
% possibilities{i}=combvec(possibilities{i}{:});
% for j=1:size(possibilities{i},2)
%     i=12;
%     a{i+1}=possibilities{i}(:,j);  
%     
% 
%     
%     
% i=13;
% L=length(a{i});
% if ~mod(i,2)
%     possibilities{i}=cell(1,L+1);
%     possibilities{i}{1}=comp1(a{i}(1));
%     possibilities{i}{end}=comp1(a{i}(end));
%     for j=2:L
%         possibilities{i}{j}=comp2([a{i}(j-1),a{i}(j)]);
%     end
% else
%     possibilities{i}=cell(1,L);
%     for j=1:L
%         possibilities{i}{j}=comp1(a{i}(j));
%     end
% end
% possibilities{i}=combvec(possibilities{i}{:});
% for j=1:size(possibilities{i},2)
%     i=13;
%     a{i+1}=possibilities{i}(:,j);  
%     
% 
%     
%     
% i=14;
% L=length(a{i});
% if ~mod(i,2)
%     possibilities{i}=cell(1,L+1);
%     possibilities{i}{1}=comp1(a{i}(1));
%     possibilities{i}{end}=comp1(a{i}(end));
%     for j=2:L
%         possibilities{i}{j}=comp2([a{i}(j-1),a{i}(j)]);
%     end
% else
%     possibilities{i}=cell(1,L);
%     for j=1:L
%         possibilities{i}{j}=comp1(a{i}(j));
%     end
% end
% possibilities{i}=combvec(possibilities{i}{:});
% for j=1:size(possibilities{i},2)
%     i=14;
%     a{i+1}=possibilities{i}(:,j);   
%     
% 
%     
%     
% i=15;
% L=length(a{i});
% if ~mod(i,2)
%     possibilities{i}=cell(1,L+1);
%     possibilities{i}{1}=comp1(a{i}(1));
%     possibilities{i}{end}=comp1(a{i}(end));
%     for j=2:L
%         possibilities{i}{j}=comp2([a{i}(j-1),a{i}(j)]);
%     end
% else
%     possibilities{i}=cell(1,L);
%     for j=1:L
%         possibilities{i}{j}=comp1(a{i}(j));
%     end
% end
% possibilities{i}=combvec(possibilities{i}{:});
% for j=1:size(possibilities{i},2)
%     i=15;
%     a{i+1}=possibilities{i}(:,j);   
    
    
    
    
    
    
    
    %list=[list;[a{i}',a{i+1}']];
    count=count+1;
end
end
end
end
end
end
end
% end
% end
% end
% end
% end
% end



% 
% i=3;
% L=length(a{i});
% if ~mod(i,2)
%     possibilities{i}=cell(1,L+1);
%     possibilities{i}{1}=comp1(a{i}(1));
%     possibilities{i}{end}=comp1(a{i}(end));
%     for j=2:L
%         possibilities{i}{j}=comp2([a{i}(j-1),a{i}(j)]);
%     end
% else
%     possibilities{i}=cell(1,L);
%     for j=1:L
%         possibilities{i}{j}=comp1(a{i}(j));
%     end
% end
% 
% possibilities{i}=combvec(possibilities{i}{:});
% for j=1:size(possibilities{i},2)
%     i=3;
%     a{i+1}=possibilities{i}(:,j);
%     
%     
% i=4;
% L=length(a{i});
% if ~mod(i,2)
%     possibilities{i}=cell(1,L+1);
%     possibilities{i}{1}=comp1(a{i}(1));
%     possibilities{i}{end}=comp1(a{i}(end));
%     for j=2:L
%         possibilities{i}{j}=comp2([a{i}(j-1),a{i}(j)]);
%     end
% else
%     possibilities{i}=cell(1,L);
%     for j=1:L
%         possibilities{i}{j}=comp1(a{i}(j));
%     end
% end
% possibilities{i}=combvec(possibilities{i}{:});
% for j=1:size(possibilities{i},2)
%     i=4;
%     a{i+1}=possibilities{i}(:,j);
%     list=[list;[a{i}',a{i+1}']];
%     
%     
%     
%     
%     
%     
%     
%     
%     
%     
%     count=count+1;
% end
% end
