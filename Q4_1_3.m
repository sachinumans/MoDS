clear all; clc; close all;
%% Simulation settings
simT = [0, 300];

%% Initial state
l_R0 = 3;
l_10 = 1;
l_20 = 3;
l_30 = 2;
thetad0 = -1;
uc0 = 0.1;
x0 = [l_R0; l_10; l_20; l_30; thetad0; uc0; 1; 1; 0];

%% Input
u = @(t)(sin(t)+1)*0.5 + 0.005*t;

ut = linspace(simT(1), simT(2), 50);
U = u(ut);

%% Simulation
C = load("SystemConstants.mat");
% opts = odeset('RelTol',1e-2,'AbsTol',1e-4);
[t,x] = ode45(@(t,x) StateSpace(t,x,ut, U, C), simT, x0);%, opts);

Output = pi*C.rtOut*sqrt(2*C.g*(x(:,4)+C.Lout));
OutputMask = x(:,4) > 0;
Output = Output.*OutputMask;
%% Plotting
TimeNow = strjoin(["\Images\" strjoin(string(fix(clock)), "_")],"");
mkdir(strjoin([pwd TimeNow], ""));

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
savefig(gcf, strjoin(string([pwd TimeNow "\WL"]), ""));

figure("Name","Input, Output");
subplot(1,2,1);
plot(t, u(t));
title('$w_{in}$', "Interpreter", "latex")
subplot(1,2,2);
plot(t, Output);
title('$w_{out}$', "Interpreter", "latex")
savefig(gcf, strjoin(string([pwd TimeNow "\InOut"]), ""));

figure("Name","Mechanical and electrical domain");
subplot(1,2,1);
plot(t, x(:,5));
title('$\dot \theta_2$', "Interpreter", "latex")

subplot(1,2,2);
plot(t, x(:,6));
title('$u_c$', "Interpreter", "latex")
savefig(gcf, strjoin(string([pwd TimeNow "\Mech"]), ""));

%% Debug checks
%Total fluid in system
Totalfluid = pi*C.r1^2 * x(:, 2) + pi*C.r2^2 * x(:, 3) + pi*C.r3^2 * x(:, 4) + ...
    1/3*pi* x(:, 1).*(C.r0_R^2 + (C.r0_R*(C.r0_R+x(:, 1))) + (C.r0_R+x(:, 1)).^2);
TotalfluidIn = sum((t(2:end) - t(1:end-1)).*u(t(1:end-1)));
TotalfluidOut = sum((t(2:end) - t(1:end-1)).*Output(1:end-1));

figure("Name","Total fluid debug");
subplot(2,2,1);
plot(t, Totalfluid, t(end), Totalfluid(1) + TotalfluidIn - TotalfluidOut, '^');
title('Total fluid', "Interpreter", "latex")
subplot(2,2,2);
plot(t, u(t));
title('$w_{in}$', "Interpreter", "latex")
subplot(2,2,3);
plot(t, Output);
title('$w_{out}$', "Interpreter", "latex")






