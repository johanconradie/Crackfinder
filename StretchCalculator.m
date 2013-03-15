function [ stretches,bonds ] = StretchCalculator( Lengths, current_lengths )
%Stretch Calculator - Calculates the stretch of each bond and counts the
%bonds in each neighbourhood

%   This function takes in two matrices that contain the lengths and deformed lengths of the
%   bonds of each neighbourhood, and determines the stretch of each bond
%   and returns a matrix
%   and the amount of bonds in each neigbourhood and returns a vector

num_lengths = length( Lengths(:,1));
counter = 0;
stretches = zeros( num_lengths, num_lengths);


for i = 1: num_lengths
    
    for j = 1:num_lengths
        
        if( Lengths(i,j) == 0)
            
            continue;
            
        end
        
       stretches(i,j) = ( current_lengths(i,j) - Lengths(i,j)) / Lengths(i,j);
       
       if(stretches(i,j) ~= 0)
           
           counter = counter + 1;
           
           
       end
       
    end
    
    bonds(i) = counter;
    counter = 0;
    
end

