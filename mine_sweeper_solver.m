a=-[1,0,0,0,0,0,0;...
   0,0,1,0,0,1,0;...
   1,0,0,1,1,0,0;
   1,1,0,0,0,0,0];
A=mine_sweeper(a);
B=mine_sweeper([8,8]);
obj=B;
reveal(B,8,8);
reveal(B,1,8);
reveal(B,8,1);
reveal(B,1,1);
for i=1:20
simplify(B)
guess_flag(B)
guess_antiflag(B)
end