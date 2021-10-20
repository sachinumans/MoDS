function [dxdt] = StateSpace(t, x, ut, U, C) 
%% Controller
if 0==1
    if x(2)<C.ls1
        x(7) = 1;
        x(9) = 1;
    elseif x(2)>=C.ls1 && x(2)<C.ls2
        x(7) = 1;
        x(9) = 0;
    elseif x(2)>=C.ls2 && x(2)<C.ls3
        x(7) = 0;
        x(9) = 1;
    elseif x(2)>=C.ls3
        x(7) = 0;
        x(9) = 0;
    else
        print("Controller error for Tank 1")
    end
    if x(3)<C.ls4
        x(8) = 1;
    elseif x(3) >= C.ls4
        x(8) = 0;
    else
        print("Controller error for Tank 2")
    end
end
        
%% Derivation
u = interp1(ut,U,t); % Interpolate the data set (ut,U) at time t

%x = l_R, l_1, l_2, l_3, thetad2, uc, z1, z2, z3
ldotR = 1/(pi*(C.r0_R+x(1))^2)*(u - x(7)*pi*C.rt1^2*sqrt(2*C.g*(x(1)+C.L1))...
    - x(8)*pi*C.rt2^2*sqrt(2*C.g*(x(1)+C.L2)));
ldot1 = 1/(pi*C.r1^2)*(x(7)*pi*C.rt1^2*sqrt(2*C.g*(x(1)+C.L1))-C.betaT*(1-C.tau)...
    *(C.rho*C.g*(x(2)-x(3)))-x(9)*C.beta4*C.rho*C.g*(max((x(2)-C.h1), 0) ...
    + min((C.h1-x(3)), 0)));
ldot2 = 1/(pi*C.r2^2)*(x(8)*pi*C.rt2^2*sqrt(2*C.g*(x(1)+C.L2))+C.betaT*(1-C.tau)...
    *(C.rho*C.g*(x(2)-x(3)))+x(9)*C.beta4*C.rho*C.g*...
    (max((x(2)-C.h1), 0) + min((C.h1-x(3)), 0))-C.beta3*C.rho*C.g*(x(3)-x(4)));
ldot3 = 1/(pi*C.r3^2)*(C.beta3*C.rho*C.g*(x(3)-x(4))-pi*C.rtOut^2*sqrt(2*C.g*(x(4)+C.Lout)));
thetadd2 = 1/C.J/x(5)*(C.R2/C.R1)^2*fricFun(x(5))*C.betaT*C.tau*(1-C.tau)...
    *(C.rho*C.g*(x(2)-x(3)))^2+1/C.R*(C.Kr*x(6)+C.Kr^2*x(5));
udotc = -1/C.C/C.R*(x(6)+C.Kr*x(5));

%% Constraints
if (x(1)<=0) && (ldotR < 0)
    ldotR = 0;
end
if x(2) <= 0 && ldot1 < 0
    ldot1 = 0;
end
if x(3) <= 0 && ldot2 < 0
    ldot2 = 0;
end
if x(4) <= 0 && ldot3 < 0
    ldot3 = 0;
end

%% Return xdot
dxdt = [ldotR; ldot1; ldot2; ldot3; thetadd2; udotc; 0; 0; 0];
end

