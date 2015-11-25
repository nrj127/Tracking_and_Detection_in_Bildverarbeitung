%LOADTREES Summary of this function goes here
%   Detailed explanation goes here
clear all;
cd Trees;
fileList = ls('Tree*.txt');
cd ..
fileList = strcat('Trees/',fileList);
for i = 1:length(fileList(:,1))
  
  f = fopen(fileList(i,:),'r');  
  tree =  textscan(f,'%f %f %f %f %f %f %f %f %f %f %f');

% 1st row gives us the number of internal nodes    
internal_nodes{i}   = tree{1,1}(1,1);

% number of internal nodes gives us the n lines to read from children
% information
id_node{i}          = tree{1,1}(2:internal_nodes{i}+1,1);
cl{i}               =      tree{1,2}(2:internal_nodes{i}+1,1);
cr{i}               =       tree{1,3}(2:internal_nodes{i}+1,1);
threshold{i}        =  tree{1,4}(2:internal_nodes{i}+1,1);
x0{i}               =  tree{1,5}(2:internal_nodes{i}+1,1);
y0{i}               =  tree{1,6}(2:internal_nodes{i}+1,1);
z0{i}               =  tree{1,7}(2:internal_nodes{i}+1,1);
x1{i}               =  tree{1,8}(2:internal_nodes{i}+1,1);
y1{i}               =  tree{1,9}(2:internal_nodes{i}+1,1);
z1{i}               =  tree{1,10}(2:internal_nodes{i}+1,1);
s{i}                =  tree{1,11}(2:internal_nodes{i}+1,1);

m{i}  =  tree{1,1}(internal_nodes{i}+2,1);
j{i}  =  tree{1,1}(internal_nodes{i}+3 :internal_nodes{i}+3 + m{i}-1,1);
px{i} =  tree{1,2}(internal_nodes{i}+3: internal_nodes{i}+3 + m{i}-1,1);
py{i} =  tree{1,3}(internal_nodes{i}+3:internal_nodes{i}+3 + m{i}-1,1);

end
internal_nodes = (cell2mat(internal_nodes));
internal_nodes = internal_nodes';




