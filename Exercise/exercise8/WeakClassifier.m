classdef WeakClassifier < handle
    %WeakClassifier Summary of this class goes here
    %   Detailed explanation goes here

    properties
        dimension
        threshold
        compare
    end
    methods
        function error = train(obj, samples, labels, weights)
            
            %%% Calculating threshold on each feature.
            % 1. x position
            [t_x, e_x] = obj.findThreshold(samples(:, 1), labels, weights);
            % 2. y position
            [t_y, e_y] = obj.findThreshold(samples(:, 2), labels, weights);
            
            if e_x < e_y
                obj.dimension = 1;
                obj.threshold = t_x;
            else
                obj.dimension = 2;
                obj.threshold = t_y;
            end
            
            classification = obj.test(samples);
            error = sum(weights(classification ~= labels));
        end
        function [threshold, error] = findThreshold(obj, coords, labels, weights)
            
            sumNeg = sum(weights(labels < 0));
            sumPos = sum(weights) - sumNeg;
            
            X = [coords labels weights];
            X = sortrows(X, 1);
            
            pos = cumsum(X(:, 3) .* (X(:, 2) == 1));
            neg = cumsum(X(:, 3) .* (X(:, 2) == -1));
            
            e1 = pos + (sumNeg - neg);
            e2 = neg + (sumPos - pos);
            e = min(e1, e2);
            index = find(e == min(e));
            obj.compare = e1(index) < e2(index);
            
            threshold = X(index, 1);
            error = e(index);
        end
        function labels = test(obj, samples)
            if obj.compare
                labels = samples(:, obj.dimension) > obj.threshold;
            else
                labels = samples(:, obj.dimension) < obj.threshold;
            end
            labels = -1 + 2 * labels;
        end
    end
end