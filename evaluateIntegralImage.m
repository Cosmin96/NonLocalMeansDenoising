function [patchSum] = evaluateIntegralImage(ii, row, col, patchSize)
% This function should calculate the sum over the patch centred at row, col
% of size patchSize of the integral image ii

%calculate the 4 points of the patch
L1 = ii(row, col);
L2 = ii(row, col + patchSize);
L3 = ii(row + patchSize, col + patchSize);
L4 = ii(row + patchSize, col);

%apply formula from class to calculate the sum in constant time
patchSum = L3 - L4 - L2 + L1;
end