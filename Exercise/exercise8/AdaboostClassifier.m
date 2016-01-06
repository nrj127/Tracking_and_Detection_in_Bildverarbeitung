classdef AdaboostClassifier < handle
    properties
        weakClassifier
        alpha
    end
    methods
        function obj = AdaboostClassifier()
        end
        function train(obj, samples, labels, n_classifiers)
            
            obj.weakClassifier = cell(n_classifiers, 1);
            obj.alpha = zeros(n_classifiers, 1);
            
            weights = ones(size(samples, 1), 1);
            for t = 1 : n_classifiers
                %1. Normalize the weight
                weights = weights / sum(weights);
               
                %2. Create and train the weak classifier
                
                obj.weakClassifier{t} = WeakClassifier();
                error = obj.weakClassifier{t}.train(samples, labels, weights);
                
                %3. Readjusting the weights of misclassified labels
                testLabels = obj.weakClassifier{t}.test(samples);
                obj.alpha(t) = 0.5 * log((1-error)/error);
                weights = weights .* exp(-obj.alpha(t) * labels .* testLabels); 
            end 
            
            obj.alpha = obj.alpha / sum(obj.alpha);
        end
        
        function [error, classifiedLabels] = test(obj, samples , labels)
            n_classifier = numel(obj.weakClassifier);
            
            testLabels = zeros(size(samples, 1), 1);
            error = zeros(n_classifier,1);

            for i = 1:n_classifier
                testLabels = testLabels + obj.alpha(i) * obj.weakClassifier{i}.test(samples);
                
                classifiedLabels = testLabels;
                classifiedLabels(classifiedLabels > 0 ) = 1;
                classifiedLabels(classifiedLabels <= 0 ) = -1;
                
                n_misclassified = sum( (classifiedLabels ~= labels ));
                
                error(i) = n_misclassified / size(samples , 1);

            end
        end
    end
end