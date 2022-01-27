function uniFig(fig_path)
%UNIFIG adapts figure for papers
%   recolors the figure to suit acadamic papers

% issues:
% - cannot detect discrete lines
dbstop if error

%% CONSTANTS

% base colors
c_white = [1, 1, 1];
c_black = [0, 0, 0];
c_lightgrey = [0.5, 0.5, 0.5];

% colors for lines
c_red =     [1, 0, 0];
c_orange =  [1.00, 0.4, 0.16];
c_blue =    [0.00, 0.45, 0.74];
c_green =   [0.39, 0.83, 0.07];
c_violet =  [0.72, 0.27, 1.00];

% line color scheme
c_line = {c_blue, c_red, c_green, c_violet, c_orange};

XMode = "manual";
YMode = "manual";
ZMode = "manual";

% text font
font = "Palatino";

%% variables
color = 1;
XLim = [inf, -inf];
YLim = [inf, -inf];
ZLim = [inf, -inf];

% oversize range of plot in percent
XOversize = 0;
YOversize = 0.10;
ZOversize = 0.05;

axes_tab = cell(0);

%% subfunctions

function str = vec2cell(vec, exp)
        str = cell(length(vec), 1);
        for i = 1:length(vec)
            str{i} = num2str(vec(i)/power(10,double(exp)));
        end
    end

function setMinMax(object, axis)
    try
        % min value
        Min = eval("min(object." + axis + "Data);");
    
        % max value
        Max = eval("max(object." + axis + "Data);");
    
        % store min
        if ~isempty(Min)
            eval(axis + "Lim(1) = min(" + axis + "Lim(1), Min);");
        end
    
        % store max
        if ~isempty(Max)
            eval(axis + "Lim(2) = max(" + axis + "Lim(2), Max);");
        end

    catch
        % axis doesnt have that parameter
    end
end

function axes(object)

    object.Color = c_white;

    % axis color
    object.XColor = c_black;
    object.YColor = c_black;
    object.ZColor = c_black;
    
    % grid
    object.GridColor = c_lightgrey;
    object.XGrid = "on";
    object.YGrid = "on";
    object.ZGrid = "on";

    object.FontName = font;
    object.TickLabelInterpreter = "latex";
    object.Title.Color = c_black;
    object.Title.FontName = font;
    object.Title.Interpreter = "latex";
    object.XAxis.Label.Interpreter = "latex";
    object.YAxis.Label.Interpreter = "latex";
    object.ZAxis.Label.Interpreter = "latex";

    % store axes handle
    axes_tab = vertcat(axes_tab, object);
 
end

function line(object)
    object.Color = c_line{color};
    object.LineWidth = 1;

    % select next color, avoid indexing out range
    color = mod(color,length(c_line)) + 1;

    % store range of line
    setMinMax(object,"X");
    setMinMax(object,"Y");
    setMinMax(object,"Z");
end

function UIContainer(object)
    object.BackgroundColor = c_white;
end

function panel(object)
    object.BackgroundColor = c_white;
end

function legend(object)
    object.EdgeColor = c_black;
    object.TextColor = c_black;
    object.Color = c_white;
    object.FontName = font;
    object.Interpreter = "latex";
end

function setRange(object)
    % set limit for axis
    dX = XLim(2) - XLim(1);
    dY = YLim(2) - YLim(1);
    dZ = ZLim(2) - ZLim(1);

    % calculate delta size
    dX = dX * XOversize;
    dY = dY * YOversize;
    dZ = dZ * ZOversize;

    % set range
    if abs(dX) ~= inf
        object.XLim = [XLim(1) - dX, XLim(2) + dX];
    end
    if abs(dY) ~= inf
        object.YLim = [YLim(1) - dY, YLim(2) + dY];
    end
    if abs(dZ) ~= inf
        object.ZLim = [ZLim(1) - dZ, ZLim(2) + dZ];
    end

    % set range
    object.XLimMode = XMode;
    object.YLimMode = YMode;
    object.ZLimMode = ZMode;
end

% recursive function called for each object
function inspect_child(object)

    % find coresponding class and set parameters
    if isa(object, 'matlab.ui.Figure')
        % None
        % maybe resize and position all legends
    elseif isa(object, 'matlab.graphics.axis.Axes')

        % reset colormap
        color = 1;

        % reset scaling
        XLim = [inf, -inf];
        YLim = [inf, -inf];
        ZLim = [inf, -inf];
     
        axes(object);

    elseif isa(object, 'matlab.graphics.chart.primitive.Line')
        line(object)
    elseif isa(object, 'matlab.graphics.primitive.Transform')
        % None
    elseif isa(object, 'matlab.graphics.primitive.Line')
        line(object);
    elseif isa(object, 'matlab.ui.container.Panel')
        panel(object);
    elseif isa(object, 'matlab.graphics.illustration.Legend')
        legend(object)
    elseif isa(object, 'matlab.ui.container.internal.UIContainer')
        UIContainer(object)
    elseif isa(object, 'matlab.graphics.chart.primitive.Stair')
        line(object);
    else
        % unknown class
        warning("unknown class - " + class(object));
    end   

    % recursive call
    if object.isprop("Children")
        child = object.Children;

        for i = 1:length(child)
            inspect_child(child(i));
        end    
    end

    % set range of axes
    if isa(object, 'matlab.graphics.axis.Axes')
        setRange(object);
    end

end

%% LOAD FIGURE


if ~exist("fig_path")
    % use default handle
    fig = gcf;

else
    % turn warnings off due to warnings during importing figure 
    warning off
    
    % open figure
    fig = openfig(fig_path);
    
    % turn warnings back on
    warning on
end

% call editing function
inspect_child(fig);

%%%% WIP %%%%%
% % replace decimation . with ,
% for j = 1:length(axes_tab)
%     object = axes_tab(j);
% 
%     % get correct Exponent
%     object.XAxis.TickLabelsMode = 'auto';
%     object.YAxis.TickLabelsMode = 'auto';
%     object.ZAxis.TickLabelsMode = 'auto';
%     object.XAxis.ExponentMode = "auto";
%     object.YAxis.ExponentMode = "auto";
%     object.ZAxis.ExponentMode = "auto";
% 
%     % get exponent
%     expX = object.XAxis.Exponent;
%     expY = object.YAxis.Exponent;
%     expZ = object.ZAxis.Exponent;
% 
%     % set to manual mode
%     object.XAxis.TickLabelsMode = 'manual';
%     object.YAxis.TickLabelsMode = 'manual';
%     object.ZAxis.TickLabelsMode = 'manual';
% 
%     % restore exponent
%     object.XAxis.Exponent = expX;
%     object.YAxis.Exponent = expY;
%     object.ZAxis.Exponent = expZ;
% 
%     object.XAxis.TickLabels = strrep(vec2cell(object.XAxis.TickValues, expX), '.', ',');
%     object.YAxis.TickLabels = strrep(vec2cell(object.YAxis.TickValues, expY), '.', ',');
%     object.ZAxis.TickLabels = strrep(vec2cell(object.ZAxis.TickValues, expZ), '.', ',');
% 
% end

% save and close if input arg 'file_path' exists
if exist("fig_path")
    savefig(fig, fig_path);
    close(fig);
end

end
