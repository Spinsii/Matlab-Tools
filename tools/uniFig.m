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

% check if subpaths are loaded
if exist('UF_lmtchng', 'file') ~= 2 || exist('UF_setRuler', 'file') ~= 2
    warning("Consider adding the subfiles of Matlab-tools to your path!");
    addpath("callbacks");
    addpath("functions");
end

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

% Callback
arg_.LimitChangeCB = @UF_lmtchng;

obj = load_figure(fig_handle);

UF_setFont(obj, arg_);
UF_setColor(obj, arg_);
UF_setLine(obj, arg_);
UF_setGrid(obj, arg_);
UF_setRuler(obj, arg_);

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
    obj.Exp = findall(handle, '-regexp', 'Tag', 'expTag_[X-Z]');
   
end