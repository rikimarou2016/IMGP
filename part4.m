clear all;
close all;
clc;

filename = uigetfile('*.bmp');

RGB = imread(filename);
A=rgb2gray(RGB);

EyePairBig = vision.CascadeObjectDetector('EyePairBig'); 

Borderbox = step(EyePairBig ,RGB);

EyeDetect = vision.CascadeObjectDetector('EyePairBig'); 
%Read the input Image
U=step(EyeDetect,RGB);




figure;
subplot(1,2,1);
imshow(RGB); 
rectangle('Position',U,'LineWidth',2,'LineStyle','-','EdgeColor','r');
title('Eyes Detection');


Eyes=imcrop(A,U);

%Radius
Rmin = 14;
Rmax = 50;

[centersDark, radiiDark] = imfindcircles(A,[Rmin Rmax],'ObjectPolarity','dark');
viscircles(centersDark, radiiDark,'Color','r');

% References
% 
% Rectangle around the eyes
% http://angeljohnsy.blogspot.com/2013/07/face-detection-matlab-code.html
% Red cercles around the pupils
% https://uk.mathworks.com/help/images/ref/imfindcircles.html








