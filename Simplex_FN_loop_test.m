% The following is the simulation test file for the Simplex_FN function, in
% which the it is run repeatedly and the minimum value it
% finds after each run is recorded. Graphical output of the results from 
% all runs is shown at the end of the simulation. 

% Desired global min: f(1,1) == 0


clc
% Placeholder values for minimum value and coordinates.
absolute_min_ver = [1000,1000];
absolute_min_value = 100000;

% Stores each set of minimum coordinates
x_values = [];
y_values = [];

for i= 1:300
[a,b] = simplex_FN;

% Replace absolute min parameters if necessary
if a<absolute_min_value
    absolute_min_value = a;
end

if b<absolute_min_ver
    absolute_min_ver = b;
end

% Append parameters from current iteration to appropriate lists
x_values = [x_values, b(1)];
y_values = [y_values, b(2)];
end

% Graphing and console display procedure
disp("SIMULATION MIN VALUE: " + absolute_min_value)
disp("SIMULATION MIN VERTEX: " + absolute_min_ver)

plot(x_values, y_values, 'bo');
axis([-0, 15, 0, 15]);