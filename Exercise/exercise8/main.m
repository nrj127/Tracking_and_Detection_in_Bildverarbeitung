clear all;

data1 = load('data1.mat')
data2 = load('data2.mat')
data3 = load('data3.mat')
classifier_data = load('Classifiers.mat')

data1 = data1.dat;
data2 = data2.dat;
data3 = data3.dat;
clf = classifier_data.classifiers;


class_label = data1(:,3);
training_set = data1(:,1:2);
m = size(training_set,1);

% plot 


first_class_index = find(class_label == -1);
second_class_index = find(class_label == 1);

first_class_elements = training_set(first_class_index,:);
second_class_elements = training_set(second_class_index,:);

figure, hold on;

plot(first_class_elements(:, 1), first_class_elements(:, 2), 'ro');
plot(second_class_elements(:, 1), second_class_elements(:, 2), 'bo');