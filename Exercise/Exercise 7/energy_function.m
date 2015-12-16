function [min_value] = energy_function(x,A,M,m)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


alpha_val = x(1);
beta_val = x(2);
gamma_val = x(3);
t_1 = x(4);
t_2 = x(5);
t_3 = x(6);

R_alpha = [cos(alpha_val), 0, sin(alpha_val); 0,1,0; -sin(alpha_val),0,cos(alpha_val)];
R_gamma = [ cos(gamma_val), 0, sin(gamma_val); 0, 1, 0; -sin(gamma_val), 0, cos(gamma_val)];
R_beta = [ 1, 0, 0; 0, cos(beta_val), -sin(beta_val); 0, sin(beta_val), cos(beta_val)];

R = R_gamma * R_beta * R_alpha;

T = [t_1;t_2;t_3];

matrix = [R,T];
P = A * matrix;
P_m = P*M;

% divide by z

P_m(1,:) = P_m(1,:)./P_m(3,:);
P_m(2,:) = P_m(2,:)./P_m(3,:);
P_m(3,:) = ones(1,size(P_m(3,:),2));

min_value = (P_m - m);
min_value = sum(sum(min_value.*min_value)); 



end

