%% Some parameters to set - make sure that your code works at image borders!
patchSize = 8;
h = 1.0; %decay parameter
searchWindowSize = 10;

%TODO - Read an image (note that we provide you with smaller ones for
%debug in the subfolder 'debug' int the 'image' folder);
%Also unless you are feeling adventurous, stick with non-colour
%images for now.
%NOTE: for each image, please also read its CORRESPONDING 'clean' or
%reference image. We will need this later to do some analysis
%NOTE2: the noise level is different for each image (it is 20, 10, and 5 as
%indicated in the image file names)

%REPLACE THIS
imageNoisy = im2double(imread('images/debug/townNoisy_sigma5.png'));
imageReference = im2double(imread('images/debug/townReference.png'));
%I set sigma as the standard deviation of a matrix element
sigma = std2(imageNoisy); % standard deviation (different for each image!)

tic;
%TODO - Implement the non-local means function
%filtered = nonLocalMeans(imageNoisy, sigma, h, patchSize, searchWindowSize);
%I run NLM on each separate channel, then I concatenate the three to obtain
%a filtered RGB image
redChannel = nonLocalMeans(imageNoisy(:,:,1), sigma, h, patchSize, searchWindowSize);
greenChannel = nonLocalMeans(imageNoisy(:,:,2), sigma, h, patchSize, searchWindowSize);
blueChannel = nonLocalMeans(imageNoisy(:,:,3), sigma, h, patchSize, searchWindowSize);
filtered = cat(3, redChannel, greenChannel, blueChannel) ;
toc

%% Let's show your results!

diff_image = abs(imageReference - filtered);

%Show filtered and difference images
subplot(1,2,1), imshow(filtered), title('NL-Means Denoised Image');
subplot(1,2,2), imshow(diff_image ./ max(max((diff_image)))), title('Difference Image');

%Print some statistics ((Peak) Signal-To-Noise Ratio)
disp('For Noisy Input');
[peakSNR, SNR] = psnr(imageNoisy, imageReference);
disp(['SNR: ', num2str(SNR, 10), '; PSNR: ', num2str(peakSNR, 10)]);

disp('For Denoised Result');
[peakSNR, SNR] = psnr(filtered, imageReference);
disp(['SNR: ', num2str(SNR, 10), '; PSNR: ', num2str(peakSNR, 10)]);

%Feel free (if you like only :)) to use some other metrics (Root
%Mean-Square Error (RMSE), Structural Similarity Index (SSI) etc.)