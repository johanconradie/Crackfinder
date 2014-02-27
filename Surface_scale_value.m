function [ scale_value,dy ] = Surface_scale_value( y )
%Surface_scale_value returns value to allow the surfaceplot to plot
%rectuagular data and to allow coordinates adjustments
%   

y_min = min(y);
y_max = max(y);

for j = 1:length(y)
   
    if(y(j) ~= y(j+1))
    
        dy = y(j) - y(j+1);
       
        break;
    
    end
end

scale_value = ceil((y_max - y_min)/abs(dy));



end

