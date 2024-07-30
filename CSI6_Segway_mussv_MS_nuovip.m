% R fatta in muAnlysis 
% R = augw(Gtot_p,W1,W2,[]);
% Estraiamo le incertezze
[P,Delta,Blkstruct_RS,NORMUNC] = lftdata(R);
% La P e' quella della struttura Delta-P-K

% Creiamo la matrice N = lower LFT di P e K
N = lft(P,K_MS); % lower LFT N-Delta dim 22x20, 17 incertezze, 3 in, 5 out

%% RS
% Utilizziamo la N11 = N(1:17,1:17) che corrisponde
blk2 = [2 0; -15 0];
[mubnds,muinfo] = mussv(N(1:17,1:17), blk2);
muRS = mubnds(:,1); % prendiamo l'upper bound
[muRSinf,muRSw] = norm(muRS,inf); % ne calcoliamo la norma e la frerq
% plot
figure()
bodemag(muRS);
legend("μRS");
% Risultato: picco di mu = 0.336db = 1.039 (torna con l'inverso di robstab)
% Nel grafico corrisponde anche la frequenza critica della robstab
% Quindi NON RS

%% NP --> si usa N22
% Il sistema non e' nominalmente performante
hinfnorm(N(18:22,18:20)) % = 0.99 (corrisponde al GAM )
% Oppure con valore singolare strutturato
Blkstruct_NP = [3 5]; % 3 ingressi e 5 uscite
[mubnds,muinfo] = mussv(N(18:22,18:20), Blkstruct_NP);
muNP = mubnds(:,1); % prendiamo l'upper bound
[muRPinf,muRPw] = norm(muNP,inf); % ne calcoliamo la norma e la freq
% plot
figure()
bodemag(muNP);
legend("μNP");
% NP poiche' sempre < 1 (= 0db)

%% RP
% Adesso aggiungiamo i blocchi prestazione per la S,
% Non possiamo aggiungere quelli per la KS (controllo) perche' non e' quadrata la N
Blkstruct_RP = [2 0; -15 0; 3 5]; % reali (15 occorrenze di M), complesse (2 degli attuatori), performance (matrice piena)

[mubnds_RP,muinfo_perf] = mussv(N, Blkstruct_RP); % 20 righe, e tutte le col perche' ho considerato 
% come performance solo il il blocco W1
muNP = mubnds_RP(:,1);
[muRPinf2,muRPw2] = norm(muNP,inf); % ne calcoliamo la norma e la freq
% plot
figure()
bodemag(muNP);
legend("μRP");
% Non e' robustamente performante

%% Proviamo a scalre per vedere se torna la RP
% % Quindi usiamo quella con le incertezze scalate
% N_p_scaled2 = uscale(N_p,0.4); % 5x3
% % Estraiamo le incertezze
% [N_scaled,Delta_scaled,Blkstruct_scaled,NORMUNC_sca] = lftdata(N_p_scaled2);
% % N_scaled: 22x20
% % Delta_scaled: 17x17
% Blkstruct_RP2 = [-15 0; 2 0; 3 5];
% [mubnds_perf,muinfo_perf] = mussv(N_scaled, Blkstruct_RP);
% 
% muRP_perf = mubnds_perf(:,1);
% [muRPinf2,muRPw2] = norm(muRP_perf,inf); % ne calcoliamo la norma e la freq
% % plot
% figure()
% bodemag(muRP_perf);
