function energy = E( params , A, M, m , method )
%E Energy Function
if(strcmp(method , 'euler') == 1)
    alpha = params(1);
    beta = params(2);
    gamma = params(3);

    RX = [ 1, 0, 0; 0, cos(alpha), sin(alpha); 0, -sin(alpha), cos(alpha)];
    RY = [cos(beta), 0, -sin(beta); 0,1,0; sin(beta),0,cos(beta)];
    RZ = [ cos(gamma), sin(gamma) , 0; -sin(gamma), cos(gamma) , 0 ; 0 , 0 , 1];

    R = RZ * RY * RX;
    t = params(4:6);
end

if(strcmp(method , 'quaternions') == 1)
        x = params(1);
        y = params(2);
        z = params(3);
        w = params(4);

        R = RotationMatrix( [w;x;y;z], 'quaternion'); 
              R = R.matrix;
        t = params(5:7);     
end

M = [ M; ones(1, size(M,2))];
proj_mat = A*[R , t];
p = proj_mat*M;
p = p ./ [p(3,:); p(3,:); p(3,:)];
%T = repmat(t,1,size(p,2));
e = p - m;
energy = sum(sum(e.*e));
end

