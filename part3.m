clear all;
close all;
clc;

filename = uigetfile('*.bmp');
RGB = imread(filename);

%transforming color image into gray image (L)
R = RGB(:,:,1);
G = RGB(:,:,2);
B = RGB(:,:,3);

R=(0.2126*R);
G=(0.7152*G);
B=(0.0722*B);
L= R+G+B;


 A= imadjust(L,[0.1,1]);% (a)
 
 % Histogram equalization for image L (c)
C = histeq(L);

% Used to blur an image
blur = imgaussfilt(L, 16);%(g)
% Unsharp mask convolution (g)
unsharpMConv= L +( L - blur);

 %function used to sharpen image (L) (h)
 sharpenConvF = imsharpen(L,'Radius',20,'Amount',4);
 
%add 10 % salt and pepper (i)
I = imnoise(L,'salt & pepper',0.1);

% remove salt and pepper noise  (j)
J = medfilt2(I);


subplot(2,5,1); 
imshow(A)
title('(a)');

subplot(2,5,2); 
StretchHisto = imhist(L);
OriginHisto = imhist(A);
plot( (0:255) ,StretchHisto,'r-');hold on ;
plot( (0:255) ,OriginHisto,'y-');
xlabel ('Original= red ,Stretch= yellow','Fontsize', 8 );
ylabel('Stretch' , 'Fontsize', 14);
xlim([0 255]);
title('(b)');

subplot(2,5,3); 
imshow(C)
title('(c)');


subplot(2,5,4); 
EqualizeHisto = imhist(L);
OriginalHisto = imhist(C);
plot( (0:255) ,EqualizeHisto,'r-');hold on ;
plot( (0:255) ,OriginalHisto,'y-');
xlabel ('Original= red ,Equalize= yellow','Fontsize', 8 );
ylabel('Equalize' , 'Fontsize', 14);
xlim([0 255]);
title('(d)');




subplot(2,5,7); 
imshow(unsharpMConv)
title('(g)');

subplot(2,5,8);
imshow(sharpenConvF)
title('(h)');


subplot(2,5,9); 
imshow(I)
title('(i)');

subplot(2,5,10);
imshow(J)
title('(j)');

% References
% 
% image a
% https://uk.mathworks.com/help/images/ref/imadjust.html
% 
% image c
% https://uk.mathworks.com/help/images/ref/histeq.html
% 
% image g
% https://uk.mathworks.com/help/images/ref/imgaussfilt.html
% https://en.wikipedia.org/wiki/Unsharp_masking
% 
% image h
% https://uk.mathworks.com/help/images/ref/imsharpen.html
% 
% image i
% https://uk.mathworks.com/help/images/ref/imnoise.html
% 
% image j
% https://uk.mathworks.com/help/images/ref/medfilt2.html
