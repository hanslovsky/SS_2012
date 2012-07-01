close all; clear; clc

K = 64;
img = double(imread('soccer.tiff'));
[n1 n2 n3] = size(img);
pts = n1*n2;
imshow(uint8(round(img)));
[img_r, img_g, img_b] = deal(reshape(img(:, :, 1), pts, 1), reshape(img(:, :, 2), pts, 1), reshape(img(:, :, 3), pts, 1));
img2 = [img_r, img_g, img_b];
scatter3(img2(:, 1), img2(:, 2), img2(:, 3), 0.1, [0.8 0.2 0.1], 'd')

% [centers_r, post_r] = mip_kmeans(img_r, K);
% [centers_g, post_g] = mip_kmeans(img_r, K);
% [centers_b, post_b] = mip_kmeans(img_r, K);

% R = reshape(centers_r(post_r), n1, n2);
% G = reshape(centers_g(post_g), n1, n2);
% B = reshape(centers_b(post_b), n1, n2);

[centers, post] = mip_kmeans(img2, K);
% img_compressed = zeros(n1, n2, n3);
img_compressed = reshape(centers(post, :), n1, n2, n3);
% img_compressed(:, :, 1) = R;
% img_compressed(:, :, 2) = G;
% img_compressed(:, :, 3) = B;
figure
imshow(uint8(round(img_compressed)))