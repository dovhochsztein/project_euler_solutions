A=sudoku;
A.board=[5,3,0,0,7,0,0,0,0;...
         6,0,0,1,9,5,0,0,0;...
         0,9,8,0,0,0,0,6,0;...
         8,0,0,0,6,0,0,0,3;...
         4,0,0,8,0,3,0,0,1;...
         7,0,0,0,2,0,0,0,6;...
         0,6,0,0,0,0,2,8,0;...
         0,0,0,4,1,9,0,0,5;...
         0,0,0,0,8,0,0,7,9];
 
H=sudoku([0,9,0,7,0,0,0,0,6;...
          0,0,0,0,2,5,8,0,0;...
          5,2,0,0,0,0,0,0,0;...
          0,0,0,5,0,0,7,6,0;...
          0,0,0,6,0,1,0,0,0;...
          0,3,1,0,0,9,0,0,0;...
          0,0,0,0,0,0,0,3,7;...
          0,0,6,4,5,0,0,0,0;...
          8,0,0,0,0,6,0,5,0]);

% update_possible_values(A);
% check_legality(A)
% 
% B(1)=sudoku(A.board);
% guess_tree(1,:)=[3,1,2];
% guess(B(1),guess_tree(1,1),guess_tree(1,2),guess_tree(1,3));
% if trivial_solve(B(1),100)
%     if check_filled(B)
%         A=sudoku(B.board);
%     else
%         B(2)=sudoku(B.board);
%     end
% else
%     A.known_wrong_values{guess_tree(1,1),guess_tree(1,2)}=[A.known_wrong_values{guess_tree(1,1),guess_tree(1,2)},guess_tree(1,3)];
% end
% check_legality(B)
% 
% 
% % input_basic_possible_values(A);
% 
% trivial_solve(A,100);
trivial_solve(H,100);
level=2;
descend=true;
H(2)=sudoku(H(1).board);


for i=1:100
    
    fprintf('Level %.0f\n',level);
    trivial_solve(H(level),100);
    if check_filled(H(level))
        H(1)=sudoku(H(level).board);
        level=1;
        break
    end
    
    if descend
        MIN=min(H(level).possible_value_sizes(:));
        if MIN==0
            fprintf('There are places where nothing goes');
            H(level-2).known_wrong_values{guess_tree(level-2,1),guess_tree(level-2,2)}=[H(level-1).known_wrong_values{guess_tree(level-2,1),guess_tree(level-2,2)},guess_tree(level-2,3)];
            level=level-2;
            descend=false;
            continue
        end
        candidates=find(H(level).possible_value_sizes==MIN);
        I=mod(candidates(1)-1,9)+1;
        J=fix(candidates(1)/9)+1;
        Val=H(level).possible_values{I,J}(1);
        %     guess_tree(level-1,:)=[4,2,4];
        %     guess_tree(level-1,:)=[8,2,1];
        %     guess_tree(level-1,:)=[8,1,2];
        %     guess_tree(level-1,:)=[8,1,9];
        %     guess_tree(level-1,:)=[8,6,7];
        %     guess_tree(level-1,:)=[6,1,6];
        guess_tree(level-1,:)=[I,J,Val];
        guess(H(level),guess_tree(level-1,1),guess_tree(level-1,2),guess_tree(level-1,3));
    end
    if trivial_solve(H(level),100)
        if check_filled(H(level))
            H(1)=sudoku(H(level).board);
            level=1;
            descend=false;
            break
        else
            H(level+1)=sudoku(H(level).board);
            level=level+1;
            descend=true;
        end
    else
        fprintf('flag');
        H(level-1).known_wrong_values{guess_tree(level-1,1),guess_tree(level-1,2)}=[H(level-1).known_wrong_values{guess_tree(level-1,1),guess_tree(level-1,2)},guess_tree(level-1,3)];
        level=level-1;
        descend=false;
    end
end