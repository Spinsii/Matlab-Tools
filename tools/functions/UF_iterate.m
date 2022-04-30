function UF_iterate(obj, call, arg)
    % if called with unnested parameter create cell for processing it later 
    if isa(call, 'char')
        call = {call};
    end

    % iterate through the object array
    for i = 1:length(obj)
        
        % for nested structs
        nobj = obj(i);
        for k = 1:length(call)
            
            % set parameter
            if k == length(call)
                nobj.(call{k}) = arg;
                break;
            end

            % move one layer deeper in the nested element
            nobj = nobj.(call{k});
        end
    end
end