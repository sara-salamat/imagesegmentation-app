clc;clear;close all;
img = imread('image_0350.jpg');
imgtest = imread('image_0364.jpg');
[bwoutput , rgboutput] = createMask(imgtest);
[yellow_area_bw , yellow_area] = createMask_yellowcenter(imgtest);
bwoutput = bwareaopen(bwoutput,700);
yellow_area_bw = bwareaopen(yellow_area_bw,50);
s = regionprops(yellow_area_bw,'centroid');
centroids = cat(1,s.Centroid);
subplot(1 , 3 ,1)
imshow(imgtest)
subplot(1 , 3 ,2)
imshow(bwoutput)
hold on
plot(centroids(:,1),centroids(:,2),'b*')
hold off
subplot(1 , 3 ,3)
imshow(rgboutput)
hold on
plot(centroids(:,1),centroids(:,2),'b*')
hold off