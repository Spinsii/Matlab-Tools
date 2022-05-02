function UF_set_DecimalSeparator(obj, exp)
    format long
    ticks = obj.TickValues;

    ticks = round(ticks / 10.^exp, 6);

    tick_cell = cell(length(ticks),1);

    for i = 1:length(tick_cell)
        tick_cell{i} = strrep(num2str(ticks(i),6),'.',',');
    end

    if strcmp(obj.Scale, 'linear')
        obj.TickLabelsMode = 'manual';
        obj.TickLabels = tick_cell;
    else
        obj.TickLabelsMode = 'auto';
    end
    
end