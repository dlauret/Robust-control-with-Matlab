%% Nuovo peso

% Scegliamo |W1| < |1/S|
% Equivalente ad |S| < |1/W1|

% Prova 1: minori di 1/S --> No NP
% Wp(1) = makeweight(1e5,[0.1,1.77],0.9,0,2); % [freq,valore]
% Wp(2) = makeweight(0.3,[0.01,0.5],0.9,0,2);
% Wp(3) = makeweight(0.01,[10,0.1],0.9,0,2);


% Prova 2: simili ad 1/S --> No NP e non diverge il controllo K_MS*S con wu = 0.02;
% Cambiando wu non e' RS
% Wp(1) = makeweight(1e5,[1,1],0.9,0,2); % [freq,valore]
% Wp(2) = makeweight(0.9,[0.01,0.95],0.99,0,2);
% Wp(3) = makeweight(0.025,[4,0.1],0.9,0,2);

% Prova 3: simili ad 1/S --> cambiando wu non e' RS
% Wp(1) = makeweight(1e10,[1,3],1.5,0,2); % [freq,valore]
% Wp(2) = makeweight(0.9,[0.01,0.95],0.99,0,2);
% Wp(3) = makeweight(0.025,[4,0.1],0.9,0,2);

% Prova 4: maggiori ad 1/S --> Non trova nemmeno il controllore
% Wp(1) = makeweight(1e10,[10,3],1.5,0,2); % [freq,valore]
% Wp(2) = tf(2);
% Wp(3) = makeweight(0.025,[1,0.1],1.2,0,2);

% Prova 5: maggiori ad 1/S --> Non trova nemmeno il controllore, non riesce
% Wp(1) = makeweight(1e20,[2,2],1.5,0,2); % [freq,valore]
% Wp(2) = tf(1.2);
% Wp(3) = makeweight(0.025,[2,0.1],1.2,0,2);


% Prova 6: proviamo ancora piu' bassi --> Quasi NP, si RS
% Wp(1) = makeweight(1e5,[0.001,0.8],0.5,0,2); % [freq,valore]
% Wp(2) = tf(0.5);
% Wp(3) = makeweight(0.001,[10,0.01],0.09,0,2);

% Prova 7: ancora più bassi --> SI NP, Ma troppo lento lo step (migliaia di seecondi)
% Wp(1) = 0.1*makeweight(1e5,[0.001,0.8],0.5,0,2); % [freq,valore]
% Wp(2) = tf(0.005);
% Wp(3) = makeweight(0.001,[10,0.01],0.09,0,2);

% Prova 8: cerchiamo di migliorare lo step --> SI NP, 1300 sec step, e 
% GAM = 0.9
% Wp(1) = 0.1*makeweight(1e3,[0.001,20],0.5,0,2); % [freq,valore]
% Wp(2) = tf(0.5);
% Wp(3) = 0.1*makeweight(0.01,[10,0.05],0.1,0,2);

% Prova 9: Si NP, Step circa 40 sec, MA NO RS
% Wp(1) = 0.1*makeweight(1e3,[0.01,70],0.5,0,2); % [freq,valore]
% Wp(2) = 0.1*tf(0.5);
% Wp(3) = 0.1*makeweight(0.01,[10,0.05],0.1,0,2);

% Prova 10: Si NP, Step MENO DI 10 sec!!!, MA NO RS
% Wp(1) = 0.1*makeweight(1e3,[0.1,100],0.5,0,2); % [freq,valore]
% Wp(2) = 0.1*tf(0.5);
% Wp(3) = 0.1*makeweight(0.01,[10,0.05],0.1,0,2);

% FUNZIONA: Adesso peggioriamo un pochino le prestazioni per poter avere RS -->
% stabmarg 1.04!!! MA NP = 1, QUINDI NON NP, MA QUASI
Wp(1) = 0.1*makeweight(1e3,[0.25,81],2.5,0,2); % [freq,valore]
Wp(2) = 0.1*tf(0.5);
Wp(3) = 1*makeweight(0.01,[10,0.05],0.1,0,2);

% Finale --> SI NP, NO RS (di poco)
Wp(1) = 0.01049*makeweight(1e4*1.00015,[0.25,1037],20.00073,0,2); % [freq,valore]
Wp(2) = 0.1*tf(0.5);
Wp(3) = 0.01*makeweight(0.01,[10,0.05],0.1,0,2);

% Matrice peso per S
W1 = blkdiag(Wp(1), Wp(2), Wp(3));

figure(1)
sigma(1/So_LQG,W1,'r--')
legend('1/S_lqg','W1')
% 
% figure()
% sigma(So_LQG,1/W1,'r--')
% legend('S_lqg','1/W1')

% peso per sforzo di controllo
% figure()
% sigma(K_LQG*So_LQG)
% legend('K*S');
% Vediamo che deve essere almeno 50 in controllo circa






