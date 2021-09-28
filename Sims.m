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
        r0_R = 3; %m
        r1 = 2; %m
        r2 = 2.5; %m
        r3 = 0.5; %m
        
        %Tubes
        rt1 = 0.1; %m
        rt2 = 0.05; %m
        rt3 = 0.3; %m
        
        L1 = 0.7; %m
        L2 = 0.9; %m
        L3 = 4; %m
        
    %%System parameters - mechanical domain
        R1 = 0.02; %m
        R2 = 0.08; %m
        J = 0.025; %kg m^2
        syms eps(x)
        eps(x) = sqrt(x+1.5)/(x+1.5); %Drag function
        
    %%System parameters - electrical domain
        Kr = 0.3;
        C = 5; %F
        R = 2000; %ohm
        
    %%Dependent constants
        A1 = pi*r1^2; %m^2
        A2 = pi*r2^2; %m^2
        beta3 = (pi*r3^4)/(8*dyn_vis*L3);
        
        
        
        
        