% Prendiamolo dal mixsyn -> Kms

R = augw(Gtot_p,W1,W2,[]); % usata in hinfsyn ma ora con G perturbata

N_p = lft(R,K_MS); % 5x3 (LA MATRICE N_p HA DENTRO SIA IL CONTROLLORE CHE LE INCERTEZZE)

% Comando robstab per RS e altri comandi
[stabmarg,wcu_stab] = robstab(N_p) % mi da l'inverso del valore sing strutt.

% LowerBound: 0.9620
% UpperBound: 0.9639
% CriticalFrequency: 6.6620
% Il sistema non e' RS, puo' sopportare pero' il 96% dell'incertezza
% specificata

%% Adesso scaliamo le incertezze al massimo possibile per la stabilita'
N_p_maxunc = uscale(N_p,stabmarg.LowerBound);
N_p_maxunc.Uncertainty.M;
N_p_maxunc.Uncertainty.Delta_a1;
% Results:
% Uncertain real parameter "M" with nominal value 5 and variability [-9.51,9.51]%
% Uncertain LTI dynamics "Delta_a1" with 1 outputs, 1 inputs, and gain less
% than 0.951
pole(N_p_maxunc); % Verifichiamo che sistema stabile con questa max incertezza scalata
robstab(N_p_maxunc)

%% Worst-case analysis, con wcu che e' il worst-case:
% caso in cui la piu' piccola perturbazione di M e Delta_attuatori
% rendono il sistema instabile --> Poli con Re = 0 e parte immaginaria
% The structure wcu_stab contains the smallest 
% destabilization perturbation values for each uncertain element.
N_p_unst = usubs(N_p,wcu_stab);
pole(N_p_unst)
% Esempio poli immaginari: 0 +- 0.0662i
  
%% Sensitivity to uncertain elements
optsS = robOptions('Sensitivity','On');
[~,~,infoS] = robstab(N_p,optsS);
infoS.Sensitivity
% Risultato:
% Delta_a1: 36
% Delta_a2: 36
%        M: 27
% The values in this field indicate how much a change
% in the normalized perturbation on each element affects 
% the stability margin. 
% For example, the sensitivity for M is 27.
% This value means that a given change dM in the normalized uncertainty range 
% of M causes a change of about 27% percent of that, or 0.27*dM, in the stability margin.
% The margin in this case is more sensitive to Delta_a1 e a2, 
% for which the margin changes by about 36% of the change in the normalized uncertainty range.


%% Plottiamo i valori singolari nominali e worst-case di N_p
% NON si può fare perche' non RS
f1 = figure();
wcsigmaplot(N_p_maxunc,{0.1 100})
exportgraphics(f1,".\wcsigmaplot_N_p_maxunc.png")

%% Performance su N_p_maxunc
% Studiamola su N_p_maxunc cioe' dove abbiamo scalato l'incertezza
% perche' senno' non ha senso dato che non e' rispettata la stabilita'
% nel set di incertezze originale

% Come gamma prendiamo il valore (da dB a lineare) da:
% a) hinfnorm(N_p) = 0.99, prende il caso nominale, quindi con N perturbata 
%    robgain restituisce valore 0 (non e' RP mai, con nessuna variazione di performance)
% b) max di sigma(N_p_maxunc) prende casi perturbati casuali
%    = circa 7.1db -> 2.27, le perturbazioni sono troppo alte
%    --> con questo ci da Lower di circa 0.43, quindi ancora dovremmo
%    abbassare le incertezze al 43% rispetto al range attuale (
% c) max di wcsigmaplot su N_p_maxunc, sarebbe circa 52 db
%    52.7db -> 430 circa
%    Con questo abbiamo Lower e Upper > 1 (circa 1.22)
%    quindi RP con questo gamma

gamma = 446;
[perfmarg,wcu_perf] = robgain(N_p_maxunc,gamma)
% Chiaramente nel caso c) ci da che e' sempre rispettata la prestazione
% perche' come gamma abbiamo messo il valore massimo di guadagno possibile
% del sistema
% Risultato: LowerBound: 1.2236
%            UpperBound: 1.2256

% Da documentazione "Robustness and worst-case analysis":
% Robust Performance Margin:
% The robust performance margin for a given gain, γ, is the maximum amount 
% of uncertainty the system can tolerate while having a peak gain less than γ.

%% Adesso proviamo con il caso b)
gamma_b = 2.27;
[perfmarg_b,~] = robgain(N_p_maxunc,gamma_b);
% LowerBound: 0.4392

% Comandi: uscale e usubs
% Diminuiamo l'incertezza normalizzata al 43% (bound ricevuto prima)
% This result means that there is a perturbation of only about 43%
% of the uncertainty specified in N_p with peak gain exceeding 1.78 (gamma)
factor = perfmarg_b.LowerBound;
N_p_scaled = uscale(N_p_maxunc,factor);
% Si vede la scalatura del range di incertezza dei parametri incerti
% Delta_a1: Uncertain 1x1 LTI, peak gain = 0.423, 1 occurrences
% Delta_a2: Uncertain 1x1 LTI, peak gain = 0.423, 1 occurrences
% M: Uncertain real, nominal = 5, variability = [-4.23,4.23]%, 15 occurrences

% Facendo robgain su N_p_scaled torna la RP (circa 1)
[perfmarg_b_scaled,~] = robgain(N_p_scaled,gamma_b)
% UpperBound: 1.88, quindi e' performante su un certo range di frequenze
% e in questa scalatura

%% Worst-case gain
% wcu_perf contiene le perturbazioni delta ed M che permettono di avere
% come gain massimo del sistema N_p gamma=446
N_p_maxperf = usubs(N_p_maxunc,wcu_perf);
getPeakGain(N_p_maxperf,1e-6) % = 446
%%
% Quindi come risultato (= 22) torna perche' abbiamo sostituito il
% worst case di performance (con incertezza), quindi sara' uguale al gamma del caso c)

% Vediamo con uno step cosa significa avere il worst-case di performance 
% e quindi gain
figure()
step(N_p_maxunc.NominalValue*[1 1 1]',N_p_maxperf*[1 1 1]',50) % uscite = 5 perche' sisetma con i pesi (N_p)
legend('Nominal','Peak Gain = 22')

% Risultato: Molte oscillazioni, infatti il sistema non è robustamente performante






