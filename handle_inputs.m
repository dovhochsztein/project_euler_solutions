function A = handle_inputs(f)
f=func2str(f);
op_parent=find(f=='(');
cl_parent=find(f==')');
inp_list=f(op_parent(1)+1:cl_parent(1)-1);
inp_list=erase(inp_list,' ');
comma=find(inp_list==',');
if length(f)==0
    A={};
else
    L=length(comma);
    if L==0
        A={inp_list};
    else
        A=cell(1,length(comma)+1);
        A{1}=inp_list(1:comma(1)-1);
        A{end}=inp_list(comma(end)+1:end);
        for i=2:length(comma)
            A{i}=inp_list(comma(i-1)+1:comma(i)-1);
        end
    end
end