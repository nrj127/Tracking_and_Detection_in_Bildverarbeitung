function energy = E( R,T,A,M,m )
%E Summary of this function goes here
%   Detailed explanation goes here
    
p = R*M;
p = p ./ [p(3,:); p(3,:); p(3,:)];
T = repmat(T,1,size(p,2));
energy = norm( A*( p + T) - m);

end

