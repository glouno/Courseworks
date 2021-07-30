function [seg] = segment_image_mask90(I)
I=im2gray(I);
Idiffv=I(1:end-1,:)-I(2:end,:);
figure(10), subplot(2,2,1), imagesc(Idiffv), title('Idiffv');
Idiffh=I(:,1:end-1)-I(:,2:end);
figure(10), subplot(2,2,2), imagesc(Idiffh), title('Idiffh');
Idiff= sqrt(Idiffh(1:end-1,:).^2+Idiffv(:,1:end-1).^2);
subplot(2,2,3), imagesc(Idiff); colormap('gray'); colorbar, title('Idiff');

bw=im2bw(Idiff,0.075);
figure(11), clf, imagesc(bw); colormap('gray'); colorbar

Idiffy=conv2(I,[-1;1],'valid');
figure(12), subplot(2,2,1), imagesc(Idiffy); colormap('gray'); colorbar;
Idiffx=conv2(I,[-1,1],'valid');
figure(12), subplot(2,2,2), imagesc(Idiffx); colormap('gray'); colorbar;

laplacian=[-0.125,-0.125,-0.125;-0.125,1,-0.125;-0.125,-0.125,-0.125];
Ialap=conv2(I,laplacian,'same');
%Iclap=conv2(Ic,laplacian,'same');
subplot(2,2,3), imagesc(Ialap), colormap('gray'); colorbar
