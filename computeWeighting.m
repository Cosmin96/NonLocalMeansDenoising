function [result] = computeWeighting(d, h, sigma)
    %Implement weighting function from the slides
    %Be careful to normalise/scale correctly!
    
    %apply formula from class for calculating weight
    %weight is e to the power of - (maximum between 0 and difference of distance and 2 * sigma squared
    %over the decay parameter squared
    noiseSTD = 2 * sigma^2;
    maximum = max(d  - noiseSTD, 0);
    decay = h ^ 2;
    result = exp(-maximum / decay);
end