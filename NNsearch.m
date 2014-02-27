function [ lengths ] = NNsearch( A, delta )
%Nearest Neighbour search
%   This function takes in a data matrix (A) with x and y co-ordinates and
%   lengths alpha, and calculates the neighbours of each node within the
%   distance alpha


num_cells = length(A(:,1));

lengths = zeros(num_cells,num_cells);

for i= 1:num_cells
    for j = 1:num_cells
        
        if(i==j)
            
            continue;
            
        end  
        
        L = sqrt( ( A(j,1) - A(i,1))^2 + ( A(j,2) - A(i,2))^2);
        
        lengths(i,j) = L;
               
        if(L > delta)
                 
            lengths(i,j) = 0;
        end
             
    end
end


end

