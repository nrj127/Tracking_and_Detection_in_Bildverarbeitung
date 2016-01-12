function [H] = DLT(X,X_wrapped )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here


[X_normalized,t1  ] =   normalize(X);
[X_wrapped_normalized,t2] = normalize(X_wrapped); 

n = size(X_normalized,2);

A = [];

for p = 1:n
    
    xwp = X_wrapped_normalized(1,p);
    ywp = X_wrapped_normalized(2,p);
    wwp = X_wrapped_normalized(3,p);
    
    xp  = X_normalized(:,p);


    Ap = [0,0,0, -wwp*xp', ywp*xp'; wwp*xp',0,0,0, -xwp*xp'];

    A = [A;Ap];
end

[U,S,V] = svd(A);

H = reshape(V(:,9),[3 3])';

H = inv(t2) * H * t1;

end

