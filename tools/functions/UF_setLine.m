function UF_setLine(handle, arg)

    for ax_ = handle.Line
        ax = ax_{1};
        UF_iterate(ax, 'LineWidth', arg.LineSize);

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