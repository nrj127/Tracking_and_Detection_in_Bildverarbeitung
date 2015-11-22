function [ I_r, I_g, I_b ] = integral_image(I )

%I = imread('2007_000032.jpg');

I_r = I(:,:,1);
I_g = I(:,:,2);
I_b = I(:,:,3);

[r,c] = size(I_r)

for i = 2:c
    int_img_r(:,i) = I_r(:,i) + I_r(:,i-1);
    int_img_g(:,i) = I_g(:,i) + I_g(:,i-1);
    int_img_b(:,i) = I_b(:,i) + I_b(:,i-1);
end


for i = 2:r
    int_img_r(i,:) = I_r(i,:) + I_r(i-1,:);
    int_img_g(i,:) = I_g(i,:) + I_g(i-1,:);
    int_img_b(i,:) = I_b(i,:) + I_b(i-1,:);
end

int_img_r = [zeros(r,1) int_img_r];
int_img_g = [zeros(r,1) int_img_g];
int_img_b = [zeros(r,1) int_img_b];

int_img_r = [zeros(1,c+1); int_img_r];
int_img_g = [zeros(1,c+1); int_img_g];
int_img_b = [zeros(1,c+1); int_img_b];




