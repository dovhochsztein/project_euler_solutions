classdef mine_sweeper < handle
    properties (SetObservable)
        board
        num_mines
        visible
        shape
        first_turn_protection=true;
    end

    methods %(Static)
        function obj = mine_sweeper(board,num_mines) % constructor
            if nargin > 0
                if ~all(size(board)==[1,2])
                    obj.board = board;
                    obj.board(obj.board~=-1)=0;
                    obj.num_mines = sum(sum(board==-1));
                    obj.shape=size(board);
                else
                    if ~exist('num_mines')
                        num_mines=floor(prod(board)/6.4);
                    end
                    obj.board = zeros(board);
                    obj.board(randperm(prod(board),num_mines))=-1;
                    obj.num_mines=num_mines;
                    obj.shape=board;
                end
                obj.visible=-1*ones(obj.shape);
                for i=1:obj.shape(1)
                    for j=1:obj.shape(2)
                        if obj.board(i,j)~=-1
                             obj.board(i,j)=sum(sum(obj.board(max(1,i-1):min(obj.shape(1),i+1),max(1,j-1):min(obj.shape(2),j+1))==-1));
                        end
                    end
                end
            end
        end

        function reset(obj)
            obj.visible=-1*ones(obj.shape);
        end
        
        function output = check_legality(obj)
            output=true;
            breaker=false;
            if sum(sum(obj.visible==10))>obj.num_mines
                output=false;
                return
            end
            for k=1:obj.shape(1)
                for r=1:obj.shape(2)
                    if obj.visible(k,r)>0 && obj.visible(k,r)<10
                        adjs=[];
                        for s=max(1,k-1):min(obj.shape(1),k+1)
                            for t=max(1,r-1):min(obj.shape(2),r+1)
                                if obj.visible(s,t)==-1
                                    minibreaker=false;
                                    adjs=[adjs,false];
                                    for u=max(1,s-1):min(obj.shape(1),s+1)
                                        for v=max(1,t-1):min(obj.shape(2),t+1)
                                            if obj.visible(u,v)==0
                                                minibreaker=true;
                                                adjs(end)=true;
                                                break
                                            end
                                        end
                                        if minibreaker
                                            break
                                        end
                                    end
                                end
                            end
                        end
                        if all(adjs)
                            breaker=true;
                            output=false;
                            break
                        end
                    end
                end
                if breaker
                    break
                end
            end
        end
        
        function output = reveal(obj,i,j) %equivalent to clicking the square
            output=true;
            if obj.board(i,j)==-1
                if obj.first_turn_protection && all(all(obj.visible==-1))
                    new_board=obj.board;
                    breaker=false;
                    for k=1:obj.shape(1)
                        for r=1:obj.shape(2)
                            if ~(k==i && r==j) && new_board(k,r)~=-1
                                new_board(k,r)=-1;
                                new_board(i,j)=0;
                                breaker=true;
                                break
                            end
                        end
                        if breaker
                            break
                        end
                    end
%                     obj=mine_sweeper(new_board);
                    obj.board = new_board;
                    obj.visible=-1*ones(obj.shape);
                    for k=1:obj.shape(1)
                        for r=1:obj.shape(2)
                            if obj.board(k,r)~=-1
                                obj.board(k,r)=sum(sum(obj.board(max(1,k-1):min(obj.shape(1),k+1),max(1,r-1):min(obj.shape(2),r+1))==-1));
                            end
                        end
                    end
                else
                    output=false;
                    error('You Lose!');
                    return
                end
                
            end
            to_reveal=[i;j];
            for k=1:100
                if isempty(to_reveal)
                    break
                end
                if obj.board(to_reveal(1,1),to_reveal(2,1))==0
                    inds1=max(1,to_reveal(1,1)-1):min(obj.shape(1),to_reveal(1,1)+1);
                    inds2=max(1,to_reveal(2,1)-1):min(obj.shape(2),to_reveal(2,1)+1);
                    inds=combvec(inds1,inds2);
                    for r=1:length(inds1)*length(inds2)
                        if obj.visible(inds(1,r),inds(2,r))==-1 && ~any(all(to_reveal==inds(:,r)))
                            to_reveal=[to_reveal,inds(:,r)];
                        end
                    end
                end
                obj.visible(to_reveal(1,1),to_reveal(2,1)) = obj.board(to_reveal(1,1),to_reveal(2,1)) - sum(sum(obj.visible(max(1,to_reveal(1,1)-1):min(obj.shape(1),to_reveal(1,1)+1),max(1,to_reveal(2,1)-1):min(obj.shape(2),to_reveal(2,1)+1))==10));
                to_reveal=to_reveal(:,2:end);
            end
        end
      
        function flag(obj,i,j) %equivalent to marking with a flag
            if any(any(obj.visible(max(1,i-1):min(obj.shape(1),i+1),max(1,j-1):min(obj.shape(2),j+1))==0))
                return
            end
            inds1=max(1,i-1):min(obj.shape(1),i+1);
            inds2=max(1,j-1):min(obj.shape(2),j+1);
            inds=combvec(inds1,inds2);
            for r=1:length(inds1)*length(inds2)
                if obj.visible(inds(1,r),inds(2,r))~=-1 && obj.visible(inds(1,r),inds(2,r))~=0 && obj.visible(inds(1,r),inds(2,r))<10
                    obj.visible(inds(1,r),inds(2,r))=obj.visible(inds(1,r),inds(2,r))-1;
                end
            end
            obj.visible(i,j)=10;
        end
        
        function antiflag(obj,i,j) % guessing that i,j is not a mine
            obj.visible(i,j)=20;
        end
        
        function counter=trivial_flag(obj) %looks for squares that are definitely mines based on an adjacent square requiring it to be so
            counter=0;
            for i=1:obj.shape(1)
                for j=1:obj.shape(2)
                    if obj.visible(i,j)~=-1 && obj.visible(i,j)~=0 && obj.visible(i,j)<10 && sum(sum(obj.visible(max(1,i-1):min(obj.shape(1),i+1),max(1,j-1):min(obj.shape(2),j+1))==-1))==obj.visible(i,j)
                        for k=max(1,i-1):min(obj.shape(1),i+1)
                            for r=max(1,j-1):min(obj.shape(2),j+1)
                                if obj.visible(k,r)==-1
                                    flag(obj,k,r);
                                    counter=counter+1;
                                end
                            end
                        end
                    end
                end
            end
        end
        
        function [output,counter]=trivial_press(obj) %looks for squares that are definitely clear based on an adjacent 0s
            counter=0;
            output=true;
            for i=1:obj.shape(1)
                for j=1:obj.shape(2)
                    if obj.visible(i,j)==0
                        for k=max(1,i-1):min(obj.shape(1),i+1)
                            for r=max(1,j-1):min(obj.shape(2),j+1)
                                if obj.visible(k,r)==-1
                                    if reveal(obj,k,r)
                                        counter=counter+1;
                                    else
                                        output=false;
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
       
        function counter=guess_flag(obj)
            counter=0;
            breaker=false;
            for i=1:obj.shape(1)
                for j=1:obj.shape(2)
                    if obj.visible(i,j)==-1
                        H=mine_sweeper(obj.board);
                        H.visible=obj.visible;
                        flag(H,i,j);
                        %trivial_flag(H);
                        if ~check_legality(H)
                            breaker=true;
                            counter=counter+1;
                        end
                    end
                    if breaker
                        break
                    end
                end
                if breaker
                    break
                end
            end
            if breaker
               reveal(obj,i,j); 
            end
        end

        function counter=guess_antiflag(obj)
            counter=0;
            breaker=false;
            for i=1:obj.shape(1)
                for j=1:obj.shape(2)
                    if obj.visible(i,j)==-1
                        H=mine_sweeper(obj.board);
                        H.visible=obj.visible;
                        antiflag(H,i,j);
                        trivial_flag(H);
                        soft_trivial_press(H);
                        if ~check_legality(H)
                            breaker=true;
                            counter=counter+1;
                        end
                    end
                    if breaker
                        break
                    end
                end
                if breaker
                    break
                end
            end
            if breaker
               flag(obj,i,j); 
            end
        end
        
        function counter=soft_trivial_press(obj) %looks for squares that are definitely clear based on an adjacent 0s
            counter=0;
            for i=1:obj.shape(1)
                for j=1:obj.shape(2)
                    if obj.visible(i,j)==0
                        for k=max(1,i-1):min(obj.shape(1),i+1)
                            for r=max(1,j-1):min(obj.shape(2),j+1)
                                if obj.visible(k,r)==-1
                                    antiflag(obj,k,r);
                                end
                            end
                        end
                    end
                end
            end
        end
        
        function counter=simplify(obj) %perform all possible operations that are 100% certain
            [output,counter1]=trivial_press(obj);
            counter2=trivial_flag(obj);
            counter=counter1+counter2;
        end
        
        
        
        
        
        
       
        function update_possible_values(obj);
            for i=1:9
                for j=1:9
                    if obj.board(i,j)==0
                    row_possibles=setdiff(obj.universe,obj.board(i,:));
                    column_possibles=setdiff(obj.universe,obj.board(:,j));
                    quadrant=obj.board(i-mod(i-1,3):i-mod(i-1,3)+2,j-mod(j-1,3):j-mod(j-1,3)+2);
                    cell_possibles=setdiff(obj.universe,quadrant(:));
                    obj.possible_values{i,j}=setdiff(intersect(row_possibles,intersect(column_possibles,cell_possibles)),obj.known_wrong_values{i,j});
                    obj.possible_value_sizes(i,j)=length(obj.possible_values{i,j});
                    else
                        obj.possible_values{i,j}=[];
                        obj.possible_value_sizes(i,j)=10;
                    end
                end
            end
        end
       
        
        function output=check_filled(obj)
            if any(obj.board(:)==0)
                output=false;
            else
                output=true;
            end
            
        end
        function counter = input_basic_possible_values(obj)
            counter=0;
            for i=1:9
                for j=1:9
                    if length(obj.possible_values{i,j})==1
                        obj.board(i,j)=obj.possible_values{i,j};
                        counter=counter+1;
                    end
                end
            end
%             if counter==0
%                 1;
%             end
        end
        function [counter,output]=input_only_possible_places(obj)
            output=true;
            counter=0;
            for i=1:9
                region=obj.possible_values(i,:);
                SET=horzcat(region{:});
                NUMs=zeros(1,9);
                for j=1:9
                    NUMs(j)=sum(SET==j);
                end
                uniques=find(NUMs==1);
                for k=1:length(uniques)
                    ind=find(SET==uniques(k));
                    for j=1:9
                        if any(region{j}==uniques(k))
                            if obj.board(i,j)==0 | obj.board(i,j)==uniques(k)
                                obj.board(i,j)=uniques(k);
                                counter=counter+1;
                                 break
                            else
                                output=false;
                            end
                        end
                    end
                end
            end
%             update_possible_values(obj);
            for j=1:9
                region=obj.possible_values(:,j);
                SET=horzcat(region{:});
                NUMs=zeros(1,9);
                for i=1:9
                    NUMs(i)=sum(SET==i);
                end
                uniques=find(NUMs==1);
                for k=1:length(uniques)
                    ind=find(SET==uniques(k));
                    for i=1:9
                        if any(region{i}==uniques(k))
                            if obj.board(i,j)==0 | obj.board(i,j)==uniques(k)
                                obj.board(i,j)=uniques(k);
                                counter=counter+1;
                                 break
                            else
                                output=false;
                            end
                        end
                    end
                end
            end
%             update_possible_values(obj);
            for I=1:3
                for J=1:3
                    region=obj.possible_values(3*I-2:3*I,3*J-2:3*J);
                    SET=horzcat(region{:});
                    NUMs=zeros(1,9);
                    for j=1:9
                        NUMs(j)=sum(SET==j);
                    end
                    uniques=find(NUMs==1);
                    for k=1:length(uniques)
                        ind=find(SET==uniques(k));
                        breaker=false;
                        for i=1:3
                            for j=1:3
                                if any(region{i,j}==uniques(k))
                                    if obj.board(3*I-3+i,3*J-3+j)==0 | obj.board(3*I-3+i,3*J-3+j)==uniques(k)
                                        obj.board(3*I-3+i,3*J-3+j)=uniques(k);
                                        counter=counter+1;
                                        breaker=true;
                                         break
                                    else
                                        output=false;
                                    end
                                end
                            end
                             if breaker
                                 break
                             end
                        end
%                         if breaker
%                             break
%                         end
                    end
                end
            end
%            update_possible_values(obj); 
        end
        
        function output=trivial_solve(obj,LIM)
            if ~exist('LIM');
                LIM=100;
            end
            output=true;
            for i=1:LIM
                output=check_legality(obj);
                if output==false
                    break
                end
                update_possible_values(obj);
                counter1=input_basic_possible_values(obj);
                update_possible_values(obj);
                counter2=input_only_possible_places(obj);
%                 output=check_legality(obj);
%                 if output==false
%                     break
%                 end
                if counter1+counter1==0
                    break
                end
            end
            %update_possible_values(obj);
        end
        function guess(obj,i,j)
            if object.board(i,j)==-1
                %lost
            end
            obj.board(i,j)=n;
%             update_possible_values(new);
        end
        function output=complex_solve(obj,LIM)
            if ~exist('LIM');
                LIM=100;
            end
            H(1)=obj;
            level=1;
            for i=1:LIM
                trivial_solve(H(level),100);
                if check_filled(H(level))
                    H(1)=sudoku(H(level).board);
                    level=1;
                    break
                end
                if check_legality(H(level))
                    MIN=min(H(level).possible_value_sizes(:));
                    if MIN==0
                        level=level-1;
                        H(level).known_wrong_values{guess_tree(level,1),guess_tree(level,2)}=[H(level).known_wrong_values{guess_tree(level,1),guess_tree(level,2)},guess_tree(level,3)];
                        continue
                    end
                    candidates=find(H(level).possible_value_sizes==MIN);
                    I=mod(candidates(1)-1,9)+1;
                    J=fix(candidates(1)/9)+1;
                    Val=H(level).possible_values{I,J}(1);
                    guess_tree(level,:)=[I,J,Val];
                    H(level+1)=sudoku(H(level).board);
                    level=level+1;
                    guess(H(level),I,J,Val);
                else
                    level=level-1;
                    H(level).known_wrong_values{guess_tree(level,1),guess_tree(level,2)}=[H(level).known_wrong_values{guess_tree(level,1),guess_tree(level,2)},guess_tree(level,3)];
                    continue
                end
            end
            H=H(1);
            obj.board=H.board;
            obj.possible_values=H.possible_values;
            obj.possible_value_sizes=H.possible_value_sizes;
            obj.known_wrong_values=H.known_wrong_values;
            output=obj.board;
        end
    end
end