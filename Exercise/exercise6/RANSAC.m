function [ H,X1,Y1] = RANSAC(X,Y,N,td)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

bestinliers = 0;

for i=1:N
    rndset = randi([1 size(X,2)],1,4);
    H = DLT(X(:,rndset),Y(:,rndset));
    X1_dash = H*X;
    X1_dash = X1_dash./repmat(X1_dash(3,:),3,1);
    inliers=sqrt(sum((X1_dash(1:2,:)-Y(1:2,:)).^2))<td;
    if sum(inliers)>sum(bestinliers)
    	bestinliers=inliers;
    end
end
H = DLT(X(:,bestinliers),Y(:,bestinliers));

X1 = X(:,bestinliers);
Y1 = Y(:,bestinliers);




end

