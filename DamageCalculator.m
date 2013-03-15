function [ Damage ] = DamageCalculator( stretches, criticalstretch, bonds )
%DamageCalculator - This function calculates the percentage damage of each
%neighbourhood
%   The function takes in the matrix of stretches and compares the stretch
%   of each bond with the critical stretch

num_cells = length(stretches(:,1));

lengths = zeros(num_cells,num_cells);
counter = 0;
%Damage = zeros(num_cells);

for i= 1:num_cells
    for j = 1:num_cells
        
        if(i==j)
            
            continue;
            
        end  
        
        if(abs(stretches(i,j)) >= criticalstretch)
           
            counter = counter +1;
            
        end
    end  
        Damage(i) = counter/bonds(i);
        counter =0;
    
end
end
