close all; clear; clc;

skala=imread("dane/skala_20.jpg");
% 500 mikrometrów - 467 pikseli
% 1 piksel - 500/467 mikrometrów
% 1 piksel = (500/467)*0.001 milimetrów
disp('Obliczone powierzchnie: ');

% GLAUKONIT

%wczytanie obrazu
n1 = imread("dane/1n_00.bmp");

subplot(231); imshow(n1);

%binaryzacja
gl_bin_tmp = (n1(:,:,1)>37) & (n1(:,:,1)<90) & (n1(:,:,2)>52) & (n1(:,:,2)<100) & (n1(:,:,3)>40) & (n1(:,:,3)<80);
gl_bin_tmp1 = (n1(:,:,1)<n1(:,:,2)) & (n1(:,:,3)<n1(:,:,2));
gl_bin = gl_bin_tmp & gl_bin_tmp1;

%przekształcenia morfologiczne
med = medfilt2(gl_bin, [5 5]);
closed = imclose(med, strel("disk", 8));
opened = imopen(closed, strel("disk", 15));
eroded = imerode(opened, strel("disk", 3));
glaukonit = bwareaopen(eroded,500);

%obliczenie powierzchni
pow_glaukonit = sum(glaukonit(:)) * ((500/467)*0.001)^2; 
disp(['1. Glaukonit: ', num2str(pow_glaukonit), ' mm2.']);

%wyswietlenie konturu
boundary_glaukonit = bwperim(glaukonit, 8);
boundary_glaukonit = imdilate(boundary_glaukonit, strel('disk', 2));
subplot(233); imshow(imoverlay(n1, boundary_glaukonit, 'green'));


% WEGLANY

%wczytanie obrazów
nx1 = imread("dane/xn_00.bmp");
nx2 = imread("dane/xn_210.bmp");
nx4 = imread("dane/xn_330.bmp");

nx2=imrotate(nx2,-210, 'nearest','crop');
nx4=imrotate(nx4,-330, 'nearest','crop');

subplot(232); imshow(nx1);

%binaryzacja i przekształcenia morfologiczne dla wybranych zdjęć

%nx1
nx1_bin_tmp = (nx1(:,:,1)>150) & (nx1(:,:,2)>110)  & (((nx1(:,:,3)>75) & (nx1(:,:,3)<120)) | ((nx1(:,:,3)>150) & (nx1(:,:,3)<200)));
nx1_bin_tmp1 = (nx1(:,:,1)>nx1(:,:,2)) & (nx1(:,:,1)-10>nx1(:,:,3));
nx1_bin = nx1_bin_tmp & nx1_bin_tmp1;

nx1_bin = imclose(nx1_bin, strel('disk', 3));
nx1_bin = medfilt2(nx1_bin, [15 15]);
nx1_bin = imclose(nx1_bin, strel('disk', 17));

%nx2
nx2_bin = (nx2(:,:,1)>110) & (nx2(:,:,2)>180) & (nx2(:,:,3)>120) & (nx2(:,:,3)<190);
nx2_bin = medfilt2(nx2_bin, [7 7]);
nx2_bin = imclose(nx2_bin, strel('disk', 15));
nx2_bin = medfilt2(nx2_bin, [3 3]);
nx2_bin = imdilate(nx2_bin, strel('disk', 9));
nx2_bin = imerode(nx2_bin, strel('disk', 7));

%nx4
nx4_bin_tmp = (nx4(:,:,1)>100) & (nx4(:,:,2)>115) & (nx4(:,:,2)<210) & (nx4(:,:,3)>90) & (nx4(:,:,3)<200);
nx4_bin_tmp1 = (nx4(:,:,1)>=nx4(:,:,3));
nx4_bin_tmp2 = (nx4(:,:,1)>200) & (nx4(:,:,2)>245);
nx4_bin = (nx4_bin_tmp & nx4_bin_tmp1) | nx4_bin_tmp2;

nx4_bin = medfilt2(nx4_bin, [7 7]);
nx4_bin = imclose(nx4_bin, strel('disk', 9));
nx4_bin = imopen(nx4_bin, strel('disk', 5));
nx4_bin = bwareaopen(nx4_bin, 200);

%dopasowanie masek
nx2_bin = circshift(nx2_bin,[-32, -55]);
nx4_bin = circshift(nx4_bin, [-12, 4]);

weglany = nx1_bin | nx2_bin | nx4_bin;

weglany = bwareaopen(weglany, 100);

%obliczenie powierzchni
pow_weglany = sum(weglany(:)) * ((500/467)*0.001)^2; 
disp(['2. Węglany: ', num2str(pow_weglany), ' mm2.']);

%wyswietlenie konturu
boundary_weglany=bwperim(weglany, 8);
boundary_weglany = imdilate(boundary_weglany, strel('disk', 2));
subplot(234); imshow(imoverlay(nx1, boundary_weglany, 'magenta'));



% KWARC

%wczytanie obrazow
nx1 = imread("dane/xn_00.bmp");
nx2 = imread("dane/xn_210.bmp");
nx3 = imread("dane/xn_300.bmp");

nx2=imrotate(nx2,-210, 'nearest','crop');
nx3=imrotate(nx3,-300, 'nearest','crop');

%binaryzacja i przekształcenia morfologiczne dla wybranych zdjęć

%nx1
nx1_bin1 = (nx1(:,:,1)>105) & (nx1(:,:,2)>110) & (nx1(:,:,3)>150);
nx1_bin2 = nx1(:,:,1)<= nx1(:,:,3);
nx1_bin3 = (nx1(:,:,1)>80) & (nx1(:,:,1)<140) & (nx1(:,:,2)>80) & (nx1(:,:,2)<137) & (nx1(:,:,3)>90) & (nx1(:,:,3)<150);

nx1_bin4 = (nx1(:,:,1)>59) & (nx1(:,:,1)<90) & (nx1(:,:,2)>59) & (nx1(:,:,2)<95) & (nx1(:,:,3)>70) & (nx1(:,:,3)<100);
nx1_bin4 = imopen(nx1_bin4, strel('disk', 1));
nx1_bin4 = medfilt2(nx1_bin4, [3 3]);

nx1_bin = (nx1_bin1 & nx1_bin2) | nx1_bin3 | nx1_bin4; 

nx1_bin = medfilt2(nx1_bin, [11 11]);
nx1_bin = bwareaopen(nx1_bin, 100);
nx1_bin = imclose(nx1_bin, strel('disk', 3));
nx1_bin = imerode(nx1_bin, strel('disk', 3));
nx1_bin = bwareaopen(nx1_bin, 100);
nx1_bin = imclose(nx1_bin, strel('disk', 9));
nx1_bin = imdilate(nx1_bin, strel('disk', 3));

%nx2
nx2_bin = (nx2(:,:,1)>75) & (nx2(:,:,1)< 95) & (nx2(:,:,2)>83) & (nx2(:,:,2)<103) & (nx2(:,:,3)>95) & (nx2(:,:,3)<133);

nx2_bin = medfilt2(nx2_bin, [5 5]);
nx2_bin = medfilt2(nx2_bin, [7 7]);
nx2_bin = imclose(nx2_bin, strel('disk', 11));
nx2_bin = bwareaopen(nx2_bin, 100);
nx2_bin = imdilate(nx2_bin, strel('disk', 13));

%nx3
nx3_bin1 = (nx3(:,:,1)>120) & (nx3(:,:,1)<230) & (nx3(:,:,2)>140) & (nx3(:,:,2)<250) & (nx3(:,:,3)>155) & (nx3(:,:,3)<256);
nx3_bin2 = nx3(:,:,3)>nx3(:,:,1)-10;

nx3_bin = nx3_bin1 & nx3_bin2;
nx3_bin = medfilt2(nx3_bin, [3 3]);
nx3_bin = medfilt2(nx3_bin, [5 5]);
nx3_bin = medfilt2(nx3_bin, [7 7]);
nx3_bin = imclose(nx3_bin, strel('disk', 15));
nx3_bin = imclose(nx3_bin, strel('disk', 15));
nx3_bin = imdilate(nx3_bin, strel('disk', 5));
nx3_bin = imopen(nx3_bin, strel('disk', 7));


%dopasowanie masek
nx2_bin = circshift(nx2_bin,[-28, -50]);
nx3_bin = circshift(nx3_bin, [-30, -10]);

kwarc = nx1_bin | nx2_bin | nx3_bin;

kwarc = bwareaopen(kwarc, 100);
kwarc = kwarc & (~glaukonit) & (~weglany);

%obliczenie powierzchni
pow_kwarc = sum(kwarc(:)) * ((500/467)*0.001)^2; 
disp(['3. Kwarc: ', num2str(pow_kwarc), ' mm2.']);

%wyswietlenie konturu
boundary_kwarc=bwperim(kwarc, 8);
boundary_kwarc = imdilate(boundary_kwarc, strel('disk', 2));
subplot(235); imshow(imoverlay(nx1, boundary_kwarc, 'cyan'));

%wyswietlenie złączonych obrazów logicznych 

subplot(236); imshow(imoverlay(imoverlay(imoverlay(zeros(size(glaukonit)), glaukonit, [0.4660 0.6740 0.1880]), weglany, [0.4940 0.1840 0.5560]), kwarc, [0.3010 0.7450 0.9330]));


