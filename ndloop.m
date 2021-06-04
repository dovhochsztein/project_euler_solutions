function varargout = ndloop(ranges,lpcmnds,dinputs,inputs)
%NDLOOP Constructs an N dimensional loop for a given set of ranges, static
% inputs, dimsional inputs, and commands.
%
% [X1,X2,X3,...] = NDLOOP(ranges,lpcmnds,dinputs,inputs) returns outputs
% X1,X2,X3...
% X = NDLOOP(ranges,lpcmnds,dinputs,inputs) returns the outputs in a cell
% array
% NDLOOP(ranges,inputs); will still change the values of the variables
% listed in lpcmnds, but will not output them directly.
%
% ranges: Should be a cell array of index vectors. If these contain only
% integers, then the loop will run on those indices.
% If a scalar is given instead of a vector, the range will automatically be
% set to [1:k] for the scalar k (which will be rounded if k is not an
% integer).
% If any entry contains nonintegers, it will be replaced with [1:k] for a
% range with k values.
% So to get a loop that is equivalent to:
% i=1:5, j=2:4, k=1:3,
% set ranges = {[1:5],[2:4],[1:3]}
%
%
% lpcmnds: should be a an Lx3 or Lx2 (L commands) cell array with each row
% containing:
% 1: An integer representing the index of the output that is being
% addressed, or a string identifying its name (simpler).
% 2: The command written as a function handle of all necessary inputs.
% If inputs and/or dinputs are specified directly, this function handle 
% should matching the order in the inputs/dinputs cell arrays.
% so to accomplish the command P=X^2+Y^2+Z^2+1, the function handle should
% be @(X,Y,Z) X^2+Y^2+Z^2+1
% (OPTIONAL) 3 : A cell array detailing the necessary parameters, in the
% order they are used in the subsequent function handle definition.
% So to accomplish the command P=X^2+Y^2+Z^2+1 where X is dinput 1, Y is
% dinput 2 and Z is output 1, this cell array should be:
% {{'dinput',1},{'dinput',3},{'output',1}}
%
% (OPTIONAL) dinputs (dimensional inputs): Should be a cell array of all
% inputs that are intended to be looped through. These should generally be
% constructed as n dimensional matrices of sizes that correspond to ranges
% and can be done
% using NDGRID. If there are none, set dinputs={}. These can be matrices
% themselves. This is accomplished by setting the corresponding dinput to a
% CELL ARRAY of n dimensional matrices. For example, to use a 5x5
% matrix that is used differently for a 3x3x3 loop, construct the
% correponding dinput as a 5x5 cell array of 3x3x3 matrices.
% Note: if this argument is skipped, 
%
% (OPTIONAL) inputs: Should be a cell array of all required variables that are used the
% same way for each iteration of the loop. If there are none, set inputs={}
% so if the variables a,b, and c are previously defined and necessary,
% set inputs={a,b,c}. These can of any data type.
%
% Example: To generate two meshes, A and B that follow the following
% formulae and in the following X,Y intervals:
% A = inp1 * X + inp2 * Y
% B = inp2 * X + inp1 * Y + A
% X in [1,3...50]
% Y in [1,3...40]
%
% Example Code:
% ranges = {[1:50],[1:40]};
% inp1=1;
% inp2=2;
% inputs={inp1,inp2};
% [dinputs{1:N}]=ndgrid(ranges{:});
% lpcmnds={1,{{'input',1},{'input',3},{'dinput',1},{'dinput',3}},@(a,b,c,d) a*c + b*d;...
%          2,{{'input',1},{'input',3},{'dinput',1},{'dinput',3},{'output',1}},@(a,b,c,d,e) b*c + a*d+e};
% [A,B] = ndloop(ranges,inputs,dinputs,lpcmnds);
%
% To generate the ranges from a known dinput, simply use:
% ranges=num2cell(size(dinput));



N=length(ranges);
index_ranges=cell(1,N);
nums=zeros(1,N);
mins=zeros(1,N);
ks=zeros(1,N);
for i=1:N
    if isscalar(ranges{i})
        ranges{i}=[1:ranges{i}];
    end
    nums(i)=length(ranges{i});
    mins(i)=min(ranges{i});
    if all(floor(ranges{i})==ranges{i}) %all are integers
        ks(i)=max(ranges{i});
        index_ranges{i}=ranges{i};
    else
        ks(i)=nums(i);
        index_ranges{i}=[1:nums(i)];
    end
end

%lpcmnd sizing

try
    lpcmnd_size=size(lpcmnds);
    M=lpcmnd_size(1);
    if lpcmnd_size(2)~=3 & lpcmnd_size(2)~=2
        error('lpcmnd error: improperly constructed')
    end
catch
    error('lpcmnd error: improperly constructed')
end

if lpcmnd_size(2)==2
   lpcmnds=[lpcmnds,cell(M,1)]; 
end

outputs={lpcmnds{:,1}};
output_num=zeros(1,M);
output_num(1)=1;
for i=2:M
    matches=strcmp(outputs{i},{outputs{1:i-1}});
    if any(matches)
        match_indices=find(matches);
        output_num(i)=output_num(match_indices(1));
    else
        output_num(i)=max(output_num)+1;
    end
end


% generate inputs and dinputs if not specified
if ~exist('dinputs','var') | ~exist('inputs','var')
    input_list={};
    for i=1:M
        input_list=union(input_list,handle_inputs(lpcmnds{i,2}));
    end
    if ~exist('inputs','var')
        inputs=cell(2,0);
    end
    if ~exist('dinputs','var')
        dinputs=cell(2,0);
    end
    for i=1:length(input_list)
        if ~any(strcmp(input_list{i},inputs(1,:))) & ~any(strcmp(input_list{i},dinputs(1,:))) & ~any(strcmp(input_list{i},outputs(1,:)))
            try
                VAR=evalin('base',input_list{i});
            catch
                error(horzcat('lpcmnd error: variable ',input_list{i},' not specified or does not exist'));
            end
            if iscell(VAR)
                size_match=cell(1,prod(size(VAR)));
                for j=1:prod(size(VAR))
                    try
                        size_match{j} = all(size(VAR{j})==ks);
                    catch
                        size_match{j}=false;
                    end
                end
                if all(cell2mat(size_match))
                    dinputs=[dinputs,{input_list{i};VAR}];
                else
                    inputs=[inputs,{input_list{i};VAR}];
                end
            elseif isnumeric(VAR) & all(size(VAR)==ks)
                dinputs=[dinputs,{input_list{i};VAR}];
            else
                inputs=[inputs,{input_list{i};VAR}];
            end
        end
    end    
end


[~,num_dinputs]=size(dinputs);
% check size of all dinputs:
for i=1:num_dinputs
    if iscell(dinputs{2,i})
        for j=1:prod(size(dinputs{2,i}))
            if ~isequal(size(dinputs{2,i}{j}),ks)
                msg=horzcat('dinputs Not Sized Properly. All dinputs should be of size: ',num2str(ks(1)));
                if N>=2
                    for k=2:N
                        msg=horzcat(msg,' x ',num2str(ks(k)));
                    end
                end
                error(msg);
            end
        end
    else
        if ~isequal(size(dinputs{2,i}),ks)
            msg=horzcat('dinputs Not Sized Properly. All dinputs should be of size: ',num2str(ks(1)));
            if N>=2
                for k=2:N
                    msg=horzcat(msg,' x ',num2str(ks(k)));
                end
            end
            error(msg);
        end
    end
end


%check lpcmnd order, replace text with numbers:
for i=1:M
    if isempty(lpcmnds{i,3})
        lpcmnds{i,3}=handle_inputs(lpcmnds{i,2});
    end
    for j=1:length(lpcmnds{i,3})
        
        if iscell(lpcmnds{i,3}{j})
            if length(lpcmnds{i,3}{j})==2
                if strcmp(lpcmnds{i,3}{j}{1},'input')
                    lpcmnds{i,3}{j}{1}=0;
                elseif strcmp(lpcmnds{i,3}{j}{1},'dinput')
                    lpcmnds{i,3}{j}{1}=1;
                elseif strcmp(lpcmnds{i,3}{j}{1},'output')
                    lpcmnds{i,3}{j}{1}=2;
                end
            else
                error(horzcat('lpcmnd error: incorrect format on loopcommand ',num2str(i),', entry ',num2str(j)));
            end
            
        elseif ischar(lpcmnds{i,3}{j})
            if any(strcmp(lpcmnds{i,3}{j},inputs(1,:)))
                lpcmnds{i,3}{j}={0,find(strcmp(lpcmnds{i,3}{j},inputs(1,:)))};
            elseif any(strcmp(lpcmnds{i,3}{j},dinputs(1,:)))
                lpcmnds{i,3}{j}={1,find(strcmp(lpcmnds{i,3}{j},dinputs(1,:)))};
            elseif any(strcmp(lpcmnds{i,3}{j},outputs(1,:)))
                lpcmnds{i,3}{j}={2,find(strcmp(lpcmnds{i,3}{j},outputs(1,:)))};
            else
                error(horzcat('lpcmnd error: input/dinput/output does not exist on loopcommand ',num2str(i),', entry ',num2str(j)));
            end
            
        else
            error(horzcat('lpcmnd error: incorrect format on loopcommand ',num2str(i),', entry ',num2str(j)));
        end
        
        if (lpcmnds{i,3}{j}{1}==2) && ~any(lpcmnds{i,3}{j}{2}==output_num(1:M-1))
            error(horzcat('lpcmnd error: output used prematurely on loopcommand ',num2str(i),', entry ',num2str(j)));
        end
    end
end

% indices=combvec(ranges{:});
indices=num2cell(combvec(index_ranges{:}));

varargout=cell(1,max(output_num));
for i=1:M
    varargout{i}=zeros(ks);
end

for j=1:M
    for k=1:length(lpcmnds{j,3})
        if lpcmnds{j,3}{k}{1}==0
            try
                inputs{lpcmnds{j,3}{k}{2}};
            catch
                error(horzcat('lpcmnd error:  indexing issue on loopcommand ',num2str(j),', entry ',num2str(k)));
            end
        elseif lpcmnds{j,3}{k}{1}==1
            try
                dinputs{lpcmnds{j,3}{k}{2}};
            catch
                error(horzcat('lpcmnd error:  indexing issue on loopcommand ',num2str(j),', entry ',num2str(k)));
            end
        elseif lpcmnds{j,3}{k}{1}==2
            try
                varargout{lpcmnds{j,3}{k}{2}};
            catch
                error(horzcat('lpcmnd error:  indexing issue on loopcommand ',num2str(j),', entry ',num2str(k)));
            end
        else
            error("lpcmnd error: parameter names need to be 'input,' 'dinput' or 'output' ")
        end
    end
end


for I=1:size(indices,2)
    index=indices(:,I);
    for j=1:M
        inps=cell(1,length(lpcmnds{j,3}));
        for k=1:length(lpcmnds{j,3})
            if lpcmnds{j,3}{k}{1}==0
                inps{k}=inputs{2,lpcmnds{j,3}{k}{2}};
            elseif lpcmnds{j,3}{k}{1}==1
                if iscell(dinputs{2,lpcmnds{j,3}{k}{2}})
                    shape=size(dinputs{2,lpcmnds{j,3}{k}{2}});
                    inps{k}=zeros(shape);
                    for L=1:prod(shape)
                        inps{k}(L)=dinputs{2,lpcmnds{j,3}{k}{2}}{L}(index{:});
                    end
                else
                    inps{k}=dinputs{2,lpcmnds{j,3}{k}{2}}(index{:});
                end
            elseif lpcmnds{j,3}{k}{1}==2
                inps{k}=varargout{lpcmnds{j,3}{k}{2}}(index{:});
            end
        end
        varargout{output_num(j)}(index{:})=lpcmnds{j,2}(inps{:});
    end
end

for j=1:M
    assignin('base',outputs{output_num(j)},varargout{output_num(j)});
end

end