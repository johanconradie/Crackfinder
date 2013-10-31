clear; 
clc;
tStart=tic;

DICdata = load('B00030(perp).txt');                                        %for graphite the coords is 25, -25,25,-25); 

[reduced_data] = DataReducer_Zero_disp_remover(DICdata, 25, -25,25,-25);                      %reduce DIC data between x1,x2 and y1,y2 values of interest
                                                                           %for the B00400 series the coords 
x       = reduced_data(:,1);                                               % are between 10,-15,10,-15);
y       = reduced_data(:,2);
u_x     = reduced_data(:,3);
u_y     = reduced_data(:,4);

% figure(1)
% subplot(1, 3, 1)
% plot( x + u_x, y + u_y ,'rx')                                            %if the data is reduced the rows have to be counted for the damagedcoordinates function in order to plot the damage, I know it sucks, but I'm going to fix it later ;)
% hold on
% plot(x,y,'.b')


%   HORIZON SPECIFICATION (Have to change between steel and graphite)
delta_x = 0.5775;
horizon = delta_x*3;

[ lengths ] = NNsearch( reduced_data, horizon);                            %Nearest neighbour search, calculates bond lengths between nodes within a horizon alpha
size = length(lengths)

for i = 1:size                                                             % Adjacent matrix, 1 if in neighbourhood 0 not
    for j = 1:size
        
        if(lengths(i,j) ~= 0)
            
            adj(i,j) = 1;
        end
    end
end


current_coords = [x + u_x ,y + u_y ];

% [xx yy] = gplot(adj, [x y]);
% % subplot(1, 3 ,1)
% plot(xx, yy, '-o', 'MarkerFaceColor','r')
% title('Reference state','fontsize',15);      
% ylabel('x position (mm)','fontsize',15);

% [xu yu] = gplot(adj, [current_coords]);
% subplot(1, 3,2)
% plot(xu, yu, '-o', 'MarkerFaceColor','r')
% title('Deformed state');    


[ current_lengths ] = Currentbondlenghts( current_coords, lengths);        %determine the current lengths of the deformed bond lengths

[ stretches, bonds ] = StretchCalculator(lengths, current_lengths );       %determine the stretch of deformed bonds

% CRITICAL STRETCH
critical_stretch = 0.08

for i = 1:size
    for j = 1:size
        
        if(stretches(i,j) >= critical_stretch)
            
            adj(i,j) = 0;
             adj_2(i,j) = 1;
        end
    end
end

%BROKEN BOND PLOT THAT REVEALS CRACKS

% [xu yu] = gplot(adj, [current_coords]);
% % subplot(1, 3,2)
% plot(xu, yu, '-o', 'MarkerFaceColor','r')
% title('Deformed state','fontsize',15);    
% xlabel('y position (mm)','fontsize',15);

[xu yu] = gplot(adj, [current_coords]);
% subplot(1, 3,3)
plot(xu, yu, '-o', 'MarkerFaceColor','r')
hold on
[xu yu] = gplot(adj_2, [current_coords]);
% subplot(1, 3,3)
plot(xu, yu, '-g', 'MarkerFaceColor','g')
title('Deformed state with broken bonds','fontsize',15);    


%DAMAGE PLOT

% [damage] = DamageCalculator(stretches, 0.08, bonds);                     %determine the damage by calculating Sum_broken_bonds/Sum_bonds
% figure(3)
%  [ X, Y, D] = DamagedCoordinates(damage, x, y , 44);                       %the output is 3 matrices to use for contour or surface plot, you need to count the rows of the original coordinates and then insert it here, currently it is 44 rows
                                                                            % for graphite value is 64 with coords as specified above                                                                          % for steel value is 44 with coords as specified
% surface(X,Y,D)
% ylabel('x position (mm)')
% xlabel('y position (mm)')
% axis equal


time_seconds =toc(tStart)