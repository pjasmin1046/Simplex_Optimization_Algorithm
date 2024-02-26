% The following is designed to perform simplex method optimization on a
% test function (in this case the Rosenbrock function) to identify the
% minimum point and value (in this case f(1,1) == 0). A starting point and
% subsequent equilateral triangle of points is instantiated. While the step
% size is still larger than 1000th its initial size, the highest point on
% the equilateral triangle (as evaluated through the test fn) is reflected
% over the centoid of said triangle. The process repeats until a minimum
% value is converged upon. The coordinates and fn value at the minima is
% returned. 


function [min_fn_value, min_vertex] = simplex_FN()
clc
syms a b step_current step_0 a_0 b_0 

% Test Function (Rosenbrock Fn)
f = @(a,b) 100*(b - a.^2).^2 + (1 - a).^2;

% Pertinent Var. Instantiation
step_0 = rand*4 +1; % Initial Step Size
a_0 = rand*4 +1;    % Initial start point coordinates
b_0 = rand*4 +1;
step_current = step_0; % Initial Step Size
old_vector = [];
current_vector = [];
new_vertex = [];

% Initial triangle instantiation (ensures algorithm starts with equilateral
% triangle)
vertices = {[],[],[]};
vertices{1} = [a_0, b_0];
vertices{2} = [a_0 + step_0, b_0];
vertices{3} = [a_0 + 0.5*step_0, b_0 + 0.87*step_0];

% Arrays of vertex X and Y values
x_values = [vertices{1}(1), vertices{2}(1), vertices{3}(1)];
y_values = [vertices{1}(2), vertices{2}(2), vertices{3}(2)];


% While Loop iterates until step size is a thousandth of initial
while (step_current/step_0 > .001)

    % Archive and transfer vectors (valid for all iterations after the
    % first)
    old_vector = current_vector;
    current_vector = [];

    results = [f(vertices{1}(1),vertices{1}(2)) , f(vertices{2}(1),vertices{2}(2)) , f(vertices{3}(1),vertices{3}(2))];
    %disp("Results: " + results)
    [max_value, max_index] = max(results);

    % Find centroid, reflect highest point over the centroid, establish 
    % new equilateral triangle.
   
    % vertices is a cell array containing the three points in the triangle
    centroid = (vertices{1} + vertices{2} + vertices{3}) / 3;
    vector_to_highest = vertices{max_index} - centroid;
    reflected_vector = -1 * vector_to_highest;
    new_vertex = centroid + reflected_vector;
    
    % Update coordinate arrays and current vector
    x_values = [x_values, new_vertex(1)];
    y_values = [y_values, new_vertex(2)];
    current_vector = [new_vertex(1) - vertices{max_index}(1), new_vertex(2) - vertices{max_index}(2)];
    
    % Ensures max_index is valid
    if (max_index > 3 || max_index < 1)
        error('max_index is out of valid range.');
    end

    % Determines when to reduce step size: If its not the first iteration
    % (old_vector not empty) and the new directions of travel in X and Y 
    % for the next iteration are the exact opposite direction it came from.
    if(~isempty(old_vector) && current_vector(1) * old_vector(1) < 0 && current_vector(2) * old_vector(2) < 0)
        step_current = step_current * 0.5;
    end

    vertices{max_index} = new_vertex;

 end


% RETURN VALUES
min_vertex = new_vertex;
min_fn_value = f(new_vertex(1), new_vertex(2));


end