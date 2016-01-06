clear all;
close all;

data = load('data3.mat');
data = data.dat;

n_classifier = 250;

% Training data
samples = data( : , 1:2);
labels = data(:,3);


negitiveSamples = samples(labels == -1,:);
positiveSamples = samples(labels == 1,:);

% Show the data
figure, subplot(2,2,1), hold on; axis equal;
plot(negitiveSamples(:, 1), negitiveSamples(:, 2), 'r.');
plot(positiveSamples(:, 1), positiveSamples(:, 2), 'b.');
title('Training Data');

%errors = zeros(n_classifier,1);

% Use Adaboost to train n_classifier weak classifiers
obj = AdaboostClassifier();

obj.train(samples,labels,n_classifier);

% Test using the weak classifiers
[errors , testLabels] = test(obj, samples , labels);
estPositive = samples(testLabels == 1 , :);
estNegitive = samples(testLabels == -1 , :);

subplot(2,2,3), plot(errors); title('Error versus number of classifiers');


% Show classified data
subplot(2,2,4), hold on
plot(estPositive(:,1),estPositive(:,2),'b.');
plot(estNegitive(:,1),estNegitive(:,2),'r.');
axis equal;
title('Classification with adaboost');
