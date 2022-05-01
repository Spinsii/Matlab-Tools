%% UNIFIG_LIMIT_CHANGED_CALLBACK
%   callback function for reseting axis ticks when plot gets moved
%   Z-Axis is not implemented yet
function UF_lmtchng(src, ~, SI, axis)

    % axis position
    axispos = src.Parent.Position;

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

    % load exponents
    switch axis
        case 'X'
            exp_obj = findall(groot, 'Tag', 'expTag_X');

            if isempty(exp_obj)
                xl = inRange(axispos(1) + axispos(3));
                xb = inRange(axispos(2));
                annot(xl, xb, 0, 12, 'Palatino' ,'right', 'top', 'expTag_X');
                exp_obj = findall(groot, '-regexp', 'Tag', 'expTag_X');
            end
        case 'Y'
            exp_obj = findall(groot, 'Tag', 'expTag_Y');

            if isempty(exp_obj)
                yl = inRange(axispos(1));
                yb = inRange(axispos(2) + axispos(4));
                annot(yl, yb, 0, 12, 'Palatino' ,'left', 'bottom', 'expTag_Y');
                exp_obj = findall(groot, '-regexp', 'Tag', 'expTag_Y');
            end
        case 'Z'
            exp_obj = findall(groot, 'Tag', 'expTag_Z');
        otherwise
            warning("issue with callback - unknown axis in callback")
    end

    % get axis limits
    limit = src.Limits;

    % create struct for configuration
    arg.ExpSI = SI;

    % calculate exponent
    Exp = UF_calc_exp(limit, arg);

    % modify exponent
    if Exp == 0
        delete(exp_obj)
    else
        exp_obj.String = strcat('$\times10^{', num2str(Exp), '}$');
    end

    % correct axis ticks
    UF_set_DecimalSeparator(src, Exp);

end

% helper function
function val = inRange(val) 
        if 1 < val
            val = 1;
        elseif val < 0
            val = 0;
        end 
    end