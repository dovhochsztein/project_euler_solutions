function OutPut = BlissMult(drugfunx,x)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    OutPut = 1;
    N = length(drugfunx);
    for i = 1:N
        OutPut = OutPut * drugfunx{i}(x(i));
    end
end

