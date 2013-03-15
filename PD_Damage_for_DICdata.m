clear; 
clc;

DICdata = load('B00400.txt');

[reduced_data] = DataReducer(DICdata, 10, -15,10,-15);                       %reduce DIC data between x1,x2 and y1,y2 values of interest

x       = reduced_data(:,1);
y       = reduced_data(:,2);
u_x     = reduced_data(:,3);
u_y     = reduced_data(:,4);

%plot( x, y ,'rx');                                                         %if the data is reduced the rows have to be counted for the damagedcoordinates function in order to plot the damage, I know it sucks, but I'm going to fix it later ;)

[ lengths ] = NNsearch( reduced_data, 1.5);                                   %Nearest neighbour search, calculates bond lengths between nodes within a horizon alpha

current_coords = [x + u_x ,y + u_y ];                    

[ current_lengths ] = Currentbondlenghts( current_coords, lengths);         %determines the current lengths of the deformed bond lengths

[ stretches, bonds ] = StretchCalculator(lengths, current_lengths );        %determines the stretch of deformed bonds

[damage] = DamageCalculator(stretches, 0.015, bonds);                       %determines the damage by calculating Sum_broken_bonds/Sum_bonds

[ X, Y, D] = DamagedCoordinates(damage, x, y , 44)                          %the output is 3 matrices to use for contour or surface plot, you need to count the rows of the original coordinates and then insert it here, currently it is 44 rows

surface(X,Y,D)
axis equal