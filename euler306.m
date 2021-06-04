
N=50;
losing=false(1,N);
losing(1,1:5)=[true false false false true];
basic_winning=false(1,N);
basic_winning(1,1:5)=[false true true false false];
force_opp_win=false(1,N); % can force opponent to win
force_opp_win(1,1:5)=[true false false true true];

for n=6:N
    losing(n)=true;
    if losing(n-2)
        losing(n)=false;
    else
        for i=1:floor(n/2)
            if losing(n-i-2) && losing(i)
                losing(n)=false;
                break
            end
        end
    end
    %         if basic_winning(n-i-2) && i>0 && basic_winning(i)
    %             losing(n)=false;
    %             basic_winning(n)=true;
    %         end
    for i=1:floor(n/2)
        if ~force_opp_win(n-i-2) && ~force_opp_win(i)
            losing(n)=false;
            break
        end
    end
    if ~force_opp_win(n-2)
        force_opp_win(n)=true;
    else
        for i=1:floor(n/2)
            if (~force_opp_win(n-i-2) && losing(i)) || (losing(n-i-2) && ~force_opp_win(i))
                force_opp_win(n)=true;
                break
            end
        end
    end
end
sum(1-losing)