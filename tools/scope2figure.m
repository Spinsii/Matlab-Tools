function scope2figure(fig_path)
%SCOPE2FIGURE adapts scope-figure for papers
%   recolors the figure to suit acadamic papers
%   background to white
%   font to black

%% CONSTANTS

% base colors
c_white = [1 1 1];
c_black = [0 0 0];
c_lightgrey = [0.5 0.5 0.5];

% colors for lines
c_orange = [1.00 0.41 0.16];
c_blue = [0.30 0.75 0.93];
c_green = [0.47 0.67 0.19];
c_violet = [0.72 0.27 1.00];

% line color scheme
c_line = {c_blue, c_orange, c_green, c_violet};

%% LOAD FIGURE
% turn warnings off due to importing figure 
warning off

fig = openfig(fig_path, "invisible");

% turn warnings back on
warning on

%% RECOLOR
% white background
fig.Children.BackgroundColor = c_white;

% get scope count
scope_count = length(fig.Children.Children);

% iterate through subplots
for i = 1:scope_count

    subplot = fig.Children.Children(i).Children;

    % check for valid subplot
    if isempty(subplot)
        continue
    end

    % outer background white
    subplot.BackgroundColor = c_white;

    % modify axes
    subgroup = length(subplot.Children);

    % detect legend
    if subgroup == 1
        % no legend
        Axes = subplot.Children;
    elseif subgroup == 2
        % legend
        Legend = subplot.Children(1);
        Axes = subplot.Children(2);
    else
        error("new container detected");
    end

    % background
    Axes.Color = c_white;

    % grid
    Axes.XGrid = "on";
    Axes.YGrid = "on";
    Axes.ZGrid = "on";
    Axes.GridColor = c_lightgrey;

    % ruler
    Axes.XColor = c_black;
    Axes.YColor = c_black;
    Axes.ZColor = c_black;

    % title
    Axes.Title.Color = c_black;

    % legend
    if subgroup == 2
        Legend.Color = c_white; % maybe none
        Legend.TextColor = c_black;
        Legend.EdgeColor = c_black;
    end

    % lines
    lines = length(Axes.Children) / 2; % line and transform
    for j = 1:lines
        % avoid indexing out range
        j_c = mod(j-1,length(c_line)) + 1;
    
        Axes.Children(j).Color = c_line{j_c};
    end
    
end

% turn visibily on
fig.Visible = "on";

savefig(fig, fig_path);
close(fig);


end