clear
ranges = {[1:50],[1:40]};
a=1;
b=2;
c=4;
inputs={a,b,c};


N=length(ranges);
ns=zeros(1,N);
for i=1:N;
    ns(i)=length(ranges{i});
end
[dinputs{1:N}]=ndgrid(ranges{:});

indices=combvec(ranges{:});
indices=num2cell(combvec(ranges{:}));
lpcmnds={1,{{'input',1},{'input',2},{'dinput',1},{'dinput',2}},@(a,b,c,d) a*c + b*d;...
         2,{{'input',1},{'input',2},{'dinput',1},{'dinput',2},{'output',1}},@(a,b,c,d,e) b*c + a*d+e};
for i=1:length(lpcmnds)
    output_num(i)=lpcmnds{i}{1};
end
outputs=cell(1,max(output_num));
for I=1:length(indices)
%     index=num2cell(indices(:,I));
    index=indices(:,I);
    Q(index{:})=inputs{1}*dinputs{1}(index{:})+inputs{2}*dinputs{2}(index{:});
    for j=1:length(lpcmnds)
        inps=cell(1,length(lpcmnds{j}{2}));
        for k=1:length(lpcmnds{j}{2})
            if strcmp(lpcmnds{j}{2}{k}{1},'input')
                inps{k}=inputs{lpcmnds{j}{2}{k}{2}};
            elseif strcmp(lpcmnds{j}{2}{k}{1},'dinput')
                inps{k}=dinputs{lpcmnds{j}{2}{k}{2}}(index{:});
            elseif strcmp(lpcmnds{j}{2}{k}{1},'output')
                inps{k}=outputs{lpcmnds{j}{2}{k}{2}}(index{:});
            else
                inps{k}=[];
            end
        end
        
        outputs{lpcmnds{j}{1}}(index{:})=lpcmnds{j}{3}(inps{:});
    end
end



surf(dinputs{1},dinputs{2},outputs{2})


try
    a=[2,1,7]+[1,2];
catch
    error('it didnt work');
end








% [P{:}]=ndgrid(ranges{:});

% tic
% for i=1:100000
%     eval('a=1;');
%     %a=1;
% end
% toc
% clear a
% N=10000;
% tic
% a=zeros(N,N);
% for i=1:N;
%     for j=1:N;
%         a(i,j)=1;
%         a(i,j)=a(i,j)+i;
%     end
% end
% for i=1:N;
%     for j=1:N;
%         %a(i,j)=a(i,j)+i;
%     end
% end
% toc
