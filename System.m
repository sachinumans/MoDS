clear all; clc;
%% Constants
    %%Gravitational parameters
    g = 9.81; %m^3/kg/s^2

    %%Fluid parameters
    rho = 997; %kg/m^3
    P_atm = 101.325; %Pa
    dyn_vis = 8.90*10^(-4); %Pa s
    
    %%System parameters - fluid domain
        %Tanks and resevoir
        r0_R = 1; %m
        r1 = 1; %m
        r2 = 1.5; %m
        r3 = 2; %m
        
        %Tubes
        rt1 = 0.1; %m
        rt2 = 0.2; %m
        rt3 = 0.3; %m
        rt4 = 0.15; %m
        rtt = 0.1; %m
        rtOut = 0.05; %m
        h1 = 1; %m
        
        L1 = 0.7; %m
        L2 = 0.9; %m
        L3 = 4; %m
        L4 = 0.9; %m
        Lout = 0.3; %m
        
        %Sensors
        ls1 = 1; %m
        ls2 = 1.5; %m
        ls3 = 3; %m
        ls4 = 1; %m
        
        
    %%System parameters - mechanical domain
        tau = 0.3;
        R1 = 0.02; %m
        R2 = 0.08; %m
        J = 0.25; %kg m^2
        
    %%System parameters - electrical domain
        Kr = 0.3;
        C = 5; %F
        R = 2000; %ohm
        
    %%Dependent constants
        beta3 = (pi*rt3^4)/(8*dyn_vis*L3);
        beta4 = (pi*rt4^4)/(8*dyn_vis*L4);
        betaT = (pi*rtt^4)/(8*dyn_vis*L4);

save("SystemConstants.mat")