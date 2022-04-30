l = load("presetLayout.mat");

arg = "a";

parseArg(arg, l.arg_);

function layout = parseArg(arg, layout)
% UF_parseArg parses arguments with layout struct

keys = fieldnames(layout);

% match key

% check arguments
% support_arg = fieldnames(arg_);

% arg = false;
% arg_v = '';
% for i = 1:var_len
%     
%     if isa(argument{i}, "string") && startsWith(argument{i}, "-")
% 
%         if arg == true
%            varargout = -2;
%            error("missing option for " + argument{i-1})
%         end
% 
%         if ~any(strcmp(support_arg,argument{i}{1}(2:end)))
%             varargout = -1;
%             error("Argument " + argument{i} + " does not exist!");           
%         end
% 
%         arg_v = support_arg{ strcmp( support_arg,argument{i}{1}(2:end) ) };
%         arg = getfield(arg_, arg_v, 'para');
% 
%     elseif arg == true
% 
%         % set param
%         arg_ = setfield(arg_, arg_v, argument{i});
% 
%         arg = false;
% 
%     else
%         error("option '" + argument{i} + "' does not exist")
% 
%     end
% end


end