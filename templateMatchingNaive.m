function [offsetsRows, offsetsCols, distances] = templateMatchingNaive(image, row, col,...
    patchSize, searchWindowSize)
% This function should for each possible offset in the search window
% centred at the current row and col, save a value for the offsets and
% patch distances, e.g. for the offset (-1,-1)
% offsetsRows(1) = -1;
% offsetsCols(1) = -1;
% distances(1) = 0.125;

% The distance is simply the SSD over patches of size patchSize between the
% 'template' patch centred at row and col and a patch shifted by the
% current offset

%initializing the values for the return statements
%i give them the size of the search window
offsetsRows = zeros(searchWindowSize ^ 2, 1);
offsetsCols = zeros(searchWindowSize ^ 2, 1);
distances = zeros(searchWindowSize ^ 2, 1);

%handle the case of even patches
if mod(patchSize, 2) == 0
    patchSize = patchSize + 1;
end

%i use the values halved and approximated of the patchSize and
%searchWindowSize to compute the padding
patchPadding = fix(patchSize / 2);
windowPadding = fix(searchWindowSize / 2);

%set the row and columns offset
row_offset = -windowPadding;
col_offset = -windowPadding;
%counter that helps me iterate through the arrays 
counter = 0;

%padding the image to handle any border issues
%I pad with both half of the patchSize and half of the window size
image = padarray(image, [patchPadding, patchPadding]); 
image = padarray(image, [windowPadding, windowPadding]); 

%using the padded image, I find the location of the patch at center and the
%template based on the paddings that I used 
patch = image(row + windowPadding : row + 2 * patchPadding + windowPadding, col + windowPadding : col + 2 * patchPadding + windowPadding);
template = image(row : row + 2 * patchPadding + 2 * windowPadding, col : col + 2 * patchPadding + 2 * windowPadding);

%after that, I iterate through all the pixels in the search window
for m = 1 + patchPadding : searchWindowSize + patchPadding
    for n = 1 + patchPadding : searchWindowSize + patchPadding
         
        %using the position of the pixels, I compute the patch at positions
        %(m,n)
        patchAtPosition = template(m - patchPadding : m + patchPadding, n - patchPadding : n + patchPadding);

        %increment the counter so that I can iterate through the arrays
        counter = counter + 1;
        %i add the values to the arrays at position counter
        offsetsRows(counter, 1) = row_offset;
        offsetsCols(counter, 1) = col_offset;
        %I also computer the SSD here for the difference between the found
        %patch and the static patch
        distances(counter, 1) = sum(sum(power(patchAtPosition - patch, 2)));
    
        %then I increase the column offset
        col_offset = col_offset + 1;
    end
    %I also increase the row offset and then decrease the col offset by the
    %window size
    row_offset = row_offset + 1;
    col_offset = -windowPadding;
end
end