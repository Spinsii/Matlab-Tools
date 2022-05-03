function UF_setRuler(handle, arg)
    % TODO
    set_Exp(handle, arg);

end

function set_Exp(obj, arg)

    for i = 1:length(obj.Axes)
        Axis = obj.Axes(i);

        % add callback
        Axis.XAxis.LimitsChangedFcn = {arg.LimitChangeCB, arg.ExpSI, 'X'};
        Axis.YAxis.LimitsChangedFcn = {arg.LimitChangeCB, arg.ExpSI, 'Y'};
        Axis.ZAxis.LimitsChangedFcn = {arg.LimitChangeCB, arg.ExpSI, 'Z'};

        % calculate new exponent
        XExp = UF_calc_exp(Axis.XAxis.Limits, arg);
        YExp = UF_calc_exp(Axis.YAxis.Limits, arg);
            
        % remove old exponent textboxes
        delete(obj.Exp);
        
        % function for creating annotations
        annot = @(l, b, exp, fsize, font, ah, av, tag) annotation('textbox',...
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
        'Tag' , tag);

        % [left bottom width height]
        axispos = obj.Axes.Position;

        % calculate normalized points
        sizeNR = arg.FontSize / obj.Figure.Position(4);

        xl = inRange(axispos(1) + axispos(3));
        xb = inRange(axispos(2) - 2.5 * sizeNR);
        yl = inRange(axispos(1));
        yb = inRange(axispos(2) + axispos(4));

        if XExp ~= 0 && strcmp(Axis.XAxis.Scale, 'linear')
            annot(xl, xb, XExp, arg.FontSize, arg.FontName ,'right', 'top', 'expTag_X')
        end
        if YExp ~= 0 && strcmp(Axis.YAxis.Scale, 'linear')
            annot(yl, yb, YExp, arg.FontSize, arg.FontName, 'left', 'bottom' , 'expTag_Y')
        end

        % set correct seperator
        UF_set_DecimalSeparator(Axis.XAxis, XExp);
        UF_set_DecimalSeparator(Axis.YAxis, YExp);

    end

    function val = inRange(val) 
        if 1 < val
            val = 1;
        elseif val < 0
            val = 0;
        end 
    end

end