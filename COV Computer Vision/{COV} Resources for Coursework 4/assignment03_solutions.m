%%
Ia=imread('rooster.jpg');
Ib=imread('elephant.png');
Ic=imread('boxes.pgm');

% own 
Ia=im2double(rgb2gray(Ia));
Ib=im2double(Ib);
Ic=im2double(Ic);

% own
Iad=Ia;
Ibd=Ib;
Icd=Ic;

%%
box5=ones(5,5)./(5^2);
box25=ones(25,25)./(25^2);

Iabox5=conv2(Ia,box5,'same');
Iabox25=conv2(Ia,box25,'same');
Icbox5=conv2(Ic,box5,'same');
Icbox25=conv2(Ic,box25,'same');

% figure(1), clf
% subplot(2,2,1), imagesc(Iabox5), colorbar, title('rooster with 5x5 mask');
% subplot(2,2,2), imagesc(Iabox25), colorbar, title('rooster with 25x25 mask');
% subplot(2,2,3), imagesc(Icbox5), colorbar, title('boxes with 5x5 mask');
% subplot(2,2,4), imagesc(Icbox25), colorbar, title('boxes with 25x25 mask');

q1a=Iabox5(339,321)
q1b=Iabox25(339,321)
q1c=Icbox5(48,83)
q1d=Icbox25(48,83)

%%
g1=fspecial('gaussian',9,1.5);
g2=fspecial('gaussian',60,10);
Iag1=conv2(Ia,g1,'same');
Iag2=conv2(Ia,g2,'same');
Icg1=conv2(Ic,g1,'same');
Icg2=conv2(Ic,g2,'same');
% figure(2), clf
% subplot(2,2,1), imagesc(Iag1), colorbar, title('rooster with 1.5 Gaussian mask');
% subplot(2,2,2), imagesc(Iag2), colorbar, title('rooster with 10 Gaussian mask');
% subplot(2,2,3), imagesc(Icg1), colorbar, title('boxes with 1.5 Gaussian mask');
% subplot(2,2,4), imagesc(Icg2), colorbar, title('boxes with 10 Gaussian mask');

q2a=Iag1(338,39)
q2b=Iag2(338,39)
q2c=Icg1(37,48)
q2d=Icg2(37,48)

%%
Ibdiffy=conv2(Ibd,[-1;1],'valid');
% figure(3), clf, imagesc(Ibdiffy); colormap('gray'); colorbar;
Ibdiffx=conv2(Ibd,[-1,1],'valid');
% figure(4), clf, imagesc(Ibdiffx); colormap('gray'); colorbar;

q3a=Ibdiffy(427,78)
q3b=Ibdiffx(427,78)
q3c=Ibdiffy(244,373)
q3d=Ibdiffx(244,373)

%%
laplacian=[-0.125,-0.125,-0.125;-0.125,1,-0.125;-0.125,-0.125,-0.125];
Ialap=conv2(Ia,laplacian,'same');
Iclap=conv2(Ic,laplacian,'same');
% figure(5), clf, imagesc(Ialap), axis('equal','tight'); colormap('gray'); colorbar
% figure(6), clf, imagesc(Iclap), axis('equal','tight'); colormap('gray'); colorbar

q4a=Iclap(22,41)
q4b=Iclap(22,42)
q4c=Iclap(22,43)
q4d=Iclap(22,44)
q4e=Iclap(22,45)

%%
% figure(7), clf
g=fspecial('gaussian',15,2.5);
dgx=conv2(g,[-1,1],'valid');
dgy=conv2(g,[-1;1],'valid');
% subplot(2,2,1), mesh(dgx);colormap('jet');
% subplot(2,2,2), mesh(dgy);colormap('jet');
Icdgx=conv2(Ic,dgx,'same');
Icdgy=conv2(Ic,dgy,'same');
% subplot(2,2,3), imagesc(Icdgx); colormap('jet'), axis('equal','tight'); colorbar
% subplot(2,2,4), imagesc(Icdgy); colormap('jet'), axis('equal','tight'); colorbar
% figure(8), clf
Icdg=sqrt(Icdgx.^2+Icdgy.^2);
% imagesc(Icdg),colormap('gray'); axis('equal'); colorbar

q5a=Icdgx(22,41)
q5b=Icdgx(22,42)
q5c=Icdgx(22,43)
q5d=Icdgx(22,44)
q5e=Icdgx(22,45)

%%
figure(9), clf
g1=fspecial('gaussian',13,1.5);
g2=fspecial('gaussian',41,5);
g1l=conv2(g1,laplacian,'valid');
g2l=conv2(g2,laplacian,'valid');
subplot(2,2,1),mesh(g1l)
subplot(2,2,2),mesh(g2l)
Icg1l=conv2(Ic,g1l,'same');
Icg2l=conv2(Ic,g2l,'same');
subplot(2,2,3), imagesc(Icg1l), axis('equal','tight'), colorbar
subplot(2,2,4), imagesc(Icg2l), axis('equal','tight'), colorbar
colormap('jet');
figure(10), clf
Iag1l=conv2(Ia,g1l,'same');
Iag2l=conv2(Ia,g2l,'same');
subplot(1,2,1),imagesc(Iag1l),axis('equal','tight'),colorbar
subplot(1,2,2),imagesc(Iag2l),axis('equal','tight'),colorbar
colormap('jet')

q6a=Icg2l(22,41)
q6b=Icg2l(22,42)
q6c=Icg2l(22,43)
q6d=Icg2l(22,44)
q6e=Icg2l(22,45)

%%
figure(11), clf
g=fspecial('gaussian',9,1.5);
IpyrG=Ia;
subplot(2,2,1),imagesc(IpyrG); axis('equal','tight'),colorbar
for i=2:4
   IpyrG=imresize(conv2(IpyrG,g,'same'), 0.5, 'nearest');
   subplot(2,2,i),imagesc(IpyrG); axis('equal','tight'), colorbar
end

q7a=IpyrG(14,17)
q7b=IpyrG(8,21)

%%
figure(12), clf
g=fspecial('gaussian',9,1.5);
IpyrG=Ia;
for i=1:4
   IpyrGsmooth=conv2(IpyrG,g,'same');
   IpyrL=IpyrG-IpyrGsmooth;
   subplot(2,2,i),imagesc(IpyrL); axis('equal','tight'),colorbar
   IpyrG=imresize(IpyrGsmooth, 0.5, 'nearest');
end

q8a=IpyrL(5,12)
q8b=IpyrL(10,10)
