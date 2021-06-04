coins=[200,100,50,20,10,5,2,1];
target=200;
count=0;
list=[];
for i=0:floor(target/coins(1))
    for j=0:floor((target-coins(1)*i)/coins(2))
        for k=0:floor((target-[i,j]*coins(1:2)')/coins(3))
            for l=0:floor((target-[i,j,k]*coins(1:3)')/coins(4))
                for m=0:floor((target-[i,j,k,l]*coins(1:4)')/coins(5))
                    for n=0:floor((target-[i,j,k,l,m]*coins(1:5)')/coins(6))
                        for o=0:floor((target-[i,j,k,l,m,n]*coins(1:6)')/coins(7))
%                             for p=0:floor((target-coins(7)*o)/coins(8))
                               %p=target-[i,j,k,l,m,n,o]*coins(1:7)';
%                                 if [i,j,k,l,m,n,o,p]*coins'==target
                                    count=count+1;
                                    %list=[list;[i,j,k,l,m,n,o,p]];
%                                     break
%                                 end
%                             end
                        end
                    end
                end
            end
        end
    end
end