close all
clear all
clc

%% Modello nominale, senza incertezze

% Scrittura delle matrici A B C D e conversione in fdt
% z = [x theta phi]'
% var di stato q = [z dz]'
% dq = A*q + B*tau
% y = C*q + D*tau

% Definiamo le  variabili del sistema
M = 5;
m = 1.22;
L = 0.2924;
r = 0.13;
a = 0.496/2;
g = 9.8;

% Definiamo le matrici necessarie per la scrittura della froma di stato
Ml = [2*(3/2*m+1/2*M) 0 -m*r+M*L;
      0 2*(3/2*m*a*a +1/6*M*a*a+1/4*M*L*L) 0;
      -m*r+M*L 0 2*(1/2*m*r*r +2/3*M*L*L)];
Ml_inv = inv(Ml);

Pl = [0 0 0;
      0 0 0;
      0 0 -M*g*L];

Tl = [1/r 1/r;
     a/r -a/r;
     -1 -1];

A21 = -Ml\Pl; % = -Ml_inv*Pl
As = [0 0 0 1 0 0;
     0 0 0 0 1 0;
     0 0 0 0 0 1;
     A21(1,1) A21(1,2) A21(1,3) 0 0 0;
     A21(2,1) A21(2,2) A21(2,3) 0 0 0;
     A21(3,1) A21(3,2) A21(3,3) 0 0 0];

B2 = Ml\Tl; % = Ml_inv*Tl
Bs = [0 0;
     0 0;
     0 0;
     B2(1,1) B2(1,2);
     B2(2,1) B2(2,2);
     B2(3,1) B2(3,2)];

Cs = [1 0 0 0 0 0;
     0 1 0 0 0 0;
     0 0 1 0 0 0];

Ds = 0*eye(3,2);

Segway = ss(As,Bs,Cs,Ds);

Gseg = tf(Segway);

% Attuatori nominali
K0 = 1.08;
T0 = 5e-3;
Gnom = tf(K0,[T0 1]);
Ga_nom = blkdiag(Gnom,Gnom);
Ga_nom_ss = ss(Ga_nom); Ga_nom_ss = minreal(Ga_nom_ss);


% Altro modo per trovare fdt totale -> moltiplicazione delle due fdt
Gtot = Gseg*Ga_nom; % cosi' ho 9 stati, con connect ne ho 8
Gtot = ss(Gtot);
Gtot = minreal(Gtot); % per levare spazi non controllabili o osservabili -> ho 8 stati come con connect
% In entrambi i casi i poli sono uguali

%% Controllore LQG 1 dof

a = Gtot.A; % 8x8
b = Gtot.B; % 8x2
c = Gtot.C; % 3x8
d = Gtot.D; % 3x2

nx = 8; ny = 3; nu = 2;

% Parte 1: LQR
Q = c'*c;%10*eye(nx); % peso stati
R = 1*eye(nu); % peso ingressi
Klqr = lqr(a,b,Q,R);

% Parte 2: Stimatore di Kalman
Qn = 1*eye(nu); % rumore d'ingresso
Rn = 1*eye(ny); % rumore uscite

% prova aumentando il ss per avere come ingressi il rumore
Gtot_noise = ss(a,[b eye(8,2)],c,[d 0*eye(3,2)]);

[kest,L,P] = kalman(Gtot_noise,Qn,Rn);

% Parte 3: formare il regolatore LQG
K_LQG = -lqgreg(kest, Klqr);

% Sistema CL
Gcl_LQG = feedback(Gtot*K_LQG,eye(3)); % retroazione

% Step
figure(1)
step(Gcl_LQG*[1 0 0]');

% Funzione So ed Si
S_struct_LQG = loopsens(Gtot, K_LQG); % feedback
So_LQG = S_struct_LQG.So; % (I + GK)^-1
Si_LQG = S_struct_LQG.Si; % (I + KG)^-1


figure()
sigma(So_LQG);
title("Valori singolari S");

% Sforzo di controllo
figure()
step(K_LQG*So_LQG*[0.1 0 0]');
title("Sforzo di controllo 1: K*So");


figure()
step(Si_LQG*K_LQG*[0.1 0 0]');
title("Sforzo di controllo 2: Si*K");

