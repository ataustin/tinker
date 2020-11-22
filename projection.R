# clear;                                  %clear variables
# clc;                                    %clear command line

# %offset for new view (assumes movement along x axis)
# Z_f = 3;                                %new view z offset
# Y_f = 6;                                %new view y offset

# scale = sqrt((Z_f^2)+(Y_f^2));          %scale for maintaining proper "zoom"
# h = 1;                                  %height pixels

# %original view corners, assumes symmetry
# X_1 = [3, 3, -3, -3];                   %original view x values
# Y_1 = [3, -3, -3, 3];                   %original view y values
# Z_1 = [5, 5, 5, 5];                     %original view z values

# X_2 = [0, 0, 0, 0];                     %initial declaration
# Y_2 = [0, 0, 0, 0];                     %initial declaration
# Z_2 = [0, 0, 0, 0];                     %initial declaration

# %original view points (making up the corners of the cube)
# P1_1 = [X_1(1); Y_1(1); Z_1(1); 1];
# P1_2 = [X_1(2); Y_1(2); Z_1(2); 1];
# P1_3 = [X_1(3); Y_1(3); Z_1(3); 1];
# P1_4 = [X_1(4); Y_1(4); Z_1(4); 1];
# P1_5 = [X_1(1); Y_1(1); Z_1(1)+h; 1];
# P1_6 = [X_1(2); Y_1(2); Z_1(2)+h; 1];
# P1_7 = [X_1(3); Y_1(3); Z_1(3)+h; 1];
# P1_8 = [X_1(4); Y_1(4); Z_1(4)+h; 1];


# cos_theta = Z_f/sqrt((Z_f^2)+(Y_f)^2);  %intermediate value
# sin_theta = Y_f/sqrt((Z_f^2)+(Y_f)^2);  %intermediate value

# %transformation matrix
# F = [1, 0, 0, 0; 0, cos_theta, -sin_theta, Y_f; 0, sin_theta, cos_theta, Z_f; 0, 0, 0, 1;]

# %apply transformation to each point (making up the corners of the cube)
# P2_1 = F*P1_1;
# P2_2 = F*P1_2;
# P2_3 = F*P1_3;
# P2_4 = F*P1_4;
# P2_5 = F*P1_5;
# P2_6 = F*P1_6;
# P2_7 = F*P1_7;
# P2_8 = F*P1_8;

# %generate arrays of (scaled) points for the new view
# X_2 = [P2_1(1), P2_2(1), P2_3(1), P2_4(1), P2_5(1), P2_6(1), P2_7(1), P2_8(1)]/scale
# Y_2 = [P2_1(2), P2_2(2), P2_3(2), P2_4(2), P2_5(2), P2_6(2), P2_7(2), P2_8(2)]/scale
# Z_2 = [P2_1(3), P2_2(3), P2_3(3), P2_4(3), P2_5(3), P2_6(3), P2_7(3), P2_8(3)]/scale

# function plotter (x, y, z, h, n)
#   %expects corners in clockwise order
  
#   %complicated plotting to ensure all connected lines for the original view
#   if(n == 1)
#     x_plot = [x x(1)  x   x(1)   x(2)   x(2) x(3) x(3)   x(4)   x(4)];
#     y_plot = [y y(1)  y   y(1)   y(2)   y(2) y(3) y(3)   y(4)   y(4)];
#     z_plot = [z z(1)  z+h z(1)+h z(2)+h z(2) z(3) z(3)+h z(4)+h z(4)];
#     disp("1");
  
#   %I got lazy, no complicated plotting, just plot it
#   elseif(n == 2)
#     x_plot = [x];
#     y_plot = [y];
#     z_plot = [z];
#   endif
  
#   %this code displays view from nonsense vantage point
# ##  plot3(x_plot, y_plot, z_plot);        %plot data
# ##  axis([-20 20 -20 20 -20 20]);         %set x, y, then z axis ranges
# ##  grid;                                 %enable grid on plot
# ##  xlabel("x");                          %label x axis
# ##  ylabel("y");                          %label y axis
# ##  zlabel("z");                          %label z axis

#   %this code displays view from new vantage point
#   plot(x_plot, y_plot);                 %plot x values by y values
#   axis([-10 10 -10 10]);                %set x axis then y axis ranges
#   grid;                                 %enable grid on plot
#   xlabel("x");                          %label x axis
#   ylabel("y");                          %label y axis
# endfunction

# %plot original view
# figure(1);
# plotter(X_1, Y_1, Z_1, h, 1);
# %plot new view
# figure(2);
# plotter(X_2, Y_2, Z_2, h, 2);


A <- matrix(c(0, 0, 0))
B <- matrix(c(10, 0, 0))
C <- matrix(c(10, 10, 0))
D <- matrix(c(0, 10, 0))

cam1 <- matrix(c(5, 5, 1000))
cam2 <- matrix(c(100, 100, 1200))

lookback_vector <- cam1 - cam2


