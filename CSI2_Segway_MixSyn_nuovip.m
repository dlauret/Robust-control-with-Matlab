 %% Mixed Sensitivity
% Abbiamo il sistema dal workspace: Gtot
% Controllo Hinf --> mixsyn
Wp(1) = 0.1*makeweight(1e3,[0.25,81],2.5,0,2); % [freq,valore]
Wp(2) = 0.1*tf(0.5);
Wp(3) = 1*makeweight(0.01,[10,0.05],0.1,0,2);

% Matrice peso per S
W1 = blkdiag(Wp(1), Wp(2), Wp(3));

% Matrice peso per KS
wu = 0.01;
W2 = tf(blkdiag(wu,wu)); % matrice diagonale con wu nella diagonale

[K_MS,CLaug1,GAM,~] = mixsyn(Gtot,W1,W2,[]);
% GAM = 0.99 --> rispetta la NP (perche' <1)

% Calcoliamo Sensitivita' con Kms del mixsyn: S_ms
S_struct_MS = loopsens(Gtot, K_MS); % feedback negativo
So_MS = S_struct_MS.So;
Si_MS= S_struct_MS.Si;

% sigmaplot(1/(W1),'b--',So_MS,'r')
% legend("1/W1","S")
% % Plot valori singolari caso S
% figure();
% sigmaplot(GAM/(W1),'b--',So_MS,'r')
% legend("GAM/W1","S")
% 
% % stessa cosa per KS
% figure();
% sigmaplot(GAM/(W2), K_MS*So_MS)
% legend("GAM/W2","K*So")

% Sistema CL
Gcl_MS = feedback(Gtot*K_MS,eye(3),-1); % retroazione negativa
figure(1);
step(Gcl_MS*[1 0 0]',40);
title("Step mixsyn");

%% Sforzo di controllo
% figure()
% step(K_MS*So_MS*[0.1 0 0]',1);
% title("Sforzo di controllo 1: K*So");
