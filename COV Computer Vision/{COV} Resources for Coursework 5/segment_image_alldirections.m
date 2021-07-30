function [seg] = segment_image_alldirections(I)
Ibcm=0;
for angle=0:15:179
   gA=gabor2(3,0.1,angle,0.75,90);
   gB=gabor2(3,0.1,angle,0.75,0);
   IgA=conv2(I,gA,'valid');
   IgB=conv2(I,gB,'valid');
   Ic=sqrt((IgA.^2)+(IgB.^2));
   Ibcm=max(Ibcm,Ic);
end
figure(30), clf, imagesc(Ibcm); axis('equal','tight'), colormap('gray'); colorbar