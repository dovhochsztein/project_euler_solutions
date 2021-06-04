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
 
B=sudoku([0,9,0,7,0,0,0,0,6;...
          0,0,0,0,2,5,8,0,0;...
          5,2,0,0,0,0,0,0,0;...
          0,0,0,5,0,0,7,6,0;...
          0,0,0,6,0,1,0,0,0;...
          0,3,1,0,0,9,0,0,0;...
          0,0,0,0,0,0,0,3,7;...
          0,0,6,4,5,0,0,0,0;...
          8,0,0,0,0,6,0,5,0]);
C=sudoku([0,6,0,0,0,5,1,0,9;...
          0,0,0,0,6,3,0,0,0;...
          0,0,9,0,0,0,0,7,0;...
          0,7,0,0,0,0,0,0,1;...
          0,9,0,5,7,4,0,8,0;...
          8,0,0,0,0,0,0,5,0;...
          0,3,0,0,0,0,4,0,0;...
          0,0,0,1,3,0,0,0,0;...
          9,0,8,6,0,0,0,3,0]);
raw=importdata('euler96.txt');
text=raw.textdata;


t=zeros(1,50);
SUM=0;
for i=1:50
    board=zeros(9,9);
    for j=1:9
        for k=1:9
            board(j,k)=str2num(text{10*(i-1)+1+j}(k));
        end
    end
    puzzles(i)=sudoku(board);
    tic
    complex_solve(puzzles(i));
    t(i)=toc;
    SUM=SUM+[100,10,1]*puzzles(i).board(1,1:3)';
end

% H=A;
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
% trivial_solve(H,100);

% descend=true;
%H(2)=sudoku(H(1).board);

% [counter,output]=input_only_possible_places(H)
% update_possible_values(H)

% level=1;
% for i=1:100
%     trivial_solve(H(level),100);
%     if check_filled(H(level))
%         H(1)=sudoku(H(level).board);
%         level=1;
%         break
%     end
%     if check_legality(H(level))
%         MIN=min(H(level).possible_value_sizes(:));
%         if MIN==0
%             level=level-1;
%             H(level).known_wrong_values{guess_tree(level,1),guess_tree(level,2)}=[H(level).known_wrong_values{guess_tree(level,1),guess_tree(level,2)},guess_tree(level,3)];
%             continue
%         end
%         candidates=find(H(level).possible_value_sizes==MIN);
%         I=mod(candidates(1)-1,9)+1;
%         J=fix(candidates(1)/9)+1;
%         Val=H(level).possible_values{I,J}(1);
%         guess_tree(level,:)=[I,J,Val];
%         H(level+1)=sudoku(H(level).board);
%         level=level+1;
%         guess(H(level),I,J,Val);
%     else
%         level=level-1;
%         H(level).known_wrong_values{guess_tree(level,1),guess_tree(level,2)}=[H(level).known_wrong_values{guess_tree(level,1),guess_tree(level,2)},guess_tree(level,3)];
%         continue
%     end
% end

complex_solve(A);
complex_solve(B);
complex_solve(C);
