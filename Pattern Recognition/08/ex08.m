close all; clc; clear;
path('/home/phil/local/matlab', path);


%8.1.1: gp_cov.m

%8.1.2

noSamples = 10;
col = rand(noSamples, 3);

x = (-1:0.01:1);
mu = zeros(size(x));
[theta0, theta1, theta2, theta3, beta] = deal(9, 4, 0, 0, 0);
covariance = gp_cov(x, x, theta0, theta1, theta2, theta3, beta);

figure
hold
for i = 1:noSamples
      y = mvnrnd(mu, covariance);
      plot(x, y, 'Color', col(i,:))
end
hold off

[theta0, theta1, theta2, theta3, beta] = deal(1, 4, 10, 0, 0);
covariance = gp_cov(x, x, theta0, theta1, theta2, theta3, beta);
figure
hold
for i = 1:noSamples
      y = mvnrnd(mu, covariance);
      plot(x, y, 'Color', col(i,:))
end
hold off

[theta0, theta1, theta2, theta3, beta] = deal(0, 0, 0, 5, 0);
covariance = gp_cov(x, x, theta0, theta1, theta2, theta3, beta);
figure
hold
for i = 1:noSamples
      y = mvnrnd(mu, covariance);
      plot(x, y, 'Color', col(i,:))
end
hold off

[theta0, theta1, theta2, theta3, beta] = deal(9, 4, 15, 100, 0);
covariance = gp_cov(x, x, theta0, theta1, theta2, theta3, beta);
figure
hold
for i = 1:noSamples
      y = mvnrnd(mu, covariance);
      plot(x, y, 'Color', col(i,:))
end
hold off

% 8.1.3
% Gaussian Proccesses for Regressioen: A Quick Introduction [M. Ebden,
% 2008]
close all
figure
hold
x = [-0.1 0.2, 0.8];
y = [0.45 1.0 -1.0];
xFaceColor = [0.1 0.5 1];
uncertaintyFaceColor = [1 0.5 0.1];
query = -2:0.05:2;
[theta0, theta1, theta2, theta3, beta] = deal(1, 10, 0, 0, 0);
sigma22 = gp_cov(x, x, theta0, theta1, theta2, theta3, beta);
sigma21 = gp_cov(x, query, theta0, theta1, theta2, theta3, beta);
sigma11 = gp_cov(query, query, theta0, theta1, theta2, theta3, beta);
sgm = sigma11 - sigma21'*(sigma22\sigma21);
muu = sigma21'*(sigma22\y');
for i=1:25
    pts = mvnrnd(muu, sgm);
    plot(query, pts, 'Color', [0.5 0.5 0.5]);
end
response = y*(sigma22\sigma21);
uncertainty = diag(sigma11 - sigma21'*(sigma22\sigma21));
uncertainty = sqrt(uncertainty');


patch([query fliplr(query)], ...
      [response+uncertainty,fliplr(response-uncertainty)], ...
      uncertaintyFaceColor, 'EdgeColor', 'none')
alpha(0.2)
plot(query, response, 'k', 'LineWidth', 1)
plot(query, response + uncertainty, 'Color', uncertaintyFaceColor - 0.1, 'Linewidth', 1)
plot(query, response - uncertainty, 'Color', uncertaintyFaceColor - 0.1, 'Linewidth', 1)
plot(x, y, '<', 'MarkerEdgeColor', 'none', ...
                'MarkerFaceColor', xFaceColor, ...
                'MarkerSize', 7)
hold off






% 8.1.4
% Gaussian Proccesses for Regressioen: A Quick Introduction [M. Ebden,
% 2008]

figure
hold
[theta0, theta1, theta2, theta3, beta] = deal(1, 10, 0, 0, 20);
sigma22 = gp_cov(x, x, theta0, theta1, theta2, theta3, beta);
sigma21 = gp_cov(x, query, theta0, theta1, theta2, theta3, 0);
sigma11 = gp_cov(query, query, theta0, theta1, theta2, theta3, 0);
response = y*(sigma22\sigma21);
uncertainty = diag(sigma11) - diag(sigma21'*(sigma22\sigma21));
uncertainty(uncertainty < 0) = 0;
uncertainty = sqrt(uncertainty');
sgm = sigma11 - sigma21'*(sigma22\sigma21);
muu = sigma21'*(sigma22\y');
for i=1:25
    pts = mvnrnd(muu, sgm);
    plot(query, pts, 'Color', [0.5 0.5 0.5]);
end
% uncertainty = zeros(size(query));
% k = 1;
% for i=-2:0.05:2
%     uncertainty(k) = sqrt(gp_cov(i, i, theta0, theta1, theta2, theta3, beta) - gp_cov(x, i, theta0, theta1, theta2, theta3, beta)'*(sigma22\gp_cov(x, i, theta0, theta1, theta2, theta3, beta)));
%     k = k+1;
% end


patch([query fliplr(query)], ...
      [response+uncertainty,fliplr(response-uncertainty)], ...
      uncertaintyFaceColor, 'EdgeColor', 'none')
alpha(0.2)
plot(query, response, 'k', 'LineWidth', 1)
plot(query, response + uncertainty, 'Color', uncertaintyFaceColor - 0.1, 'Linewidth', 1)
plot(query, response - uncertainty, 'Color', uncertaintyFaceColor - 0.1, 'Linewidth', 1)
plot(x, y, 'o', 'MarkerEdgeColor', 'k', ...
                'MarkerFaceColor', xFaceColor, ...
                'MarkerSize', 7)
hold off


% 8.2.1

% x(4:7) = -0.9:0.6:0.9;
% y(4:7) = sin(1.5*pi*x(4:7));
% x = -2:0.1:2;
% y = sin(x);
[theta0, theta1, theta2, theta3, beta] = deal(1, 20, 0, 0, 25);
sigma22 = gp_cov(x, x, theta0, theta1, theta2, theta3, beta);
sigma21 = gp_cov(x, query, theta0, theta1, theta2, theta3, 0);
sigma11 = gp_cov(query, query, theta0, theta1, theta2, theta3, 0);
response = y*(sigma22\sigma21);
uncertainty = diag(sigma11 - sigma21'*(inv(sigma22)*sigma21));
uncertainty = abs(uncertainty');
uncertainty = sqrt(uncertainty);
% uncertainty = zeros(size(query));
% k = 1;
% for i=-2:0.05:2
%     uncertainty(k) = sqrt(gp_cov(i, i, theta0, theta1, theta2, theta3, beta) - gp_cov(x, i, theta0, theta1, theta2, theta3, beta)'*(sigma22\gp_cov(x, i, theta0, theta1, theta2, theta3, beta)));
%     k = k+1;
% end

figure
hold
patch([query fliplr(query)], ...
      [response+uncertainty,fliplr(response-uncertainty)], ...
      uncertaintyFaceColor, 'EdgeColor', 'none')
alpha(0.2)
plot(query, response, 'k', 'LineWidth', 1)
plot(query, response + uncertainty, 'Color', uncertaintyFaceColor - 0.1, 'Linewidth', 1)
plot(query, response - uncertainty, 'Color', uncertaintyFaceColor - 0.1, 'Linewidth', 1)
plot(x, y, 'o', 'MarkerEdgeColor', 'k', ...
                'MarkerFaceColor', xFaceColor, ...
                'MarkerSize', 7)
hold off






% 8.2.2

figure
hold on
lambda = sigma22\sigma21;
for i=1:size(lambda, 1)
    plot(query, lambda(i, :), 'Color', col(i,:))
end

hold off

% 8.2.3
% close all;
% figure
% hold on
% wRBF = y*inv(x'*query);
% for i=1:size(wRBF, 1)
%     plot(wRBF(i, :), 'Color', col(i,:))
% end




