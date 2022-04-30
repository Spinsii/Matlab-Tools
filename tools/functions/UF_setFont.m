function UF_setFont(obj, arg_)
% UF_setFont sets font to format provided in arg_
%   helper function for UniFig

    set_FontSize(obj, arg_);
    set_FontName(obj, arg_);
    set_FontInterpreter(obj, arg_);
    set_FontColor(obj, arg_);

end

% set FontSize
function set_FontSize(obj, arg)
    UF_iterate(obj.Legend, 'FontSize', arg.FontSize);
    UF_iterate(obj.Axes, 'FontSize', arg.FontSize);
    UF_iterate(obj.Exp, 'FontSize', arg.FontSize);
end

% set FontName
function set_FontName(obj, arg)
    UF_iterate(obj.Legend, 'FontName', arg.FontName);
    UF_iterate(obj.Axes, 'FontName', arg.FontName);
    UF_iterate(obj.Exp, 'FontName', arg.FontName);
    UF_iterate(obj.Axes, {'Title','FontName'}, arg.FontName)
end

% set FontInterpreter
function set_FontInterpreter(obj, arg)
    UF_iterate(obj.Legend, 'Interpreter', arg.Interpreter);
    UF_iterate(obj.Axes, 'TickLabelInterpreter', arg.Interpreter);
    UF_iterate(obj.Axes, {'Title','Interpreter'}, arg.Interpreter);
    UF_iterate(obj.Axes, {'XAxis','Label','Interpreter'}, arg.Interpreter);
    UF_iterate(obj.Axes, {'YAxis','Label','Interpreter'}, arg.Interpreter);
    UF_iterate(obj.Axes, {'ZAxis','Label','Interpreter'}, arg.Interpreter);
    UF_iterate(obj.Exp, 'Interpreter', arg.Interpreter);
end

function set_FontColor(obj, arg)
    UF_iterate(obj.Legend, 'TextColor', arg.TextColor);
    UF_iterate(obj.Axes, 'XColor', arg.TextColor);
    UF_iterate(obj.Axes, 'YColor', arg.TextColor);
    UF_iterate(obj.Axes, 'ZColor', arg.TextColor);
    UF_iterate(obj.Axes, {'Title', 'Color'}, arg.TextColor);
    UF_iterate(obj.Exp, 'Color', arg.TextColor);
end