% Usiamo il comando musyn

nmeas = 3; % penso uscite della P che vanno al controllore
ncont = 2; % penso ingresso della P proveniente da K
% R dal file muanalysis
 [K_DK, CLperf] = musyn(R,nmeas,ncont);

% K_DKmin = minreal(K_DK);
% figure()
Gcl_DK_nom = feedback(Gtot*K_DK,eye(3),-1);
% step(Gcl_DK_nom*[0.5 0 0]',20);

% Sul sistema perturbato
figure()
Gcl_DK = feedback(Gtot_p*K_DK,eye(3),-1);
step(Gcl_DK*[1 0 0]','b',Gcl_DK_nom*[1 0 0]','r',20);
title("Step sul sistema nominare e perturbato con controllore ottenuto con DK-iteration");


