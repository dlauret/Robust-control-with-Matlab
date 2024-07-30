%% Modello con incertezze

% Incertezza solo su M
m = 1.22;
L = 0.2924;
r = 0.13;
a = 0.496/2;
g = 9.8;
M = ureal('M',5,'Percentage',10);

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
A = [0 0 0 1 0 0;
     0 0 0 0 1 0;
     0 0 0 0 0 1;
     A21(1,1) A21(1,2) A21(1,3) 0 0 0;
     A21(2,1) A21(2,2) A21(2,3) 0 0 0;
     A21(3,1) A21(3,2) A21(3,3) 0 0 0];

B2 = Ml\Tl; % = Ml_inv*Tl
B = [0 0;
     0 0;
     0 0;
     B2(1,1) B2(1,2);
     B2(2,1) B2(2,2);
     B2(3,1) B2(3,2)];

C = [1 0 0 0 0 0;
     0 1 0 0 0 0;
     0 0 1 0 0 0];

D = 0*eye(3,2);

Gseg_p = ss(A,B,C,D);

% Tiriamo fuori le incertezze
[Gseg_LFT,DeltaSeg,Blkstruct_S,NORMUNC_S] = lftdata(Gseg_p,'M');

% Attuatori
Wa = tf([0.4107 29.91], [1 287.2]);

% Modello concentrato (lumped) di incertezza moltiplicativa
% Dimensione due, i due attuatori uguali
Delta_a1 = ultidyn('Delta_a1',[1 1]); % incertezza dinamica
Delta_a2 = ultidyn('Delta_a2',[1 1]);
Delta_a_blk = blkdiag(Delta_a1, Delta_a2);
% Costruiamo fdt con incertezze
Ga_nom = blkdiag(Gnom,Gnom); % G attuatori totale nominale
Wa_blk = blkdiag(Wa,Wa);
Ga_p = Ga_nom*(eye(2) + Wa_blk*Delta_a_blk); % Ga perturbata, incertezze all'interno

[Ga_LFT,Delta_a,Blkstruct_a,NORMUNC_a] = lftdata(Ga_p);

% matrice fdt totale Gtot_p = Segway + Att PERTURBATA (internamente)
Gtot_p = Gseg_p*Ga_p;

[Gtot_LFT,Delta_tot,Blkstruct_tot,NORMUNC_tot] = lftdata(Gtot_p);
% Delta_tot = 17x17 torna --> 15 (M nel seg) + 2 (att)




