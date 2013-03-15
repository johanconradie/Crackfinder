function [ current_lengths ] = Currentbondlenghts( deformedcoords , lengths )
%Currentbondlenghts - Calculates the current lengths of the deformed
%coordinates
%   The function takes in the sum of the coordinates and displacements and
%   takes in the bond lengths that are in a specific horizon

num_cells = length(lengths(:,1));

current_lengths = zeros(num_cells,num_cells);

for i= 1:num_cells
    for j = 1:num_cells
        
        if(i==j)
            
            continue;
            
        end  
        
        L = sqrt( ( deformedcoords(j,1) - deformedcoords(i,1))^2 + ( deformedcoords(j,2) - deformedcoords(i,2))^2);
        
        current_lengths(i,j) = L;
               
        if(lengths(i,j) == 0)
                 
            current_lengths(i,j) = 0;
        end
             
    end
end
end


