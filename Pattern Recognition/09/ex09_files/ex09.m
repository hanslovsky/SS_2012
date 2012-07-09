close all; clear; clc

% 9.1.1
K = 4;
img = double(imread('soccer.tiff'));
[n1 n2 n3] = size(img);
pts = n1*n2;

[img_r, img_g, img_b] = deal(reshape(img(:, :, 1), pts, 1), reshape(img(:, :, 2), pts, 1), reshape(img(:, :, 3), pts, 1));
img2 = [img_r, img_g, img_b];
h = figure;
scatter3(img2(:, 1), img2(:, 2), img2(:, 3), 0.1, [0.8 0.2 0.1], 'd')
saveas(h, 'scatter.pdf', 'pdf');
h = figure;
[centers, post] = mip_kmeans(img2, K);
img_compressed = reshape(centers(post, :), n1, n2, n3);
c1 = post == 1;
c2 = post == 2;
c3 = post == 3;
c4 = post == 4;
scatter3(img2(:, 1), img2(:, 2), img2(:, 3), 0.1, post, 'd');
saveas(h, 'centers.pdf', 'pdf');

% 9.1.2
h = figure;
subplot(3, 3, 1);
imshow(uint8(round(img)));
subplot(3, 3, 4);
imshow(uint8(round(img)));
subplot(3, 3, 7);
imshow(uint8(round(img)));
counter = 2;
for K=[4 16 64]
    [centers, post] = mip_kmeans(img2, K);
    img_compressed = reshape(centers(post, :), n1, n2, n3);
    subplot(3, 3, counter)
    counter = counter + 3;
    imshow(uint8(round(img_compressed)))
end

% 9.1.4

[X, Y] = ind2sub([n1, n2], 1:(n1*n2));
img3 = [img2/255 X'/n1 Y'/n2];
counter = 3;

for K=[4 16 64]
    [centers, post] = mip_kmeans(img3, K);
    img_compressed = reshape(255*centers(post, 1:3), n1, n2, n3);
    subplot(3, 3, counter)
    counter = counter + 3;
    imshow(uint8(round(img_compressed)))
end
saveas(h, 'compression.pdf', 'pdf');

K = 4;
h = figure;
[centers, post] = mip_kmeans(img3, K);
scatter3(img3(:, 1), img3(:, 2), img3(:, 3), 0.1, post, 'd');
saveas(h, 'centersXY.pdf', 'pdf');


















