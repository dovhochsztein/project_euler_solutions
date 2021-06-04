classdef sudoku < handle
    properties (SetObservable)
        board=zeros(9,9);
        possible_values=cell(9,9);
        possible_value_sizes=zeros(9,9);
        known_wrong_values=cell(9,9);
    end
    properties
        universe=[1:9];
        %quadrant=@(i,j) board(i-mod(i-1,3):i-mod(i-1,3)+2:j-mod(j-1,3):j-mod(j-1,3)+2);
    end
    methods %(Static)
        function obj = sudoku(board)
            if nargin > 0
                if size(board)==[9,9]
                    obj.board = board;
                else
                    error('Board must be 9 x 9')
                end
            end
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

        function output=check_legality(obj)
            output=true;
            for i=1:9
                p=nonzeros(obj.board(i,:));
                if length(p)~=length(unique(p))
                    output=false;
                    return
                end
            end
            for i=1:9
                p=nonzeros(obj.board(i,:));
                if length(p)~=length(unique(p))
                    output=false;
                    return
                end
            end  
            for i=1:3
                for j=1:3
                    p=nonzeros(obj.board(3*i-2:3*i,3*j-2:3*j));
                    if length(p)~=length(unique(p))
                        output=false;
                        return
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
        function guess(obj,i,j,n)
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