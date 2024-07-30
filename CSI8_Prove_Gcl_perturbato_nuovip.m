%% Prove dei controllori sul perturbato

% LQG
Gcl_LQG_p = feedback(Gtot_p*K_LQG,eye(3));
f1 = figure(1);
step(Gcl_LQG_p*[1 0 0]',Gcl_LQG_p.NominalValue*[1 0 0]','r',100);
title("Step con K\_LQG su sistema perturbato");

%% MS
Gcl_MS_p = feedback(Gtot_p*K_MS,eye(3));
f2 = figure(2);
Gcl_MS_p_sample = usample(Gcl_MS_p,1000);
step(Gcl_MS_p_sample*[1 0 0]',Gcl_MS_p.NominalValue*[1 0 0]','r',10);
title("Step con K\_MS su sistema perturbato");
exportgraphics(f2,".\Plot_simulazione\K_MS_step_lineare.png")

%% DK
Gcl_DK_p = feedback(Gtot_p*K_DK,eye(3));
f3 = figure(3);
step(Gcl_DK_p*[1 0 0]',Gcl_DK_p.NominalValue*[1 0 0]','r',100);
title("Step con K\_DK su sistema perturbato");

% exportgraphics(f1,".\Plot_simulazione\Foto_Lineare_p\K_LQG_step.png")
% exportgraphics(f2,".\Plot_simulazione\Foto_Lineare_p\K_MS_step.png")
% exportgraphics(f3,".\Plot_simulazione\Foto_Lineare_p\K_DK_step.png")
