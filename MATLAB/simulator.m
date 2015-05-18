% Quadcopter Simulator

% Clearing previous simulation variables
clear all;
clc;

% Enviromental and quad's constants 
g = 9.81;                       % gravity acceleration
m = 0.5;                        % mass in kg
L = 0.25;                       % length of the rods
k = 3e-6;                       % thrust coefficient
b = 1e-7;                       % torque due to drag coefficient
I = diag([5e-3, 5e-3, 10e-3]);  % moment of inertia
kd = 0.25;                      % drag coefficient

phi = 0;
psi = 0;
theta = 0;

weight = [0; 0; -g*m];

% Simulation analysis
t_start = 0;                    % Start time of the simulation
t_end = 5;                      % End time of the simulationh
dt = 0.001;                     % Steps

t_sim = t_start:dt:t_end;
N = numel(t_sim);

% Output values, recorded as the simulation runs
x = zeros(3,1);                 % mass position
v = zeros(3,1);                 % mass velocity
a = zeros(3,1);                 % mass acceleration

x_out = zeros(3,N);             % mass position
v_out = zeros(3,N);             % mass velocity
a_out = zeros(3,N);             % mass acceleration

omega = zeros(4, N);

% SIMULATION loop
index = 1;
for t = t_sim
    omega(:, index) = in();

    a = acceleration(phi, psi, theta, k, m, weight, omega(index));
    v = v + dt * a;
    x = x + dt * v;
    
    a_out(:, index) = a;
    v_out(:, index) = v;
    x_out(:, index) = x;
    
    index = index + 1;
end

% 2D plots (position, velocity, acceleration)
% figure;
% subplot(3,1,1);
% plot(t_sim, a_out(3, :), 'g', 'LineWidth', 5);
% grid;ylabel('Acc. in [m/s^2]');
% subplot(3,1,2);
% plot(t_sim, v_out(3, :), 'b', 'LineWidth', 5);
% grid;ylabel('Vel. in [m/s]');
% subplot(3,1,3);
% plot(t_sim, x_out(3, :), 'r', 'LineWidth', 5);
% grid;xlabel('Time in [s]');ylabel('Pos. in [m]');

% 3D simulation (position)
index = 1;
figure;
for index = 1:40:length(t_sim)
    visualize(x_out(1, index), x_out(2, index), x_out(3, index));
    printStatus();
    drawnow;
    if index < length(t_sim)
        clf;
    end
end