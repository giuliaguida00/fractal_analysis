clc
close all
clear all

%name of the folder containing the image
folder='grains';
filename='Grain1-bw.jpg';
path_in=sprintf('%s/%s',folder,filename);

%reading the image
image=imread(path_in);

%imcrop open the image and allow to select by the mouse the area of
%interest = containg the grain to analyse
I0=imcrop(image);

%transforming the rgb (red green blue = coloured) image -3D matrix- into a grayscale
%image -2D matrix-- easier to process.
I0=rgb2gray(I0);

%transforming all the number in the matrix into double precision ones
I0=im2double(I0);

%BE CAREFUL!!
%if your image has a dark grain on a clear background remember to invert
%the image through the following command
I1=1-I0;

%NOISE REDUCTION
%Gauss smoothing filter
I2=imgaussfilt(I1,2);

%CONTRAST ENHANCEMENT
%Histogram equalization
% I3 = histeq(I2);
%Histogram stretching (gamma has to be calibrated)
gamma=1.0;
I3 = imadjust(I2,[min(I2(:)) max(I2(:))],[0,1],gamma);
% figure(),imshow(I1);

%BINARIZATION
%Otsu threshold
level=graythresh(I3); 
bw=im2bw(I3,level); 

%removing small (less than 1000pixel) object from the background
bw=bwareaopen(bw,2000);
%clear all the object touching the border
bw = imclearborder(bw);
%filling the voids inside the object of interest
bw = imfill(bw,'holes');

%COMPARISONS
figure()
subplot(2,3,1)
imshow(image),title('Original Image')
subplot(2,3,2)
imshow(I0),title('Cropped Grayscale Grain')
subplot(2,3,3)
imshow(I1),title('Inverted')
subplot(2,3,4)
imshow(I2),title('Noise Reduction')
subplot(2,3,5)
imshow(I3),title('Contrast Enhancement')
subplot(2,3,6)
imshow(bw),title('Binarized')


%SAVING
filename_out = 'Grain_out.jpg';
path_out=sprintf('%s/%s', folder,filename_out);
imwrite(bw,path_out)