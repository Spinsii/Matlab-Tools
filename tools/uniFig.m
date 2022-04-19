function varargout = uniFig( varargin )
%   UNIFIG generate uniform figures
%   docu
%
%      NOTE: arguments are not implementet yet
%   ARGUMENTS
%   '-s'        saves file after modifing it 
%   '-t_size'   sets the font size  (needs an additional parameter)
%
%   Copyright 2022 Lukas Pinsker

% TODO
% - fix varargin check

% check varargin
var_len = length(varargin);

fig_handle = "";
argument = {};

% check for figure handle
if var_len == 0 || startsWith(varargin{1}, "-")
    % no figure handle passed
    fig_handle = gcf;
    argument = varargin;

else
    % figure path passed
    fig_handle = openfig( varargin{1} );
    var_len = var_len - 1;

    % modify input argument to exclude figure handle
    if var_len > 0
        argument = varargin{2:end};
    end
end

%% CONSTANTS
c_black =       [0, 0, 0];
c_white =       [1, 1, 1];
c_lightgrey =   [0.5, 0.5, 0.5];

c_red =     [1, 0, 0];
c_orange =  [1.00, 0.4, 0.16];
c_blue =    [0.00, 0.45, 0.74];
c_green =   [0.39, 0.83, 0.07];
c_violet =  [0.72, 0.27, 1.00];

%% ARG STRUCT

arg_.s =            false;

% Font
arg_.Interpreter =  'latex';
arg_.FontName =     'Palatino';
arg_.FontSize =     11;
arg_.TextColor =    c_black;

% Grid
arg_.XGrid =        'on';
arg_.YGrid =        'on';
arg_.ZGrid =        'on';
arg_.AxesBox =      'on';

% Color
arg_.AxesBackgroundColor =  c_white;
arg_.AxesGridColor =        c_lightgrey;
arg_.AxesRulerColor =       c_black;
arg_.UIContainerBackgroundColor = c_white;
arg_.PanelBackgroundColor = c_white;
arg_.GridColor =    c_black;
arg_.LegendBackgroundColor = c_white;
arg_.LegendEdgeColor =  c_black;

% Ruler
arg_.ExpSI =        true;

% Line
arg_.LineSize =     1;
arg_.LineColor = {c_blue, c_red, c_green, c_violet, c_orange};

% Oversize
arg_.XOversize =    0.0;
arg_.YOversize =    0.10;
arg_.ZOversize =    0.05;

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

obj = load_figure(fig_handle);

setFont(obj, arg_);
setColor(obj, arg_);
setLine(obj, arg_);
setGrid(obj, arg_);
setRuler(obj, arg_);

end


function obj = load_figure(handle)

    obj.Axes = findobj(handle, 'Type', 'Axes');

    obj.Line = {};
    for ax = obj.Axes'
        obj.Line{end+1} = findobj(ax, 'Type', 'Line');
    end

    obj.Scatter = findobj(handle, 'Type', 'Scatter');    % TODO
    obj.UIContainer = findobj(handle, 'Type', 'UIContainer');
    obj.Panel = findobj(handle, 'Type', 'Panel');
    obj.Legend = findobj(handle, 'Type', 'Legend');
    obj.Stair = findobj(handle, 'Type', 'Stair');
    obj.Figure = findobj(handle, 'Type', 'Figure');
    obj.Exp = findall(handle, 'Tag', 'expTag');
   
end

%% SETFONT
% calls every function for formating the font
function setFont(obj, arg_)

    set_FontSize(obj, arg_);
    set_FontName(obj, arg_);
    set_FontInterpreter(obj, arg_);
    set_FontColor(obj, arg_);

end

% set FontSize
function set_FontSize(obj, arg)
    iterate(obj.Legend, 'FontSize', arg.FontSize);
    iterate(obj.Axes, 'FontSize', arg.FontSize);
    iterate(obj.Exp, 'FontSize', arg.FontSize);
end

% set FontName
function set_FontName(obj, arg)
    iterate(obj.Legend, 'FontName', arg.FontName);
    iterate(obj.Axes, 'FontName', arg.FontName);
    iterate(obj.Exp, 'FontName', arg.FontName);
    iterate(obj.Axes, {'Title','FontName'}, arg.FontName)
end

% set FontInterpreter
function set_FontInterpreter(obj, arg)
    iterate(obj.Legend, 'Interpreter', arg.Interpreter);
    iterate(obj.Axes, 'TickLabelInterpreter', arg.Interpreter);
    iterate(obj.Axes, {'Title','Interpreter'}, arg.Interpreter);
    iterate(obj.Axes, {'XAxis','Label','Interpreter'}, arg.Interpreter);
    iterate(obj.Axes, {'YAxis','Label','Interpreter'}, arg.Interpreter);
    iterate(obj.Axes, {'ZAxis','Label','Interpreter'}, arg.Interpreter);
    iterate(obj.Exp, 'Interpreter', arg.Interpreter);
end

function set_FontColor(obj, arg)
    iterate(obj.Legend, 'TextColor', arg.TextColor);
    iterate(obj.Axes, 'XColor', arg.TextColor);
    iterate(obj.Axes, 'YColor', arg.TextColor);
    iterate(obj.Axes, 'ZColor', arg.TextColor);
    iterate(obj.Axes, {'Title', 'Color'}, arg.TextColor);
    iterate(obj.Exp, 'Color', arg.TextColor);
end

%% SETCOLOR
function setColor(handle, arg)

    set_AxisColor(handle, arg);
    set_UIContainerColor(handle, arg);
    set_PanelColor(handle, arg);
    set_LegendColor(handle, arg);
    set_GridColor(handle, arg);
    
end

function set_AxisColor(obj, arg)

    iterate(obj.Axes, 'XColor', arg.AxesRulerColor);
    iterate(obj.Axes, 'YColor', arg.AxesRulerColor);
    iterate(obj.Axes, 'ZColor', arg.AxesRulerColor);

    iterate(obj.Axes, 'Color', arg.AxesBackgroundColor);
end

function set_UIContainerColor(obj, arg)
    iterate(obj.UIContainer, 'BackgroundColor', arg.UIContainerBackgroundColor)
end

function set_PanelColor(obj, arg)
    iterate(obj.Panel, 'BackgroundColor', arg.PanelBackgroundColor)
end

function set_LegendColor(obj, arg)
    iterate(obj.Legend, 'Color', arg.LegendBackgroundColor);
    iterate(obj.Legend, 'EdgeColor', arg.LegendEdgeColor);
end

function set_GridColor(obj, arg)
    iterate(obj.Axes, 'GridColor', arg.AxesGridColor);
end

%% SETGRID
function setGrid(handle, arg)

    iterate(handle.Axes, 'XGrid', arg.XGrid);
    iterate(handle.Axes, 'YGrid', arg.YGrid);
    iterate(handle.Axes, 'ZGrid', arg.ZGrid);
    iterate(handle.Axes, 'Box', arg.AxesBox)
   
   
end

%% SETLINE
function setLine(handle, arg)

    for ax_ = handle.Line
        ax = ax_{1};
        iterate(ax, 'LineWidth', arg.LineSize);

        XLim = [inf, -inf];
        YLim = [inf, -inf];
        ZLim = [inf, -inf];

        for i = 1:length(ax)
            ax(i).Color = arg.LineColor{mod(i,length(arg.LineColor))};

            XLim = MinMax(ax(i).XData, XLim);
            YLim = MinMax(ax(i).YData, YLim);
            ZLim = MinMax(ax(i).ZData, ZLim);

        end

        ax(1).Parent.XLim = setMinMax(ax(1).Parent.XLim, XLim, arg.XOversize);
        ax(1).Parent.YLim = setMinMax(ax(1).Parent.YLim, YLim, arg.YOversize);
        ax(1).Parent.ZLim = setMinMax(ax(1).Parent.ZLim, ZLim, arg.ZOversize);

    end

    % MINMAX
    function val = MinMax(data, lim)
         Min = min(data);
         Max = max(data);

         if ~isempty(data)

            if Min > lim(1)
                Min = lim(1);
            end

            if Max < lim(2)
                Max = lim(2);
            end

         else

            Min = lim(1);
            Max = lim(2);

         end

         val = [Min, Max];
    end

    % SETMINMAX
    function val = setMinMax(ax, lim, ov)

        if ~any(isinf(lim))
            diff = abs(lim(1) - lim(2));
            val =  [lim(1) - diff*ov, lim(2) + diff*ov];
        else
            % avoid inf in expression
            val = ax;
        end

    end

end

%% SETRULER
function setRuler(handle, arg)
    % TODO
    set_Exp(handle, arg);

end

function set_Exp(obj, arg)

    % calculate new exponent
    for i = 1:length(obj.Axes)
        Axis = obj.Axes(i);


        XExp = calc_exp(Axis.XAxis.Limits, arg);
        YExp = calc_exp(Axis.YAxis.Limits, arg);
            

        % remove old exponent textboxes
        delete(obj.Exp);
        
        % function for creating annotations
        annot = @(l, b, exp, fsize, font, ah, av) annotation('textbox',...
        [l, b, 0, 0],...
        'VerticalAlignment',av,...
        'HorizontalAlignment',ah,...
        'Margin',0,...
        'String',strcat('$\times10^{', num2str(exp), "}$"),...
        'FontSize',fsize,...
        'FontName',font,...
        'Interpreter','latex',...
        'EdgeColor',[0 0 0],...
        'Color',[0 0 0],...
        'Tag' , 'expTag');

        % [left bottom width height]
        axispos = obj.Axes.Position;

        % calculate normalized points
        sizeNR = arg.FontSize / obj.Figure.Position(4);

        xl = inRange(axispos(1) + axispos(3));
        xb = inRange(axispos(2) - 2.5 * sizeNR);
        yl = inRange(axispos(1));
        yb = inRange(axispos(2) + axispos(4));

        if XExp ~= 0
            annot(xl, xb, XExp, arg.FontSize, arg.FontName ,'right', 'top')
        end
        if YExp ~= 0
            annot(yl, yb, YExp, arg.FontSize, arg.FontName, 'left', 'bottom')
        end


        set_DecimalSeparator(Axis.XAxis, XExp);
        set_DecimalSeparator(Axis.YAxis, YExp);

    end


    function exponent = calc_exp(ticks, arg)
        [~, pos] = max(abs(ticks), [], 'all');

        Val = ticks(pos);

        Val_a = abs(Val);

        exponent = 0;
        if Val_a >= 1
            % numbers with positiv exponents
            while Val_a / 10.^exponent >= 10
                exponent = exponent + 1;
            end

        else
            % numbers with negativ exponents
            while Val_a * 10.^-exponent < 1
                exponent = exponent - 1;
            end

        end

        % only multiple of 3 is allowed as exponent
        if arg.ExpSI == true
            if sign(exponent) > 0
                exponent = exponent - mod(exponent,3);
            elseif sign(exponent) < 0
                exponent = exponent + mod(abs(exponent),3) - 3;
            end
        end

    end

    function val = inRange(val) 
        if 1 < val
            val = 1;
        elseif val < 0
            val = 0;
        end 
    end

end

function set_DecimalSeparator(obj, exp)
    ticks = obj.TickValues;

    ticks = ticks / 10.^exp;

    tick_cell = cell(length(ticks),1);

    for i = 1:length(tick_cell)
        tick_cell{i} = strrep(num2str(ticks(i)),'.',',');
    end

    obj.TickLabelsMode = 'manual';
    obj.TickLabels = tick_cell;
end

%% helper functions

% iterate
% applies changes to every object array member
function iterate(obj, call, arg)
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