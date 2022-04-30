function UF_setColor(handle, arg)
% setColor sets colors

    set_AxisColor(handle, arg);
    set_UIContainerColor(handle, arg);
    set_PanelColor(handle, arg);
    set_LegendColor(handle, arg);
    set_GridColor(handle, arg);
    
end

function set_AxisColor(obj, arg)

    UF_iterate(obj.Axes, 'XColor', arg.AxesRulerColor);
    UF_iterate(obj.Axes, 'YColor', arg.AxesRulerColor);
    UF_iterate(obj.Axes, 'ZColor', arg.AxesRulerColor);

    UF_iterate(obj.Axes, 'Color', arg.AxesBackgroundColor);
end

function set_UIContainerColor(obj, arg)
    UF_iterate(obj.UIContainer, 'BackgroundColor', arg.UIContainerBackgroundColor)
end

function set_PanelColor(obj, arg)
    UF_iterate(obj.Panel, 'BackgroundColor', arg.PanelBackgroundColor)
end

function set_LegendColor(obj, arg)
    UF_iterate(obj.Legend, 'Color', arg.LegendBackgroundColor);
    UF_iterate(obj.Legend, 'EdgeColor', arg.LegendEdgeColor);
end

function set_GridColor(obj, arg)
    UF_iterate(obj.Axes, 'GridColor', arg.AxesGridColor);
end