R_dk = augw(Gtot_p,W1,W2,[]);
N_p_dk = lft(R_dk,K_DK);

%% Comando robstab per RS e altri comandi
[stabmarg,wcu_stab] = robstab(N_p_dk) % mi da l'inverso del valore sing strutt.

% LowerBound: 0.9213
% UpperBound: 0.9232
% CriticalFrequency: 7.7853
% Il sistema puo' sopportare il 92% di incertezza rispetto a quella specificata
% rimanendo stabile
%%
% Adesso scaliamo le incertezze al massimo possibile per la stabilita'
N_p_maxunc_dk = uscale(N_p_dk,stabmarg.UpperBound);
N_p_maxunc_dk.Uncertainty.M
N_p_maxunc_dk.Uncertainty.Delta_a1
% Results:
% Uncertain real parameter "M" with nominal value 5 and variability [-9.23,9.23]%
% Uncertain LTI dynamics "Delta_a1" with 1 outputs, 1 inputs, and gain less than 0.923
pole(N_p_maxunc_dk) % Verifichiamo che sistema stabile con la max incertezza

%% Worst-case analysis, con wcu che e' il worst-case:
% caso in cui la piu' piccola perturbazione di M e Delta_attuatori
% rendono il sistema instabile --> Poli con Re = 0
% The structure wcu_stab contains the smallest 
% destabilization perturbation values for each uncertain element.
N_p_unst = usubs(N_p_dk,wcu_stab);
pole(N_p_unst)

%%
% Sensitivity to uncertain elements
optsS = robOptions('Sensitivity','On');
[stabmarg_S,~,infoS] = robstab(N_p_maxunc_dk,optsS);
infoS.Sensitivity
% Risultato:
% Delta_a1: 33
% Delta_a2: 33
%        M: 34
% The values in this field indicate how much a change
% in the normalized perturbation on each element affects 
% the stability margin. 
% For example, the sensitivity for M is 34.
% This value means that a given change dM in the normalized uncertainty range 
% of M causes a change of about 34% percent of that, or 0.34*dM, in the stability margin.
% The margin in this case is more sensitive to Delta_a1 e a2, 
% for which the margin changes by about 33% of the change in the normalized uncertainty range.


%%
% Plottiamo i valori singolari nominali e worst-case di N_p_maxunc_dk
% figure()
% wcsigmaplot(N_p_maxunc_dk,{0.1 100})

%% Nominale Performance - NP

% Estraiamo le incertezze
[P_dk,Delta,Blkstruct_RS,NORMUNC] = lftdata(R_dk);
% La P e' quella della struttura Delta-P-K

% Creiamo la matrice N = lower LFT di P e K
N_dk= lft(P_dk,K_DK);

hinfnorm(N_dk(18:22,18:20)) % = 1.6409, NON e' NP

