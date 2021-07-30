%Gives the positions of points in image I2 that match the points pos1 in image I1

%{ 
This is the explanation of my method. 
I used the MATLAB example for the matchFeature function. I added two 'for' loops to make sure pos1 and pos2 are the same size and that
all the matching points detected are in pos2 (aligned correctly with pos1).
Once I get all the 'true' matching points from HarrisFeature, I use
interpolation to find the rest of the points.
I use estimateGeometricTransform2D to generate a Transform (essentially a
vector of the translation, except it's a 3x3 matrix) which I feed back into
transformPointsForward in order to generate the estimates of pos2 that
weren't found using 'true' matching.

After submitting a first version of this Coursework, I realised that Harris
is NOT 'scale independent' contrary to SURF and other feature detection
methods. 

Resources: https://uk.mathworks.com/help/vision/ref/matchfeatures.html
https://www.mathworks.com/help/vision/ref/estimategeometrictransform2d.html
https://www.mathworks.com/help/images/ref/affine2d.transformpointsinverse.html
%}

function [pos2] = find_matches(I1, pos1, I2)

I1 = rgb2gray(I1);
I2 = rgb2gray(I2);

points1 = detectHarrisFeatures(I1);
points2 = detectHarrisFeatures(I2);

[features1,valid_points1] = extractFeatures(I1,points1);
[features2,valid_points2] = extractFeatures(I2,points2);

indexPairs = matchFeatures(features1,features2);

matchedPoints1 = valid_points1(indexPairs(:,1),:);  %gets rid of most validpoints, only keeps matching index pairs
matchedPoints2 = valid_points2(indexPairs(:,2),:);

figure('Name','matchedPoints'); showMatchedFeatures(I1,I2,matchedPoints1,matchedPoints2);


pos2 = zeros(size(pos1,1),2);    %preallocate the size of pos2 to avoid changing it every iteration


for i = 1:size(pos1, 1)     %gets the number of rows in pos1
    for j = 1:size(matchedPoints1.Location, 1)      %goes through all the matched Points
        if pos1(i,[1,2])==matchedPoints1.Location(j,[1,2])   %pos1 is the input, matchedPoints1 is the point detected and matched by the code
            pos2(i,[1,2])=matchedPoints2.Location(j,[1,2]);  %the .Location is because cornerPoints is an object and we need to go inside to get the Location
            break       %to avoid continuing the loop for no reason after matching point has been found
            
        end
    end
end

%section to add interpolation for points that are not in matchedPoints1
[tform,inlierIndex] = estimateGeometricTransform2D(matchedPoints1,matchedPoints2,'affine');
%we don't use the inlierIndex because pos1 is given and we have to find
%values for it, even if they don't fit the model...
estimatePos2 = transformPointsForward(tform, pos1);

for i = 1:size(pos2,1)
    if pos2(i,[1,2])==[0,0]    %if the points are not in matchedPoints, we estimate
        pos2(i,[1,2]) = estimatePos2(i,[1,2]);
    end
end

%testing which transform to use:
figure('Name','pos1,pos2 OUTPUT'); showMatchedFeatures(I1,I2,pos1,pos2);
figure('Name','pos1,estimatepos2 ESTIMATE'); showMatchedFeatures(I1,I2,pos1,estimatePos2);




