function [offsetsRows, offsetsCols, distances] = templateMatchingIntegralImage(image, row,...
    col,patchSize, searchWindowSize)
% This function should for each possible offset in the search window
% centred at the current row and col, save a value for the offsets and
% patch distances, e.g. for the offset (-1,-1)
% offsetsX(1) = -1;
% offsetsY(1) = -1;
% distances(1) = 0.125;

% The distance is simply the SSD over patches of size patchSize between the
% 'template' patch centred at row and col and a patch shifted by the
% current offset

% This time, use the integral image method!
% NOTE: Use the 'computeIntegralImage' function developed earlier to
% calculate your integral images
% NOTE: Use the 'evaluateIntegralImage' function to calculate patch sums

%initializing the values for the return statements
%i give them the size of the search window
offsetsRows = zeros(searchWindowSize ^ 2, 1);
offsetsCols = zeros(searchWindowSize ^ 2, 1);
distances = zeros(searchWindowSize ^ 2, 1);
%counter that helps me iterate through the arrays 
counter = 0;

%handle the case of even patches
if mod(patchSize, 2) == 0
    patchSize = patchSize + 1;
end

%i use the values halved and approximated of the patchSize and
%searchWindowSize to compute the padding
patchPadding = fix(patchSize / 2);
windowPadding = fix(searchWindowSize / 2);
%pad the image to handle the borders
paddedImage = padarray(image, [windowPadding, windowPadding]);

%as in naive template matching, I initialize the offset as -hald the size
%of the window
row_offset = -windowPadding;
col_offset = -windowPadding;
%I need this to pad the integral image later on
paddingToAdd = patchPadding + 1;

%I loop through all the pixels in the integral image
for m = 1 : searchWindowSize
    for n = 1 : searchWindowSize
        
        %I find out what the shifted image is
        shiftedImage = paddedImage(m : m - 1 + size(image, 1), n : n - 1 + size(image, 2));

        %then use it to compute the integral image
        integralImage = computeIntegralImage(power(shiftedImage - image, 2));
        %here I use the previous variable to pad the integral image to
        %obtain values for the borders
        integralImage = padarray(integralImage, [paddingToAdd, paddingToAdd], 'post');
        integralImage = padarray(integralImage, [paddingToAdd, paddingToAdd], 'pre');
       
        %increment the counter
        counter = counter + 1;
        %update the arrays
        offsetsRows(counter, 1) = row_offset;
        offsetsCols(counter, 1) = col_offset;
        %calculate the distance in the patch using evaluateIntegralDistance
        distances(counter, 1) = evaluateIntegralImage(integralImage, row, col, patchSize);
        %then I update the col offset
        col_offset = col_offset + 1; 
    end
    %and also the row offset
    row_offset = row_offset + 1;
    col_offset = -windowPadding;
end
end