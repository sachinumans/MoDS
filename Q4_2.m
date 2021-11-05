clear; clc; close all;
isl = 4;%Input Sequence Length

ranSeq = genSeq(isl);
curState = "L1L0";
Seq = string([]);
stateSeq = [curState];

for r=1:isl
    [fixed, curState] = fixSeq(ranSeq(r), curState);
    Seq = [Seq, fixed];
    stateSeq = [stateSeq; curState];
end

disp(Seq)