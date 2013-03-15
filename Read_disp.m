clear; clc;
disp = load('B00400.txt');
size(disp);
x=disp(:,1);
y=disp(:,2);
u_x=disp(:,3);
u_y=disp(:,4);

%plot(x,y,'xr')

                                    %reference coordinates reduced x
                                    %bounaries
 for i = 1:length(x)

    if( x(i) >= 10 || x(i) <= -15)
         
         x(i) = 0;
         y(i) = 0;
         u_x(i) = 0;
         u_y(i) = 0;
         
    end
 end
                                    %reference coordinates reduced y
                                    %bounaries
for i = 1:length(y)

    if( y(i) >=10 || y(i) <= -15)
         
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

reduced_coords = [x_reduced' y_reduced']
reduced_disp = [u_x_reduced' u_y_reduced']


[rows,columns] = size(reduced_coords)

f = fopen('reduced_B00400.txt','wt');     % Note the 'wt' for writing in text mode
for i =1:rows;
    
    for j =1:columns;
   
        fprintf(f,'%f  ',reduced_data(i,j));
        
    end
         fprintf(f,'\n');
        
end             
fclose(f);

%plot(x_reduced,y_reduced,'rx');
%hold on
%plot(x_reduced+u_x_reduced,y_reduced+ u_y_reduced,'bo');

[ lengths ] = NNsearch( reduced_coords, 4);

[ current_lengths ] = Currentbondlenghts( reduced_coords + reduced_disp, lengths);

[ stretches, bonds ] = StretchCalculator(lengths, current_lengths );

[damage] = DamageCalculator(stretches, 0.015, bonds);

Damage = damage'

%plot3(x_reduced,y_reduced,Damage,'bx');

num_rows = 44;
num_cols = length(x_reduced)/num_rows

for i = 1:num_rows

    D(i,:) = Damage( (i-1) *num_cols +1 : (i-1)*num_cols + num_cols);
    X(i,:) = x_reduced( (i-1) *num_cols +1 : (i-1)*num_cols + num_cols);
    Y(i,:) = y_reduced( (i-1) *num_cols +1 : (i-1)*num_cols + num_cols);

end
D
X
Y

surface(X,Y,D)
axis equal
