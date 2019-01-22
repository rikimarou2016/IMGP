clear all;
close all;
clc;

filename = uigetfile('*.bmp');



% (a)
RGB = imread(filename);

% (b)
R = RGB(:,:,1);
G = RGB(:,:,2);
B = RGB(:,:,3);

R=(0.2126*R);
G=(0.7152*G);
B=(0.0722*B);

L= R+G+B;

% (e)
Bin = im2bw(L);

%calculating the number of rows ans colums for image L
M = size (L,1);
N = size(L,2);

%calculations

minLum = min(min(L));
disp(['Minimum Luminance = ' num2str(minLum)]);

maxLum = max(max(L));
disp(['Maximum Luminance = ' num2str(maxLum)]);

meanLum= mean2 (L);

Crange=maxLum-minLum;

CnRange=(maxLum-minLum)/255 ;

Cmich=(maxLum-minLum)/(maxLum+minLum);


RGBsize = M*N*3/1000;
Lsize = M*N/1000;
Binsize= (M*N/8)/1000;
Crms=sqrt(1/(M*N)*(sum(sum(((L-meanLum).^2)))));

figure;
subplot(2,5,1);
imshow(RGB);
title('(a)');

subplot(2,5,2);
imshow(L);
title('(b)');

subplot(2,5,3);
E = ones(M,N).*255;
imshow(E);
string1 = sprintf('M = %d', M );text(100,200,string1);% for floats, use %.2f instead of %d
string2 = sprintf('N = %d', N);text(100,400,string2);
string3 = sprintf('RGB size = %.1f Kb', RGBsize);text(100,600,string3);
string4 =sprintf('L size = %.1f Kb', Lsize);text(100,800,string4);
string5 = sprintf('B size = %.1f Kb', Binsize);text(100,1000,string5);
title('(c)');


subplot(2,5,4);
E = ones(M,N).*255;
imshow(E)
string6 = sprintf('Lmin = %.2f', minLum );text(100,200,string6);
string7 = sprintf('Lmax = %.2f', maxLum);text(100,400,string7);
string10 = sprintf('Lmean = %.2f', meanLum);text(100,1000,string10);
title('(d)');


subplot(2,5,5);
imshow(Bin);

T= 128;
Bin= L>T;

hold on;
for i=1:M
    for j=1:N
        if L (i,j)==minLum
            plot(j,i,'r.')
        end
      if L (i,j)==maxLum
            plot(j,i,'g.') 
            
      end
    end
end
title('(e)');

subplot(2,5,6);
E = ones(M,N).*255;
imshow(E)
string11 = sprintf('Crange = %.2f', Crange );text(100,200,string11);
string12 = sprintf('CnRange = %.2f', CnRange);text(100,500,string12);
string13 = sprintf('Cmich = %.2f', Cmich);text(100,800,string13);
string14 = sprintf('Crms = %.2f', Crms);text(100,1100,string14);
title('(f)');

subplot(2,5,7);
[a_counts ,a_xasis] =imhist (L) ;
 bar( a_xasis , a_counts, 'r');
 xlabel('Luminance','Fontsize' , 14);
 ylabel('Count','Fontsize',14);
 xlim([0 255]);
 title('(g)');
 
 subplot(2,5,8);
 Hnorm= a_counts ./(M*N );
 bar(Hnorm, 'r');
 xlabel('Luminance','Fontsize' , 14);
 ylabel('Normalized count','Fontsize',14);
 xlim([0 255]);
 title('(h)');


 subplot(2,5,9);
 for currentLuminance = 1:255
     Hcumul(currentLuminance)= sum(a_counts(1:currentLuminance));
 end
  bar(Hcumul, 'r');
 xlabel('Luminance','Fontsize' , 14);
 ylabel('Cumulative count','Fontsize',14);
 xlim([0 255]);
 title('(i)');

 subplot(2,5,10);
 HnormCumul= Hcumul ./(M*N );
 bar(HnormCumul, 'r');
 xlabel('Luminance','Fontsize' , 14);
 ylabel('Normalized Cumulative count','Fontsize',14);
 xlim([0 255]);
 title('(j)');

 

 
 
 
 
 
 
 
 

