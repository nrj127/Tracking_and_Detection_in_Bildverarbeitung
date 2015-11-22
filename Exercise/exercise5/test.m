temp_new = [];
for i= 1:10
    temp = num2str(i-1);
    temp_new = [temp_new temp];
    
end

temp1 = 'Tree';
temp2 = '.txt';
temp3 = '0';
FILE = [];
for i = 1:10
  file = strcat(temp1,temp_new(i),temp2)
  FILE = [FILE;file];
end

for i = 1:10
f = fopen(FILE(i,:),'r');
tree{i} =  textscan(f,'%f %f %f %f %f %f %f %f %f %f %f');
end


