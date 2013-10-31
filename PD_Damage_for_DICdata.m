clear; 
clc;

DICdata = load('B00400.txt');                                              %for graphite the coords is 25, -25,25,-25); 

[reduced_data] = DataReducer_Zero_disp_remover(DICdata, 10,-9,8,-15);                     %reduce DIC data between x1,x2 and y1,y2 values of interest
                                                                           %for the B00400 series the coords 
x       = reduced_data(:,1);                                               % are between 10,-15,10,-15);
y       = reduced_data(:,2);
u_x     = reduced_data(:,3);
u_y     = reduced_data(:,4);
% 
plot( x + u_x, y + u_y ,'rx')                                            %if the data is reduced the rows have to be counted for the damagedcoordinates function in order to plot the damage, I know it sucks, but I'm going to fix it later ;)
hold on
plot(x,y,'.b')

[ lengths ] = NNsearch( reduced_data, 1.69);                                  %Nearest neighbour search, calculates bond lengths between nodes within a horizon alpha

current_coords = [x + u_x ,y + u_y ];                    

[ current_lengths ] = Currentbondlenghts( current_coords, lengths);        %determines the current lengths of the deformed bond lengths

[ stretches, bonds ] = StretchCalculator(lengths, current_lengths );       %determines the stretch of deformed bonds

[damage] = DamageCalculator(stretches, 0.1, bonds);                     %determines the damage by calculating Sum_broken_bonds/Sum_bonds

% damage'
%  figure(2)
% plot3(x,y,damage)

figure(3)
 [ X, Y, D] = DamagedCoordinates(damage, x, y , 41);                       %the output is 3 matrices to use for contour or surface plot, you need to count the rows of the original coordinates and then insert it here, currently it is 44 rows
                                                                           % for graphite value is 64 with coords as specified above
                                                                           % for steel value is 44 with coords as specified
surface(X,Y,D)
ylabel('x position (mm)')
xlabel('y position (mm)')

axis equal

% %Alternative method to plot damage
% 
% % First define a regular grid. Suppose x and y are between 0 and 100.
% % We'll set up a 201x201 grid
% 
% [XI,YI] = meshgrid(x, y);
% % XI and YI will both be 201x201. XI contains the x-coords of each point and
% % YI contains the y-coords.
% 
% 
% % now interpolate - find z values for these grid points
% ZI = griddata(x,y,damage,XI, YI);
% % The z values in ZI can now be used by routines like contour, etc.
% % Display this as a mesh 
% mesh(XI,YI,ZI);
% hold
% % plot the original data too
% surface(x,y,z);
% hold off
