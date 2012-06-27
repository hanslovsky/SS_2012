close all; clear; clc

img = double(imread('soccer.tiff'));
[n1 n2 n3] = size(img);
pts = n1*n2;
imshow(uint8(round(img)));
img2 = [reshape(img(:, :, 1), pts, 1) reshape(img(:, :, 2), pts, 1) reshape(img(:, :, 3), pts, 1)];
scatter3(img2(:, 1), img2(:, 2), img2(:, 3), 0.1, [0.8 0.2 0.1], 'd')
