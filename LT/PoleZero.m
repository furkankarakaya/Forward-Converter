Co = 660e-6;
Rload = 8/5;
Resr = 17.67e-3;

wp = 1/(Rload*Co);
wz = 1/(Resr*Co);
s = tf('s');
Uncompenstf =  3.876*(1+s/wz)/(1+s/wp);
bode(Uncompenstf);