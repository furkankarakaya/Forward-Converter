VsystemMin = 33;
VsystemMax = 60;
Vref = 2.5;
Rosc = 301e3;
fosc = 4100e3/(Rosc/9.125e3 +1);
R1 = 240e3;
R2 = 10e3;
Rdelay = 100e3; % Xk -> Xns
tdelay = Rdelay*1e-12;
SD_Vsec = VsystemMin*R2/(R1+R2);
Vout = 5;
n = 4/10; %Ns/Np
DforminV = Vout/VsystemMin/n;
Rt = 10e3;
k = 1.11 - 5.5e-7*fosc;
SS1 = SD_Vsec*(DforminV + tdelay*fosc)/(k*0.522);
Rb = SS1/(2.5-SS1)*Rt;
Rthev = Rb*Rt/(Rb+Rt);
DformaxV = Vout/VsystemMax/n;
X = 0.44;
Rx = (VsystemMax-VsystemMin)/(SS1*(X-1))*Rthev;
Rx = round(Rx,2,'significant');
% correction
SS2 = SS1 - (VsystemMin-SS1)*Rthev/Rx;
Rb = SS2/(2.5-SS2)*Rthev;
Rthev2 = Rb*Rt/(Rb+Rt);
Rb = Rb*(Rthev/Rthev2);
Rt = Rt*(Rthev/Rthev2);
% SSmaxDC
V = 33:3:60;
SD_Vsec = V*R2/(R1+R2);
SSMaxDC = Vref*Rb/(Rb+Rt);
DClamp = k*0.522*(SSMaxDC./SD_Vsec)-tdelay*fosc;
Dideal = Vout./V/n;

plot(V,DClamp,V,Dideal);
legend('Clamp','Ideal');