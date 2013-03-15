function [ reduced_data ] = DataReducer( disp, x1,x2,y1,y2 )

%DataReducer - Reduce x and y coordinates and x and y displacements to a smaller region of interest 

%Takes in a matrix of coordinates and displacements. Reduces the
%x values between the chosen x1 and x2. Reduces y values between the chosen
%y1 and y2 values and also reduces the displacements of the coordinates
%Further the function will print the reduced values into a text file and
%saves it in the folder
%The Function then sends back a matrix with reduced coordinates ans
%displacements

x=disp(:,1);
y=disp(:,2);
u_x=disp(:,3);
u_y=disp(:,4);


                                    %reference coordinates reduced x
                                    %bounaries
 for i = 1:length(x)

    if( x(i) >= x1 || x(i) <= x2)
         
         x(i) = 0;
         y(i) = 0;
         u_x(i) = 0;
         u_y(i) = 0;
         
    end
 end
                                    %reference coordinates reduced y
                                    %bounaries
for i = 1:length(y)

    if( y(i) >=y1 || y(i) <= y2)
         
         y(i) = 0;
         x(i) = 0;
         u_x(i) = 0;
         u_y(i) = 0;
         
    end
end

counter1 = 1;

for i = 1:length(x);
    
    if( x(i) ~= 0 && y(i) ~= 0);
        
        x_reduced(counter1) =     x(i);
        y_reduced(counter1) =     y(i);
        u_x_reduced(counter1) =   u_x(i);
        u_y_reduced(counter1) =   u_y(i);
        counter1 = counter1 +1;

    end
end
 
reduced_data = [x_reduced' y_reduced' u_x_reduced' u_y_reduced'];

reduced_coords = [x_reduced' y_reduced'];
reduced_disp = [u_x_reduced' u_y_reduced'];


[rows,columns] = size(reduced_coords);

f = fopen('reduced_B00400.txt','wt');     % Note the 'wt' for writing in text mode
for i =1:rows;
    
    for j =1:columns;
   
        fprintf(f,'%f  ',reduced_data(i,j));
        
    end
         fprintf(f,'\n');
        
end             
fclose(f);

end

