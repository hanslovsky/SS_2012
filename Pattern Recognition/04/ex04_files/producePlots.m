function producePlots(x, t, training, test, nin, nhidden, nout, outfunction, ncycles)

    rnd = 0;
    if strcmp(outfunction, 'logistic')
        rnd = 0.5;
        t = t + (t < 0);
    end
        
    net = MLP_train(x, t, nin, nhidden, nout, outfunction, ncycles);

    h = figure;
    y = mlpfwd(net, test(1:2, :)') > rnd;
    
    colormap(hsv(3));
    scatter(test(1,:), test(2,:), 25, y, 'o', 'filled');
    hold
    scatter(test(1,:), test(2,:), 150, test(3,:), '>');
    rate = sum(y == test(3,:)')/size(y, 1);
    title(['classification rate = ' num2str(rate)], 'FontWeight', 'bold', 'FontSize', 18);
    saveas(h, ['test_nhidden=' sprintf('%d', nhidden), ',ncycles=' sprintf('%d', ncycles), ',outfunction=' outfunction '.eps'], 'eps');
%     close all;

    h = figure;
    y = mlpfwd(net, training(1:2, :)') > rnd;
    
    colormap(hsv(3));
    scatter(training(1,:), training(2,:), 25, y, 'o', 'filled');
    hold
    scatter(training(1,:), training(2,:), 150, training(3,:), '>');
    rate = sum(y == training(3,:)')/size(y, 1);
    title(['classification rate = ' num2str(rate)], 'FontWeight', 'bold', 'FontSize', 18);
    saveas(h, ['training_nhidden=' sprintf('%d', nhidden), ',ncycles=' sprintf('%d', ncycles), ',outfunction=' outfunction '.eps'], 'eps');
%     close all;

    decision_boundary = zeros(100, 100);

    for k = 1:100
        y = mlpfwd(net, [ones(1,100)*k; 1:100]');
        
        decision_boundary(k, :) = y > rnd; 
    end


    h = figure;
    colormap(hsv(3));
    imagesc(decision_boundary);
    set(gca,'YDir','normal');
    saveas(h, ['boundary' sprintf('%d', nhidden), ',ncycles=' sprintf('%d', ncycles), ',outfunction=' outfunction '.pdf'], 'pdf');
%     close all;
end