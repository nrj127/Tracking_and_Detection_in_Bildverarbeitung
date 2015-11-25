function  e  = b( II_b, II_g, II_r , x , y , z , s , width , height)
%B Computes the box evaluation
%   Detailed explanation goes here

if z == 0
    II = II_b;
end
if z == 1
    II = II_g;
end
if z == 2 || z == 3
    II = II_r;
end

o = floor(s/2);

x1 = min(max(x-o, 1), width);
y1 = min(max(y-o, 1), height);
x2 = min(max(x+o, 1), width);
y2 = min(max(y+o, 1), height);
           
e = II(y2 , x2) - II(y2 , x1) - II(y1, x2) + II(y1,x1);

        
end



