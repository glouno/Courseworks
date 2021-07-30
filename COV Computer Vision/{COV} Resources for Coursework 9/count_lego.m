%Gives the number of Blue 2x4 bricks (numA), and Red 2x2 bricks (numB)
%output: [numA,numB]

%{ 
This is the explanation of my method. 
I thought about solving the problem in 3 steps:
    1. Seperate the images in their Blue / Red components
    2. Run some 'shape recognition' (or maybe just intensity) to extract
    the highest values of blue / red
    3. Compare those sub-images to the reference images (using
    bagOfFeatures for example)
    4. (extra) Create 3 reference images for each brick (instead of 1)
    for the front, the side and the back. We can then compare the
    sub-images to all 3 so that the function recognizes better the shapes
    (it can't predict what the LEGO brick looks like underneath...)

Firstly, I struggled a lot because MATLAB kept crashing my computer, the
color threshold app didn't work at first. So I had to test manually to
find a good threshold and a good color space. The results in RGB weren't
great, so I tried using the colorThresholder app again; found some really
good results in LAB color space.
I created two seperate color filters (masks) in order to get just the
blue bricks and just the red bricks. Then I smoothed and filled those masks
to get a clearer final render.

After that, I managed to sub-divide the image into several images with the
individual bricks. I can have an using the binary mask in order to show just
the brick, and another one using the "boundaryBox" in order to crop the
original image and still have the background.

NOW we need to detect the bricks... and seperate the 2x4 and the 2x2 from
the rest.



Other things I wanted to implement but not enough time:
I wanted to implement BagOfWords (BagOfFeatures), but it was quite tough,
because when you think about it, the 2x4 brick is essentially just 2 2x2
bricks next to each other, so the program can recognize all of them as
2x2... I started downloading new images of LEGO bricks on the internet in
order to train the BoW model, and notably use a 1x2 brick as an 'outlier'
in order to try and avoid the algorithm saying that 2x4 is 2x2...

Using bwarea to figure out the number of red 2x2 bricks (because they're
the smallest area anyways
Use bwarea and run some edge detection to try and draw the lines of a
rectangle for the blue bricks and make sure the ratio of length/width is
around 2 (which confirms it is a rectangle, 2x4).

Resources: auto-generated code from colorThresholder app.
https://fr.mathworks.com/matlabcentral/fileexchange/26420-simplecolordetection?s_tid=srchtitle

%}

function [numA,numB]=count_lego(I)

% Convert RGB image to chosen color space
LAB = rgb2lab(I);

% BLUE BRICK        BLUE BRICK                  BLUE BRICK
% Define thresholds for channel 1 based on histogram settings
channel1MinB = 1.764;
channel1MaxB = 96.713;
% Define thresholds for channel 2 based on histogram settings
channel2MinB = 5.873;
channel2MaxB = 67.771;
% Define thresholds for channel 3 based on histogram settings
channel3MinB = -69.900;
channel3MaxB = -9.454;
% Create mask based on chosen histogram thresholds
sliderBWB = (LAB(:,:,1) >= channel1MinB ) & (LAB(:,:,1) <= channel1MaxB) & ...
    (LAB(:,:,2) >= channel2MinB ) & (LAB(:,:,2) <= channel2MaxB) & ...
    (LAB(:,:,3) >= channel3MinB ) & (LAB(:,:,3) <= channel3MaxB);
BWB = sliderBWB;
% Initialize output masked image based on input image.
maskedRGBImageB = I;
% Set background pixels where BW is false to zero.
maskedRGBImageB(repmat(~BWB,[1 1 3])) = 0;

figure(10), imagesc(maskedRGBImageB);

% Remove small pixels, Smoothing, Borders Filled
% Get rid of small objects.  Note: bwareaopen returns a logical.
smallestAcceptableArea = 1000;
blueObjectsMask = bwareaopen(BWB, smallestAcceptableArea);

% Smooth the border using a morphological closing operation, imclose().
structuringElement = strel('disk', 4);  %'disk' 4 changed to rectangle
blueObjectsMask = imclose(blueObjectsMask, structuringElement);

% Fill in any holes in the regions, since they are most likely blue also.
blueObjectsMask = imfill(blueObjectsMask, 'holes');   

% Initialize output masked image based on input image.
smoothedRGBImageB = I;
% Set background pixels where BW (blueObjectMask) is false to zero.
smoothedRGBImageB(repmat(~blueObjectsMask,[1 1 3])) = 0;
figure(11), imagesc(smoothedRGBImageB);

% EXTRACTING BLOBS FROM IMAGE
[labeledImageB, numberOfBlobsB] = bwlabel(blueObjectsMask, 8);     % Label each blob so we can make measurements of it
% Get all the blob properties.  Can only pass in originalImage in version R2008a and later.
blobBoxesB = regionprops(labeledImageB, 'area', 'BoundingBox', 'FilledImage', 'Extent', 'Image'); 

for i = 1:numberOfBlobsB
    figure(i), subplot(2,2,1), imagesc(blobBoxesB(i).FilledImage);
    subplot(2,2,2), imagesc(blobBoxesB(i).Image); %basically the same as FilledImage
    
    imageOfBlob = imcrop(smoothedRGBImageB, blobBoxesB(i).BoundingBox);
    imageOfBrick = imcrop(I, blobBoxesB(i).BoundingBox);
    %imageOfBlob(repmat(blobBoxesB(i).FilledImage,[1 1 3])) = 0; 
    %imageOfBlob = imageOfBlob .* blobBoxesB(i).FilledImage;
    subplot(2,2,3), imagesc(imageOfBlob);
    subplot(2,2,4), imagesc(imageOfBrick);
    %boxOfOne = blobBoxesB
    
end

numA = round(numberOfBlobsB/3);

% RED BRICK         RED BRICK               RED BRICK
% Define thresholds for channel 1 based on histogram settings
channel1MinR = 1.764;
channel1MaxR = 96.713;
% Define thresholds for channel 2 based on histogram settings
channel2MinR = 34.702;
channel2MaxR = 67.771;
% Define thresholds for channel 3 based on histogram settings
channel3MinR = -3.579;
channel3MaxR = 78.262;
% Create mask based on chosen histogram thresholds
sliderBWR = (LAB(:,:,1) >= channel1MinR ) & (LAB(:,:,1) <= channel1MaxR) & ...
    (LAB(:,:,2) >= channel2MinR ) & (LAB(:,:,2) <= channel2MaxR) & ...
    (LAB(:,:,3) >= channel3MinR ) & (LAB(:,:,3) <= channel3MaxR);
BWR = sliderBWR;
% Initialize output masked image based on input image.
maskedRGBImageR = I;
% Set background pixels where BW is false to zero.
maskedRGBImageR(repmat(~BWR,[1 1 3])) = 0;

figure(12), imagesc(maskedRGBImageR);

% Remove small pixels, Smoothing, Borders Filled
% Get rid of small objects.  Note: bwareaopen returns a logical.
smallestAcceptableArea = 1500;      %1500 is good to get rid of the orange bricks pointy thing
redObjectsMask = bwareaopen(BWR, smallestAcceptableArea);
% Smooth the border using a morphological closing operation, imclose().
structuringElement = strel('disk', 4);
redObjectsMask = imclose(redObjectsMask, structuringElement);
% Fill in any holes in the regions, since they are most likely red also.
redObjectsMask = imfill(redObjectsMask, 'holes');   

% Initialize output masked image based on input image.
smoothedRGBImageR = I;
% Set background pixels where BW (redObjectMask) is false to zero.
smoothedRGBImageR(repmat(~redObjectsMask,[1 1 3])) = 0;

figure(14), imagesc(smoothedRGBImageR);

% EXTRACTING BLOBS FROM IMAGE
[labeledImageR, numberOfBlobsR] = bwlabel(redObjectsMask, 8);     % Label each blob so we can make measurements of it
% Get all the blob properties.  Can only pass in originalImage in version R2008a and later.
blobBoxesR = regionprops(labeledImageR, 'area', 'BoundingBox', 'FilledImage', 'Extent', 'Image'); %smoothedRGBImageR


%% Forming Bag of Features
% Extracts SURF features from all training images &
% reducing the number of features through quantization of feature space using K-means clustering
imds = imageDatastore('myTrainingImages/Red', 'IncludeSubfolders', true);
bag = bagOfFeatures(imds);

classifier = trainImageCategoryClassifier(imds,bag);

for i = 1:numberOfBlobsR
    figure(i), subplot(2,2,1), imagesc(blobBoxesR(i).FilledImage);
    subplot(2,2,2), imagesc(blobBoxesR(i).Image); %basically the same as FilledImage
    
    imageOfBlob = imcrop(smoothedRGBImageR, blobBoxesR(i).BoundingBox);
    imageOfBrick = imcrop(I, blobBoxesR(i).BoundingBox);
    %imageOfBlob(repmat(blobBoxesB(i).FilledImage,[1 1 3])) = 0; 
    %imageOfBlob = imageOfBlob .* blobBoxesB(i).FilledImage;
    subplot(2,2,3), imagesc(imageOfBlob);
    subplot(2,2,4), imagesc(imageOfBrick);
    %boxOfOne = blobBoxesB
    areaOfRegionRectangle = blobBoxesR(i).Area;
    
    areaOfBrick = bwarea(blobBoxesB(i).FilledImage);
    areaOfBrickNOTFILLED = bwarea(blobBoxesB(i).Image);
    
    corners = detectHarrisFeatures(rgb2gray(imageOfBlob), 'MinQuality', 0.4);
    
    
    
end

numB = round(numberOfBlobsR/3);


%{ 
Use later to import 6 reference images included in the zip file AND test to
verify it works just from the zip file (make sure it's the correct
directory) 
blueFront = imread('blue_front.jpg');
blueSide = imread('blue_side.jpg');
blueBack = imread('blue_back.jpg');

redFront = imread('red_front.jpg');
redSide = imread('red_side.jpg');
redBack = imread('red_back.jpg');

%}

end

%{
Random stuff
Iblue = I(:,:,3);
Igreen = I(:,:,2); %don't really care about this one for now
Ired = I(:,:,1);

figure(1), subplot(2,2,1), imagesc(I); title('Base Image I'); colorbar;
subplot(2,2,2), imagesc(Ired); title('red channel'); colorbar;
subplot(2,2,3), imagesc(Igreen); title('green channel'); colorbar;
subplot(2,2,4), imagesc(Iblue); title('blue channel'); colorbar;
%}

%{
Notes from SimpleColorDetection

% Get rid of small objects.  Note: bwareaopen returns a logical.
	redObjectsMask = uint8(bwareaopen(redObjectsMask, smallestAcceptableArea));
	subplot(3, 3, 1);
	imshow(redObjectsMask, []);
	fontSize = 13;
	caption = sprintf('bwareaopen() removed objects\nsmaller than %d pixels', smallestAcceptableArea);
	title(caption, 'FontSize', fontSize);
	
	% Smooth the border using a morphological closing operation, imclose().
	structuringElement = strel('disk', 4);
	redObjectsMask = imclose(redObjectsMask, structuringElement);
	subplot(3, 3, 2);
	imshow(redObjectsMask, []);
	fontSize = 16;
	title('Border smoothed', 'FontSize', fontSize);
	
	% Fill in any holes in the regions, since they are most likely red also.
	redObjectsMask = uint8(imfill(redObjectsMask, 'holes'));
	subplot(3, 3, 3);
	imshow(redObjectsMask, []);
	title('Regions Filled', 'FontSize', fontSize);



	% Get all the blob properties.  Can only pass in originalImage in version R2008a and later.
	blobMeasurementsR = regionprops(labeledImage, redBand, 'area', 'MeanIntensity');
	blobMeasurementsG = regionprops(labeledImage, greenBand, 'area', 'MeanIntensity');
	blobMeasurementsB = regionprops(labeledImage, blueBand, 'area', 'MeanIntensity');
	

%}