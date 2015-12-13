function [H, X1, Y1] = RANSAC_ADAPTIVE(X,Y,p,td,tset)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

N = inf;
sample_count = 1;
done = 0;
bestinliers = 0;

while N > sample_count && ~done
    rndset = randi([1 size(X,2)],1,4);
    H = DLT(X(:,rndset),Y(:,rndset));
    X1_dash = H*X;
    X1_dash = X1_dash./repmat(X1_dash(3,:),3,1);
    inliers=sqrt(sum((X1_dash(1:2,:)-Y(1:2,:)).^2))<td;
    if sum(inliers)>sum(bestinliers)
    	bestinliers=inliers;
    end
    if sum(inliers)>=tset
        done=1;
    end
    epsilon=1-sum(inliers)/numel(inliers);
    N=round(log(1-p)/log(1-(1-epsilon)^4));
    sample_count=sample_count+1;
end
H = DLT(X(:,bestinliers),Y(:,bestinliers));

X1 = X(:,bestinliers);
Y1 = Y(:,bestinliers);
end

