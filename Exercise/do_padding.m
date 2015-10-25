function [ result ] = do_padding( I,kernel,treatment )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

[m,n]   = size(I);
[kr, kc] = size(kernel);

numberofRows =   30  %floor(kr/2);
numberofCols =    30 %floor(kc/2);

if strcmp('mirror',treatment)
  result = [fliplr(I(:,1:numberofCols)),I,fliplr(I(:,n-numberofCols+1:n))];
  result = [flipud(result(1:numberofRows,:));result;flipud(result(m-numberofRows+1:m,:))];
end

if strcmp('border',treatment)
    result = [repmat(I(1,:), [numberofRows,1]); I; repmat(I(m,:), [numberofRows,1])];
    result = [repmat(result(:,1), [1,numberofCols]), result,repmat(result(:,n),[1,numberofCols])];
    
end

end