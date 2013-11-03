function [ Effective_micromodulus, c, Sum_W, Sum_W_reduced ] = Strain_Energy( stretches,lengths, Elasticity, horizon, poisson, critical_stretch )
%Strain Energy Calculates the reduction in strain energy in each bond

% description: function takes in stretches, Young's modulus of elasticity, material horizon  and Poisson's ratio of a material
%              1) determines the micro-modulus,c , based on Gerstle et al
%              2007. Then determines the strain energy in each bond

% c = micromodulus
% W = strain energy

c = Elasticity/(3.14*horizon^3*(1-poisson));

size = length(stretches)

Sum_W = [];
counter = 0;

% DETERMINES THE STRAIN ENERGY OF ALL STRETCHES AND TAKES THE SUM W OF EACH
% NEIGHBOURHOOD
for i = 1:size
    for j = 1:size
   
        W(i,j) = 1/2*c*stretches(i,j)^2*lengths(i,j);
        counter = counter + W(i,j); 
        
    end
     Sum_W(i) = 0.5*counter;
     counter = 0;
end

%STRAIN ENERGY OF NEIGHBOURHOOD REDUCED BY BRKOEN BONDS
for i = 1:size                                                              %adjacent matrix full 1's and zeros
    for j = 1:size
        
        if(stretches(i,j) <= critical_stretch )
            
             W_reduced(i,j) = 1/2*c*stretches(i,j)^2*lengths(i,j);
             counter = counter + W_reduced(i,j);
             
        end
        
     
    end
    
    Sum_W_reduced(i) = 0.5*counter;
    counter = 0;
end

for i = 1:size

    Effective_micromodulus(i) = (Sum_W(i)-Sum_W_reduced(i))/Sum_W(i);

end

end

