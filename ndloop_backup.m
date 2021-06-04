function varargout = ndloop(ranges,inputs,dinputs,lpcmnds)
%NDLOOP Constructs an N dimensional loop for a given set of ranges, static
% inputs, dimsional inputs, and commands.
%
% [X1,X2,X3,...] = NDLOOP(ranges,inputs, dinputs,lpcmnds) returns outputs
% X1,X2,X3...
% X = NDLOOP(ranges,inputs,dinputs,lpcmnds) returns the outputs in a cell
% array
%
% ranges: Should be a cell array of index vectors. If these contain only
% integers, then the loop will run on those indices.
% If a scalar is given instead of a vector, the range will automatically be
% set to [1:k] for the scalar k (which will be rounded if k is not a 
% If any entry contains nonintegers, it will be replaced with [1:k] for a
% range with k values
% So to get a loop i=1:5, j=2:4, k=1:3, set ranges = {[1:5],[2:4],[1:3]}
%
% inputs: Should be a cell array of all required variables that are used the
% same way for each iteration of the loop. If there are none, set inputs={}
% so if the variables a,b, and c are previously defined and necessary,
% set inputs={a,b,c}.
%
% dinputs (dimensional inputs): Should be a cell array of all inputs that
% are n dimensional matrices of sizes that correspond to ranges and is
% intended to be looped through. These should generally be constructed
% using ndgrid. If there are none, set dinputs={}
%
% lpcmnds: should be a an Lx3 (L commands) cell array with each row
% containing:
% 1: An integer representing the index of the output that is being
% addressed
% 2: A cell array detailing the necessary parameters, in the order they are
% used in the subsequent function handle definition
% So to accomplish the command P=X^2+Y^2+Z^2+1 where X is dinput 1, Y is
% dinput 2 and Z is output 1, this cell array should be:
% {{'dinput',1},{'dinput',2},{'output',1}}
% 3: The command written as a function handle of all necessary inputs,
% matching the order in the previous cell array
% so to accomplish the command P=X^2+Y^2+Z^2+1, the function handle should
% be @(X,Y,Z) X^2+Y^2+Z^2+1
% 
% 
% Example: To generate two meshes, A and B that follow the following
% formulae and in the following X,Y intervals:
% A = inp1 * X + inp2 * Y
% B = inp2 * X + inp1 * Y + A
% X in [1,2...50]
% Y in [1,2...40]
%
% Example Code:
% ranges = {[1:50],[1:40]};
% inp1=1;
% inp2=2;
% inputs={inp1,inp2};
% [dinputs{1:N}]=ndgrid(ranges{:});
% lpcmnds={1,{{'input',1},{'input',2},{'dinput',1},{'dinput',2}},@(a,b,c,d) a*c + b*d;...
%          2,{{'input',1},{'input',2},{'dinput',1},{'dinput',2},{'output',1}},@(a,b,c,d,e) b*c + a*d+e};
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
    if lpcmnd_size(2)~=3
        error('lpcmnd error: improperly constructed')
    end
catch
    error('lpcmnd error: improperly constructed')
end

% M=length(lpcmnds);

for i=1:M
    output_num(i)=lpcmnds{i,1};
end
output_num=[lpcmnds{:,1}];

% check size of all dinputs:
for i=1:length(dinputs)
    if ~isequal(size(dinputs{i}),ks)
        msg=horzcat('dinputs Not Sized Properly. All dinputs should be of size: ',num2str(ks(1)));
        if N>=2
            for j=2:N
                msg=horzcat(msg,' x ',num2str(ks(j)));
            end
        end
        error(msg);
    end
end

%check lpcmnds:
if ~all(floor(output_num)==output_num)
    error('lpcmnd error: invalid output number')
end

%check lpcmnd order:
for i=1:M
    for j=1:length(lpcmnds{i,2})
        if strcmp(lpcmnds{i,2}{j}{1},'output') & ~any(lpcmnds{i,2}{j}{2}==output_num(1:M-1))
            error(horzcat('lpcmnd error:  output used prematurely on loopcommand ',num2str(i),', entry ',num2str(j)));
        end
    end
end




% indices=combvec(ranges{:});
indices=num2cell(combvec(index_ranges{:}));

varargout=cell(1,max(output_num));
for I=1:length(indices)
    %     index=num2cell(indices(:,I));
    index=indices(:,I);
    for j=1:M
        inps=cell(1,length(lpcmnds{j,2}));
        for k=1:length(lpcmnds{j,2})
            if strcmp(lpcmnds{j,2}{k}{1},'input')
                try
                    inps{k}=inputs{lpcmnds{j,2}{k}{2}};
                catch
                    error(horzcat('lpcmnd error:  indexing issue on loopcommand ',num2str(j),', entry ',num2str(k)));
                end
            elseif strcmp(lpcmnds{j,2}{k}{1},'dinput')
                try
                    inps{k}=dinputs{lpcmnds{j,2}{k}{2}}(index{:});
                catch
                    error(horzcat('lpcmnd error:  indexing issue on loopcommand ',num2str(j),', entry ',num2str(k)));
                end
            elseif strcmp(lpcmnds{j,2}{k}{1},'output')
                try
                    inps{k}=varargout{lpcmnds{j,2}{k}{2}}(index{:});
                catch
                    error(horzcat('lpcmnd error:  indexing issue on loopcommand ',num2str(j),', entry ',num2str(k)));
                end
            else
                error("lpcmnd error: parameter names need to be 'input,' 'dinput' or 'output' ")
            end
        end
        
        varargout{lpcmnds{j,1}}(index{:})=lpcmnds{j,3}(inps{:});
    end
end


end



