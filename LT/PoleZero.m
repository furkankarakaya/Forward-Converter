close all
Co = 660e-6;
Rlight = 5/0.8;
Rheavy = 5/9;
Resr = 17.67e-3;

% Light Tf
wplight = 1/(Rlight*Co);
wz = 1/(Resr*Co);
s = tf('s');
LightUncompenstf =  1*5.18*(1+s/wz)/(1+s/wplight);

% Heavy Tf
wpheavy = 1/(Rheavy*Co);
s = tf('s');
HeavyUncompenstf =  1*5.18*(1+s/wz)/(1+s/wpheavy);

%Comp
R1 = 1e3;
R2 = 5e3;
Ak = R2/R1;
Cont = Ak;
wpc = 2*pi*250e3;
wzc = 0;%sqrt(wpheavy*wplight);
Cont = Cont*(1+wzc/s)/(1+s/wpc);
Cont = 1/(s/wpc);
LightCompenstf = (LightUncompenstf*Cont);


HeavyCompenstf = (HeavyUncompenstf*Cont);

hold all
opts = bodeoptions('cstprefs');
opts.FreqUnits = 'Hz';
bode(LightUncompenstf,opts);
bode(LightCompenstf);
bode(HeavyUncompenstf);
bode(HeavyCompenstf);
bode(Cont);
legend('Unc - Light','Comp - Light','Unc - Heavy','Comp - Heavy','Cont');
%legend('Comp - Light','Comp - Heavy');