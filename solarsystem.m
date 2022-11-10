function [p, v] = solarsystem(p, v, mass, stop_time, hide_animation)
% SOLARSYSTEM Solve the gravitational dynamics of n bodies.
%
% SOLARSYSTEM(p, v, mass, stop_time) receives the initial position, initial
% velocity, and mass, and simulate for stop_time seconds. The inputs p and
% v are N-by-2 matrices where the Nth row refers to the Nth celestial
% body. The two columns are the X and Y values of position and velocity,
% respectively. The input mass is an N-by-1 vector where the Nth item is
% the mass of the Nth celestial body.
%
% [p, v] = SOLARSYSTEM(...) returns the final position and final velocity
% of each object in the same format as the input. This will be used during
% marking to test the accuracy of your program.
%
% SOLARSYSTEM(..., hide_animation) is an optional flag to indicate whether
% the graphical animation may be hidden. This is an advanced feature for
% students who are aiming for a high level of achievement. During marking,
% when the computation speed of your program is being tested, it will be
% run with the hide_animation flag set to true. This allows your program to
% skip the drawing steps and run more quickly. 
%

if nargin < 5
    hide_animation = false;
end
% Write your code here
[n,b] = size(p);            % Find how many planets is running
% Define constants
G = 6.673e-11;              % Gravitational constant (Nm^2kg^-2)
t = 0;                      % Set the start time
deltaT = 100;               % Simulation timestep (s)
figure();                   % Creates figure
tick = 0;                   % Set the ploting step
% Decide wether is 2D or 3D
if b > 2
% For 3D planets ========================================================================================================================================
k = {'r.', 'c.', 'b.', 'y.', 'r.', 'y.', 'g.', 'c.', 'b.'};                 % Allows it to chnage the planets' colours
    for l = 1:numel(mass)
        r = log(mass(l)) / 1;                                               % Determine the size of each planets
        h(l) = plot3(p(l, 1), p(l, 2), p(l, 3), k{l}, 'MarkerSize', r);     % Plot each planets in its initial position
        hold all;
        axis equal;
        R = 2.2e11;                                                         % Set the maximal radius between the planets
        xlim([-R, R]);
        ylim([-R, R]);
        zlim([-R, R]);
        A(l) = animatedline(p(l,1), p(l,2), p(l,3));                        % Anatation of the plot
        set(gca, 'color', '0.5, 0.5 ,0.5', 'Visible', 'off');
        grid on;   
    end
    while t < stop_time
        a = zeros(n,b);                                                     % Calculates the position of the planets
        for q = 1:n
            for w = 1:n
                if w ~= q
                    a(q, :) = a(q,:) + (G * mass(q) * mass(w) * (p(w,:) - p(q,:)) / norm(p(w,:) - p(q,:)).^3) / mass(q);
                end
            end
            v(q,:) = v(q,:) + a(q,:) * deltaT;
            p(q,:) = p(q,:) + v(q,:) * deltaT;
        end
        t = t + deltaT;                                                     % Finding the time takes the plants to running,
        tick = tick + 1;                                                    % Update the position of the plenets in every 1000 eeee,
        if tick == 3000                                                     % Update the position of the planets
            for l = 1:numel(mass)
                set (h(l), 'XData', p(l, 1), 'YData', p(l, 2), 'ZData', p(l, 3));
                addpoints(A(l), p(l,1), p(l,2), p(l,3));
                drawnow limitrate;
            end
            tick = 0;
        end
    end
% End 3D ================================================================================================================================================
else %===================================================================================================================================================
% For 2D planes % =======================================================================================================================================
k = {'r.', 'c.', 'b.', 'y.', 'r.', 'y.', 'y.', 'c.', 'c.'};                 % Allows it to chnage the planets' colours
    for l = 1:numel(mass)
        r = log(mass(l)) / 1;                                               % Determine the size of each planets
        h(l) = plot(p(l, 1), p(l, 2), k{l}, 'MarkerSize', r);               % Plot each planets in its initial position
        hold all;
        axis equal;
        R = 2.2e11;                                                         % Set the maximal radius between the planets
        xlim([-R, R]);
        ylim([-R, R]);
        A(l) = animatedline(p(l,1), p(l,2));                                % Anatation of the plot
        set(gca, 'color', '0.5, 0.5 ,0.5', 'Visible', 'on');
        grid on;
    end
    while t < stop_time
        a = zeros(n,b);                                                     % Calculates the position of the planets
        for q = 1:n
            for w = 1:n
                if w ~= q
                    a(q, :) = a(q,:) + (G * mass(q) * mass(w) * (p(w,:) - p(q,:)) / norm(p(w,:) - p(q,:)).^3) / mass(q);
                end
            end
            v(q,:) = v(q,:) + a(q,:) * deltaT;
            p(q,:) = p(q,:) + v(q,:) * deltaT;
        end
        t = t + deltaT;                                                     % Finding the time takes the plants to running,
        tick = tick + 1;                                                    % Update the position of the plenets in every 1000 eeee,
        if tick == 3000                                                     % Update the position of the planets
            for l = 1:numel(mass)
                set (h(l), 'XData', p(l, 1), 'YData', p(l, 2));
                addpoints(A(l), p(l,1), p(l,2));
                drawnow limitrate;
            end
            tick = 0;
        end
    end
% End 2D ================================================================================================================================================ 
end % End the If statement ==========================================================================================================================
    
end % End the Function ==================================================================================================================================