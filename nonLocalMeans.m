function [result] = nonLocalMeans(imageNoisy, sigma, h, patchSize, searchWindowSize)

result = imageNoisy;

for m = (1 + patchSize + searchWindowSize) : (patchSize * 2 + 1) : (size(imageNoisy, 1) - searchWindowSize - patchSize)
    for n = (1 + patchSize + searchWindowSize) : (patchSize * 2 + 1) : (size(imageNoisy, 2) - searchWindowSize - patchSize)
        %reset the sum of weights as 0 for every iteration
        sumOfWeights = 0;
        %initialize the array that will store all the patches
        patchSum = zeros([patchSize * 2 + 1, patchSize * 2 + 1]);
        %quick check with naive for debugging since integral runs a little slow
        %get the values of the offsets using template matching
        %[offsetsRows, offsetsCols, distances] = templateMatchingNaive(imageNoisy, m, n, patchSize, searchWindowSize);
        %probably not the most efficient implementation of template matching since it takes ages
        [offsetsRows, offsetsCols, distances] = templateMatchingIntegralImage(imageNoisy, m, n, patchSize, searchWindowSize);

        for p = 1 : size(offsetsRows)
            
            %update the row and col with the specific offset
            row = m + offsetsRows(p);
            col = n + offsetsCols(p);
            
            %I use the weighting formula to calculate individual weights
            weight = computeWeighting(distances(p), h, sigma);
            %then I sum them up and calculate the total weight 
            sumOfWeights = sumOfWeights + weight;
            %calculate the patch and aggregate all the patches to form the final image
            patchSum = patchSum + weight * imageNoisy(row - patchSize : row + patchSize, col - patchSize : col + patchSize);            
    
        end
        %update the result and divide by the weights sum
        result(m - patchSize: m + patchSize, n - patchSize: n + patchSize) = patchSum / sumOfWeights;    
    end
end
end