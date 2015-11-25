function [ II_b, II_g, II_r ] = integral_image(I )

[r,c, ~] = size(I);
II = I;

for i = 2:c
    II(:,i,:) = II(:,i,:) + II(:,i-1,:);
end


for i = 2:r
    II(i,:,:) = II(i,:,:) + II(i-1,:,:);
end

II_b = II(:,:,1);
II_g = II(:,:,2);
II_r = II(:,:,3);

