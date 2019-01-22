clear all;
close all;
clc;

filename = uigetfile('*.bmp');
RGB = imread(filename);

R = RGB(:,:,1);
G = RGB(:,:,2);
B = RGB(:,:,3);

M = size(RGB,1);
N = size(RGB,2);

rMin = 0;
rMax = 255;
gMin = 55;
gMax = 255;
bMin = 0;
bMax = 115;

binaryImage = R>rMin & R<rMax & G>gMin & G<gMax & B>bMin & B<bMax;%(a)


%function created to make the binary image 3 dimentional (c)
binaryImgTimeThree=uint8(binaryImage(:,:,[1 1 1]));

% the RGB image is multiplied to the binary image  (c)
C= RGB.*binaryImgTimeThree ;


%function use to erode an image
se = strel('disk',7);
D=imerode(binaryImage,se);%(d)

TransformMatrix=uint8(D(:,:,[1 1 1]));%(e)
E=RGB.*TransformMatrix;%(e)

sr=strel('disk',80);%(f)
F=imclose(D,sr);%(f)

save F F;


ChangeMatrix=uint8(F(:,:,[1 1 1]));%(g)
G=RGB.*ChangeMatrix;%(g)


I=imdilate(edge(F,'canny'), strel('disk',5'));% (i)


J = RGB;%(j)
J(:,:,1) = J(:,:,1)+uint8(I).*255;%(j)
J(:,:,2) = J(:,:,2)+uint8(I).*255;%(j)


figure;
subplot(2,5,1);
imshow(binaryImage);
title('(a)');

subplot(2,5,2);
RCount= imhist (RGB(:,:,1));
GCount= imhist (RGB(:,:,2));
BCount= imhist (RGB(:,:,3));

%Plot red line 
plot( (0:255) ,RCount,'r');hold on ;
plot([0,0],[0,600000],'r:');
plot([255,255],[0,600000],'r:');
%Plot green line 
plot( (0:255) ,GCount,'g');
plot([55,55],[0,600000],'g:');
plot([255,255],[0,600000],'g:');
%Plot blue line 
plot( (0:255) ,BCount,'b');
plot([0,0],[0,600000],'b:');
plot([115,115],[0,600000],'b:');

xlabel ('Luminance','Fontsize', 14 );
ylabel('count' , 'Fontsize', 14);

xlim([0 255]);
ylim([0 max(RCount)]);
title('(b)');

subplot(2,5,3);
imshow(C);
title('(c)');


subplot(2,5,4);
imshow(D);
title('(d)');


subplot(2,5,5);
imshow(E);
title('(e)');


subplot(2,5,6);
imshow(F);
title('(f)');


subplot(2,5,7);
imshow(G);
title('(g)');


subplot(2,5,9);
imshow(I);
title('(I)');

subplot(2,5,10);
imshow(J);
title('(j)');


% References
% 
% Image d
% https://uk.mathworks.com/help/images/ref/imerode.html
% 
% 
% Image e
% https://en.wikipedia.org/wiki/Unsharp_masking
% 
% Image f
% https://uk.mathworks.com/help/images/ref/imclose.html
% 
% Image i
% https://uk.mathworks.com/help/images/ref/imdilate.html

