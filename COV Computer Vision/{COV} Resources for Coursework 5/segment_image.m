%I used the MATLAB documentation to learn more about edge-detection within
%MATLAB and the processing toolbox. I learned about image segmentation, the
%sobel method, canny method and fuzzy logic method.
%
% I tried so many different methods I got lost and couldn't figure out how
% to combine them to make them better. I first did some edge detection by
% shifting the image and finding the difference (like we did in Coursework
% 2) then using different masks like Gaussian and Laplacian, all of which
% were quite bad. I was trying to find a solution to second image (the
% military man with a child), because detecting him is quite hard since the
% pixels on his left arm are of a very similar color to the background. I
% tried K-means clustering, following the documentation and tutorials on
% MATLAB websites. 
%In the end I rushed to have a method that barely works.
%References: 
%https://uk.mathworks.com/discovery/edge-detection.html 
%https://uk.mathworks.com/help/images/detecting-a-cell-using-image-segmentation.html
%https://uk.mathworks.com/help/images/ref/imsegkmeans.html
%A lot of the values for wavelength etc. come from this last link

function [seg] = segment_image(I)
%This function takes a matrix in input I and outputs a matrix [seg] with
%some crude lines

L = imsegkmeans(I,2); 
B = labeloverlay(I,L); %from the MATLAB example, for colors?

wavelength = 2.^(0:5) * 3;
orientation = 0:45:135;
g = gabor(wavelength,orientation); %like gabor2 we used in Coursework

Ig = rgb2gray(im2single(B));
gabormag = imgaborfilt(Ig,g);
for i = 1:length(g)                %smooth and remove local variations?
    sigma = 0.5*g(i).Wavelength;
    gabormag(:,:,i) = imgaussfilt(gabormag(:,:,i),3*sigma); 
end



nrows = size(B,1);
ncolumns = size(B,2);
[X,Y] = meshgrid(1:ncolumns,1:nrows); %smoothing

features = cat(3,I,gabormag,X,Y);
L2 = imsegkmeans(features,2,'NormalizeInput',true);
C = labeloverlay(B,L2);
Cgray = im2gray(C);
[~, threshold] = edge(Cgray, "Roberts");
BW = edge(Cgray,"Canny",threshold*0.9);

%I tried to use erosion to get rid of some of the lines but it didn't work
%well...
%figure(20), subplot(2,2,3), imagesc(Bw), title('original Bw');
%se = offsetstrel('ball',5,5); doesn't work because not 2D?
%seline = strel('line', 3,0);
%erodedI = imerode(Bw,seline);

%figure (20), subplot(2,2,1), imagesc(erodedI), title('erodedI');
%figure(20), subplot(2,2,2), imagesc(Bw), title('Bw');

seg = imagesc(BW);

end
