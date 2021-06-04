MAX=1000;
NNmax=MAX*3;
win=cell(1,NNmax);
lose=cell(1,NNmax);
A=zeros(3,7);
for i=1:7
    digs=3;
    for j=1:digs
        A(digs+1-j,i)=floor(mod(i,2^(j))/2^(j-1));
    end
end

B=zeros(2,3);
for i=1:3
    digs=2;
    for j=1:digs
        B(digs+1-j,i)=floor(mod(i,2^(j))/2^(j-1));
    end
end

for NN=1:NNmax
    for i=0:min(NN,MAX)
        for j=max(0,NN-i-MAX):min(NN-i,MAX)
            k=NN-i-j;
            config=[i;j;k];
            
            if j<i || k<j
%                 if length(lose{NN})>0 && any(all((lose{NN}==sort(config))))
%                     lose{NN}=[lose{NN},config];
%                 else
%                     win{NN}=[win{NN},config];
%                 end
            else
                
                empties=sum(config==0);
                if empties==2
                    win{NN}=[win{NN},config];
                    continue
                elseif empties==1
                    pair=config(find(config~=0));
                    if pair(2)==pair(1)
                        win{NN}=[win{NN},config];
                        continue
                    else
                        breaker=false;
                        for r=1:3
                            choice=zeros(3,1);
                            choice(find(config~=0))=B(:,r);
                            for s=1:min(config(find(choice)))
                                if length(lose{NN-sum(choice)*s})>0
                                    new=config-choice*s;
                                    if any(all((lose{sum(new)}==sort(new))))
                                        win{NN}=[win{NN},config];
                                        breaker=true;
                                        break
                                    end
                                else
                                end
                            end
                            if breaker
                                break
                            end
                        end
                        if ~breaker
                            lose{NN}=[lose{NN},config];
                        end
                    end
                else
                    if all(config==config(1))
                        win{NN}=[win{NN},config];
                    else
                        breaker=false;
                        for r=1:7
                            choice=A(:,r);
                            for s=1:min(config(find(choice)))
                                if length(lose{NN-sum(choice)*s})>0
                                    new=config-choice*s;
                                    if any(all((lose{sum(new)}==sort(new))))
                                        win{NN}=[win{NN},config];
                                        breaker=true;
                                        break
                                    end
                                end
                            end
                            if breaker
                                break
                            end
                        end
                        if ~breaker
                            lose{NN}=[lose{NN},config];
                        end
                    end
                end
            end
        end
    end
end

SUM
SUM=0;
for i=1:length(lose)
    for j=1:size(lose{i},2)
%        if all(sort(lose{i}(:,j))==lose{i}(:,j))
        SUM=SUM+sum(lose{i}(:,j));
%        end
    end
end