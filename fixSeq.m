function [seqFix, nextState] = fixSeq(input, curState)
input = char(input);
curState = char(curState);
i = str2double(curState(2));
i2 = str2double(curState(4));
k = str2double(input(end));

seqFix = string([]);

if input(2) == 'n'
    if input(end) == '4'
        if i2 == 0
            seqFix = [seqFix, input];
        else
            seqFix = [seqFix, "off4", input];
        end
        nextState = "L"+curState(2)+"L1";
    elseif i<k
        for p=i+1:k
            seqFix = [seqFix, "on"+string(p)];
        end
        nextState = "L"+string(k)+curState(3:4);
    elseif i>=k
        for p=k:i
            seqFix = ["off"+string(p), seqFix];
        end
        seqFix = [seqFix, "on"+string(k)];
        nextState = "L"+string(k)+curState(3:4);
    end
elseif input(2) == 'f'
    if input(end) == '4'
        if i2 == 1
            seqFix = [seqFix, input];
        else
            seqFix = [seqFix, "on4", input];
        end
        nextState = "L"+curState(2)+"L0";
    elseif i<k
        for p=i+1:k
            seqFix = [seqFix, "on"+string(p)];
        end
        seqFix = [seqFix, "off"+string(k)];
        nextState = "L"+string(k-1)+curState(3:4);
    elseif i>=k
        for p=k:i
            seqFix = ["off"+string(p), seqFix];
        end
        nextState = "L"+string(k-1)+curState(3:4);
    end
else
    disp("!!!error in fixer!!!")
end
end

