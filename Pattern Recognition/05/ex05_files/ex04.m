close all; clear; clc;

div = 20;

z = [0 0];
grid = zeros(101);
x = [(0:100) - 50; zeros(1, 101)];
x = x/div;

sigma = [0.1 0.2 0.5 1 1.5 2];

h1 = figure
for k = 1:size(sigma,2)
    
    for i=1:101
        x(2, :) = (i*ones(1, 101) - 51)/div;
        grid(i, :) = gaussian_kernel(x, z, sigma(k));
    end

    ax = (-50:50)/div;
    figure(h1)
    subplot(2, 3, k)
    imagesc(ax, ax, grid)
    
    title(['\sigma = ' num2str(sigma(k))])
    
    h2 = figure
    surf(ax, ax, grid)
    title(['\sigma = ' num2str(sigma(k))])
    colorbar('location','southoutside')
    
    cd images;
    saveas(h2, ['surf_' sprintf('%02d', sigma(k)*1/sigma(1)) '.pdf'], 'pdf')
    cd ..;
    close


end