clear all; clc;
%% Simulation settings
simT = [0, 60];

%% Initial state
l_R0 = 10;
l_10 = 3;
l_20 = 1;
l_30 = 2;
thetad0 = 0.5;
uc0 = 0.1;
x0 = [l_R0; l_10; l_20; l_30; thetad0; uc0; 1; 1; 1];

%% Input
u = @(t)(sin(t)+1)*5;

ut = linspace(simT(1), simT(2), 50);
U = u(ut);

%% Simulation
C = load("SystemConstants.mat");
opts = odeset('RelTol',1e-2,'AbsTol',1e-4);
[t,x] = ode45(@(t,x) StateSpace(t,x,ut, U, C), simT, x0, opts);

Output = pi*C.rtOut*sqrt(2*C.g*(x(:,4)+C.Lout));
OutputMask = x(:,4) > 0;
Output = Output.*OutputMask;
%% Plotting
figure("Name","Water levels");
subplot(2,2,1);
plot(t, x(:,1));
title('Reservoir')

subplot(2,2,2);
plot(t, x(:,2));
title('Tank 1')

subplot(2,2,3);
plot(t, x(:,3));
title('Tank 2')

subplot(2,2,4);
plot(t, x(:,4));
title('Tank 3')

figure("Name","Input, Output");
subplot(1,2,1);
plot(t, u(t));
title('w_{in}')
subplot(1,2,2);
plot(t, Output);
title('w_{out}')

figure("Name","Mechanical and electrical domain");
subplot(1,2,1);
plot(t, x(:,5));
title('\dot \theta_2', "Interpreter", "latex")

subplot(1,2,2);
plot(t, x(:,6));
title('u_c')