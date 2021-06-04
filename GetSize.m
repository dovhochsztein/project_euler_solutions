function [ bytes ] = GetSize( variable )
    props = properties(variable);
    if size(props, 1) < 1, bytes = whos(varname(variable)); bytes = bytes.bytes;
    else
        bytes = 0;
        for ii=1:length(props)
            currentProperty = getfield(variable, char(props(ii)));
            s = whos(varname(currentProperty));
            bytes = bytes + s.bytes;
        end
    end
end
function out = varname(var)
    out = inputname(1);
end