function UF_set_DecimalSeparator(obj, exp)
    ticks = obj.TickValues;

    ticks = round(ticks / 10.^exp, 5);

    tick_cell = cell(length(ticks),1);

    for i = 1:length(tick_cell)
        tick_cell{i} = strrep(num2str(ticks(i)),'.',',');
    end

    obj.TickLabelsMode = 'manual';
    obj.TickLabels = tick_cell;
end