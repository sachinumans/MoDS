function [seqFix, nextState] = fixSeq(input, curState)
input = char(input);
curState = char(curState);
i = str2double(curState(end));
k = str2double(input(end));

seqFix = string([]);

if input(2) == 'n'
    if i<k
        for p=i+1:k
            seqFix = [seqFix, "on"+string(p)];
        end
    elseif i>=k
        for p=k:i
            seqFix = ["off"+string(p), seqFix];
        end
        seqFix = [seqFix, "on"+string(k)];
    end
    nextState = "L"+string(k);
elseif input(2) == 'f'
    if i<k
        for p=i+1:k
            seqFix = [seqFix, "on"+string(p)];
        end
        seqFix = [seqFix, "off"+string(k)];
    elseif i>=k
        for p=k:i
            seqFix = ["off"+string(p), seqFix];
        end
    end
    nextState = "L"+string(k-1);
else
    disp("!!!error in fixer!!!")
end
end

