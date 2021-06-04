D=4;
rolls=[2:2*D];
props=[[1:D],[D-1:-1:1]]/D^2;

chance=[7,22,36];
CC=[2,18,33];
util=[];
doubles=(1/D);
P(1,:)=ones(1,40)/40;

%P(2,:)=P(1,:);




N=100;
for i=2:N
    %adjust for 3 doubles
    new=zeros(1,40);
    for j=1:40
        new(j)=sum(P(i-1,mod(j-rolls-1,40)+1).*props);
    end
    new=new*(1-doubles^3);
    new(10)=new(10)+doubles^3;
    %adjust for square effect
    P(i,:)=zeros(1,40);
    for j=1:40
        P(i,j)=new(j);
        if j==40 % GO
            P(i,j)=P(i,j)+1/16*sum(new(chance))+1/16*sum(new(CC));
        end
        if any(j==chance)
            P(i,j)=P(i,j)*6/16;
        end
        if any(j==CC)
            P(i,j)=P(i,j)*14/16;
        end
        if j==5 % Reading
            P(i,j)=P(i,j)+1/16*sum(new(chance))+2/16*new(36);
        end
        if j==11 % St. Charles
            P(i,j)=P(i,j)+1/16*sum(new(chance));
        end
        if j==12 % Elect.
            P(i,j)=P(i,j)+1/16*(new(7)+new(36));
        end
        if j==15 % Penn
            P(i,j)=P(i,j)+2/16*new(7);
        end
        if j==24 % Illinois
            P(i,j)=P(i,j)+1/16*sum(new(chance));
        end
        if j==25 % B&O
            P(i,j)=P(i,j)+2/16*new(22);
        end
        if j==28 % WW
            P(i,j)=P(i,j)+1/16*new(22);
        end
        if j==39 % Boardwalk
            P(i,j)=P(i,j)+1/16*sum(new(chance));
        end
        if any(j==(chance-3)) % move back 3
            P(i,j)=P(i,j)+1/16*new(j+3);
        end
        if j==30 %G2J
            P(i,j)=0;
        end
        if j==10 % Jail
            P(i,j)=P(i,j)+new(30)+1/16*sum(new(chance))+1/16*sum(new(CC));
        end
    end
    %adjust for move back 3 to CC
    %probability of landing on 33 without reading the card:
    P33=1/16*new(36);
    P(i,40)=P(i,40)+P33*1/16;
    P(i,10)=P(i,10)+P33*1/16;
    P(i,33)=P(i,33)-P33*2/16;
    
    
    
    
    sum(new);
    sum(P(i,:))
    sum(abs(P(i,:)-P(i-1,:)))
end


probs=P(end,:);
order=sort(probs);
[find(probs==order(40)),order(40)
find(probs==order(39)),order(39)
find(probs==order(38)),order(38)]