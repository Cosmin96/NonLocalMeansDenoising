%% Some parameters to set - make sure that your code works at image borders!

% Row and column of the pixel for which we wish to find all similar patches 
% NOTE: For this section, we pick only one patch
row = 100;
col = 100;

% Patchsize - make sure your code works for different values
patchSize = 10;

% Search window size - make sure your code works for different values
searchWindowSize = 10;


%% Implementation of work required in your basic section-------------------

% TODO - Load Image
%we load the image, convert it to grayscale and make sure to convert to double
image = im2double(rgb2gray(imread('images/debug/treesNoisy_sigma10.png')));
figure('name', 'Original Image');
%imshow();

% TODO - Fill out this function
image_ii = computeIntegralImage(image);
%normalise the image to display it
normalised_image_ii = image_ii / max(max(image_ii));

% TODO - Display the normalised Integral Image
% NOTE: This is for display only, not for template matching yet!
subplot(1,2,1), imshow(normalised_image_ii), title('Normalised Integral Image');
subplot(1,2,2), imshow(image), title('Original Image');

% TODO - Template matching for naive SSD (i.e. just loop and sum)
[offsetsRows_naive, offsetsCols_naive, distances_naive] = templateMatchingNaive(image, row, col,...
    patchSize, searchWindowSize);

% TODO - Template matching using integral images
[offsetsRows_ii, offsetsCols_ii, distances_ii] = templateMatchingIntegralImage(image, row, col,...
    patchSize, searchWindowSize);

%% Let's print out your results--------------------------------------------

% NOTE: Your results for the naive and the integral image method should be
% the same!
for i=1:length(offsetsRows_naive)
    disp(['offset rows: ', num2str(offsetsRows_naive(i)), '; offset cols: ',...
        num2str(offsetsCols_naive(i)), '; Naive Distance = ', num2str(distances_naive(i),10),...
        '; Integral Im Distance = ', num2str(distances_ii(i),10)]);
end