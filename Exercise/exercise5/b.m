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

xPlusS = x+s;
xMinusS = x-s;
yPlusS = y+s;
yMinusS = y-s;

if xPlusS > height
    xPlusS = height;
end
if xPlusS < 1
    xPlusS = 1;
end
if xMinusS > height
    xMinusS = height;
end
if xMinusS < 1
    xMinusS = 1;
end

if yPlusS > width
    yPlusS = width;
end
if yPlusS < 1
    yPlusS = 1;
end
if yMinusS > width
    yMinusS = width;
end
if yMinusS < 1
    yMinusS = 1;
end

e = II(xPlusS , yPlusS) - II(xMinusS , yPlusS) - II(xPlusS, yMinusS) + II(xMinusS,yMinusS);

        
end



