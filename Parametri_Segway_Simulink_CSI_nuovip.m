%% In this section the parameters of the equation on motion (EoM) are specified

% Parameters
body_mass = 5;                      % [kg]
wheel_mass = 1.22;                  % [kg]
center_of_mass = 0.2924;            % [m]
wheel_radius = 0.13;                % [m]
semiaxis_wheels = 0.496/2;          % [m]
gravity = 9.8;                      % [m/s^2]


% Pack parameters into a structure for better organization
eom_params = struct('wheel_radius', wheel_radius, ...
                'body_mass', body_mass, ...
                'wheel_mass', wheel_mass, ...
                'semiaxis_wheels', semiaxis_wheels, ...
                'gravity', gravity, ...
                'center_of_mass', center_of_mass);

% Initial conditions
     x_0 = 0;  % Initial position
    dx_0 = 0;  % Initial velocity
 theta_0 = 0;  % Initial angular position
dtheta_0 = 0;  % Initial angular velocity
   phi_0 = 0*pi/180;  % Initial angular position
  dphi_0 = 0;  % Initial angular velocity

