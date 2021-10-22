clear; clc; close all;
isl = 10;%Input Sequence Length

ranSeq = genSeq(isl);
curState = "L1";
Seq = string([]);

for r=1:isl
    [fixed, curState] = fixSeq(ranSeq(r), curState);
    Seq = [Seq, fixed];
end

disp(Seq)