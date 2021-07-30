function [seg] = segment_image_simpled(I)
I = im2uint8(I);

L = imsegkmeans(I,2);
B = labeloverlay(I,L);
Bg = im2gray(B);
[~, threshold] = edge(Bg, "Roberts");
Bw = edge (Bg,"Canny",threshold*0.9);
%figure(40), imagesc(Bw)
seg = imagesc(Bw);
end