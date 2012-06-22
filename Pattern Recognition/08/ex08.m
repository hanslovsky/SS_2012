close all; clc; clear;


% 8.1.1: gp_cov.m

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
x = [-0.1 0.2, 0.8];
y = [0.45 1.0 -1.0];
query = -2:0.05:2;
[theta0, theta1, theta2, theta3, beta] = deal(1, 10, 0, 0, 0);
sigma22 = gp_cov(x, x, theta0, theta1, theta2, theta3, beta);
sigma21 = gp_cov(x, query, theta0, theta1, theta2, theta3, beta);
response = y*(sigma22\sigma21);
uncertainty = sum(sigma21);

figure
hold
plot(x, y, 'd', 'MarkerEdgeColor', 'k', ...
                'MarkerFaceColor', 'r', ...
                'MarkerSize', 6)
plot(query, response, 'k', 'LineWidth', 2)
plot(query, response + uncertainty, 'g', 'Linewidth', 1)
plot(query, response - uncertainty, 'g', 'Linewidth', 1)
hold off






% 8.1.4


[theta0, theta1, theta2, theta3, beta] = deal(1, 10, 0, 0, 20);
sigma22 = gp_cov(x, x, theta0, theta1, theta2, theta3, beta);
sigma21 = gp_cov(x, query, theta0, theta1, theta2, theta3, beta);
response = y*(sigma22\sigma21);
uncertainty = sum(sigma21);

figure
hold
plot(x, y, 'd', 'MarkerEdgeColor', 'k', ...
                'MarkerFaceColor', 'r', ...
                'MarkerSize', 6)
plot(query, response, 'k', 'LineWidth', 2)
plot(query, response + uncertainty, 'g', 'Linewidth', 1)
plot(query, response - uncertainty, 'g', 'Linewidth', 1)
hold off





















