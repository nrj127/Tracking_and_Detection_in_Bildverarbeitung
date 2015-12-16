function energy = E( params , A, M, m )
%E Energy Function


alpha = params(1);
beta = params(2);
gamma = params(3);

RX = [ 1, 0, 0; 0, cos(alpha), sin(alpha); 0, -sin(alpha), cos(alpha)];
RY = [cos(beta), 0, -sin(beta); 0,1,0; sin(beta),0,cos(beta)];
RZ = [ cos(gamma), sin(gamma) , 0; -sin(gamma), cos(gamma) , 0 ; 0 , 0 , 1];

R = RZ * RY * RX;
t = params(4:6);

M = [ M; ones(1, size(M,2))];
proj_mat = A*[R , t];
p = proj_mat*M;
p = p ./ [p(3,:); p(3,:); p(3,:)];
%T = repmat(t,1,size(p,2));
e = p - m;
energy = sum(sum(e.*e));
end

