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