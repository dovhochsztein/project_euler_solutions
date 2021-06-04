p=2;
q=3;

first=(sqrt(p)+sqrt(q))^2;
w=ceil(first);
f=w-first;
nextf=ceil(-2*w*f+f^2)-(-2*w*f+f^2);

for i=1:lim
    next=w^2-2*w*f+f^2;
    
    w=ceil(next);
    f=w-next;

