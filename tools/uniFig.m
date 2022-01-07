function uniFig(fig_path)
%UNIFIG adapts figure for papers
%   recolors the figure to suit acadamic papers

%% CONSTANTS

% base colors
c_white = [1, 1, 1];
c_black = [0, 0, 0];
c_lightgrey = [0.5, 0.5, 0.5];

% colors for lines
c_red =     [1, 0, 0];
c_orange =  [1.00, 0.4, 0.16];
c_blue =    [0.07, 0.62, 1.00];
c_green =   [0.39, 0.83, 0.07];
c_violet =  [0.72, 0.27, 1.00];

% line color scheme
c_line = {c_blue, c_red, c_green, c_violet, c_orange};

%% variables
color = 1;

%% subfunctions
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

    object.Title.Color = c_black;
    
end

function line(object)

    object.Color = c_line{color};

    % select next color, avoid indexing out range
    color = mod(color,length(c_line)) + 1;

end

function panel(object)

    object.BackgroundColor = c_white;

end

function legend(object)

    object.EdgeColor = c_black;
    object.TextColor = c_black;
    object.Color = c_white;

end

% recursive function called for each object
function inspect_child(object)
    obj_class = class(object);

    if strcmp(obj_class, 'matlab.ui.Figure')
        % None
        % maybe resize and position all legends
    elseif strcmp(obj_class, 'matlab.graphics.axis.Axes')

        % reset colormap
        color = 1;
     
        axes(object);

    elseif strcmp(obj_class, 'matlab.graphics.chart.primitive.Line')
        line(object)
    elseif strcmp(obj_class, 'matlab.graphics.primitive.Transform')
        % None
    elseif strcmp(obj_class, 'matlab.graphics.primitive.Line')
        line(object);
    elseif strcmp(obj_class, 'matlab.ui.container.Panel')
        panel(object);
    elseif strcmp(obj_class, 'matlab.graphics.illustration.Legend')
        legend(object)
    elseif strcmp(obj_class, 'matlab.ui.container.internal.UIContainer')
        % None
    elseif strcmp(obj_class, 'matlab.graphics.chart.primitive.Stair')
        line(object);
    else
        % unknown class
        warning("unknown class - " + obj_class);
    end   

    % recursive call
    if object.isprop("Children")
        child = object.Children;
        
        for i = 1:length(child)
            inspect_child(child(i));
        end
    end

end

%% LOAD FIGURE

% turn warnings off due to warnings during importing figure 
warning off

% open figure
fig = openfig(fig_path);

% turn warnings back on
warning on

% call editing function
inspect_child(fig);

% save and close
savefig(fig, fig_path);
close(fig);


end
