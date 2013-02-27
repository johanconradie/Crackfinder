clear; clc;
disp = load('B00400.txt')
size(disp)
x=disp(:,1);
y=disp(:,2);
u_x=disp(:,3);
u_y=disp(:,4);

%reference coordinates < 5
 for i = 1:length(x)

    if( x(i) >= 5 || x(i) <= -9)
         
         x(i) = 0;
         y(i) = 0;
         u_x(i) = 0;
         u_y(i) = 0;
         
    end
end

for i = 1:length(y)

    if( y(i) >= 5 || y(i) <= -9)
         
         y(i) = 0;
         x(i) = 0;
         u_x(i) = 0;
         u_y(i) = 0;
         
    end
end
counter1 = 1;
for i = 1:length(x)
    
    if( x(i) ~= 0 && y(i) ~= 0)
        
        x_reduced(counter1) =     x(i);
        y_reduced(counter1) =     y(i);
        u_x_reduced(counter1) =   u_x(i);
        u_y_reduced(counter1) =   u_y(i);
        counter1 = counter1 +1;

    end
end


A = [x y x+u_x y+u_y]

a= x_reduced' 
b= y_reduced' 
c= u_x_reduced'
d= u_y_reduced'
 
B= [x_reduced' y_reduced' u_x_reduced' u_y_reduced']

fid = fopen('reduced_B00400.txt','wt');     % Note the 'wt' for writing in text mode
fprintf(fid,'%f\n',a);                  % The format string is applied to each element of a
fclose(fid);

counter1
plot(x_reduced,y_reduced,'o');
 hold on
plot(x_reduced+u_x_reduced,y_reduced+ u_y_reduced,'r.');

%njkeflwsef