function [ranSeq] = genSeq(seqLen)
Elements = string(zeros(3,2));
for i=1:3
    Elements(i, :) = ["on"+string(i), "off"+string(i)];
end
Elements = Elements(:);

p = randperm(seqLen);
P = mod(p, size(Elements, 1));
w = P==0;
P(w) = size(Elements, 1)*ones(sum(w), 1);

ranSeq = Elements(P);

end

