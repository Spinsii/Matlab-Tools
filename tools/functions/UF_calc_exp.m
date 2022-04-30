function exponent = UF_calc_exp(ticks, arg)
[~, pos] = max(abs(ticks), [], 'all');

Val = ticks(pos);

Val_a = abs(Val);

exponent = 0;
if Val_a >= 1
    % numbers with positiv exponents
    while Val_a / 10.^exponent >= 10
        exponent = exponent + 1;
    end

else
    % numbers with negativ exponents
    while Val_a * 10.^-exponent < 1
        exponent = exponent - 1;
    end

end

% only multiple of 3 is allowed as exponent
if arg.ExpSI == true
    if sign(exponent) > 0
        exponent = exponent - mod(exponent,3);
    elseif sign(exponent) < 0
        if mod(abs(exponent),3) ~= 0
            exponent = exponent + mod(abs(exponent),3) - 3;
        end
    end
end

end