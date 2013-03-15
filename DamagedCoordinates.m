function [ X,Y,D ] = DamagedCoordinates( Damage, x, y, num_rows)
%DamagedCoordinates - plots the damage of a speciment after it has been loaded 

%The function takes in the damage vector and the coordinates matrix, rearrange 
%the coordinates and the damage to enable it to plot the contours of the damage  


num_cols = length(x)/num_rows;

for i = 1:num_rows

    D(i,:) = Damage( (i-1) *num_cols +1 : (i-1)*num_cols + num_cols);
    X(i,:) = x( (i-1) *num_cols +1 : (i-1)*num_cols + num_cols);
    Y(i,:) = y( (i-1) *num_cols +1 : (i-1)*num_cols + num_cols);

end
end