% known: 1674 of first 9999 are non bouncy
% known: 4953 of first 99999 are non bouncy
% known: 12951 of first 999999 are non bouncy
N=100;

N=4;
inc=[];
dec=[];
inc=0;
dec=0;
incmod=0;
decmod=0;
overcount=0;
for N=1:100
    overcount=overcount+9+1; %9 ways inc and dec will overlap, and 1 way dec will yield 000...
    for j=0:min(9,N-1)
        gap_decs=nchoosek(N-1,j);
        num_decs=nchoosek(10,j+1);
        dec=dec+gap_decs*num_decs;
        decmod=decmod+mod(gap_decs*num_decs,1000);
    end
    for j=0:min(8,N-1)
        gap_incs=nchoosek(N-1,j);
        num_incs=nchoosek(9,j+1);
        inc=inc+gap_incs*num_incs;
        incmod=incmod+mod(gap_incs*num_incs,1000);
    end
end
% B=inc+dec-overcount;
% sum(B(1:5000))
% sum(B(5001:end))
inc+dec-overcount
incmod+decmod-overcount