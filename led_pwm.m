C = 1e-7;

R1 = linspace(10e3,90e3,30);
Rpot = linspace(0,80e3,30);
[R_1,R_pot] = meshgrid(R1,Rpot);

thigh = .9 * R_1 * C;
tlow = .7 * R_pot * C;
D = thigh ./ (tlow + thigh);

D_green = [0 5 10 20 40 80 100]'/100;
D_green_new = [D_green(1:2); (D_green(2:end-2) + D_green(3:end-1))/2; D_green(end-1:end)];
RGB = [ 255 0 0;    % red
        255 0 0;    % red
        255 100 0;  % red-orange
        255 150 0;  % orange
        255 255 0;  % yellow
        200 255 0;  % yellow-green
        0 255 0;    % green
        0 255 0];   % green
RGB = RGB / 255;

N = 128;

close all

figure
contourf(R_1,R_pot,D)
colormap(gray)
xlabel('Trim Resistor (Ohms)')
ylabel('Potentiometer Resistance (Ohms)')
title('Duty Cycle')
colorbar

% red => D, green => 1-D
figure
contourf(R_1,R_pot,D,D_green)
colormap(interp1(D_green_new,RGB,sort(D(:))));

xlabel('Trim Resistor (Ohms)')
ylabel('Potentiometer Resistance (Ohms)')
title('D = red')
colorbar

% green => D, red => 1-D
figure
contourf(R_1,R_pot,D,1-D_green)
colormap(interp1(1-D_green_new,RGB,sort(D(:))));
xlabel('Trim Resistor (Ohms)')
ylabel('Potentiometer Resistance (Ohms)')
title('D = green')
colorbar

figure
contourf(R_1,R_pot/max(R_pot,[],'all')*60,D,1-D_green)
colormap(interp1(1-D_green_new,RGB,sort(D(:))));
xlabel('Trim Resistor (Ohms)')
ylabel('Minutes Remaining')
title('D = green')
colorbar
grid on
