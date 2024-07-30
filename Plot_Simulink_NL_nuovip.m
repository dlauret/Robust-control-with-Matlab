% Vari plot Simulink Sistema NON LINEARE

%% Controllore LQG
f1 = figure();
% x
subplot(3,1,1)
plot(out.NL_LQG_x.Time, out.NL_LQG_x.Data,'r','LineWidth',1.5)
grid on
hold on
title('x of NL model with K\_LQG')
xlabel('t (s)', 'FontSize', 13)
ylabel('x (m)', 'FontSize', 13)
% theta
subplot(3,1,2)
plot(out.NL_LQG_theta.Time, out.NL_LQG_theta.Data,'r','LineWidth',1.5)
grid on
hold on
title('theta of NL model with K\_LQG')
xlabel('t (s)', 'FontSize', 13)
ylabel('theta (rad)', 'FontSize', 13)
% phi
subplot(3,1,3)
plot(out.NL_LQG_phi.Time, out.NL_LQG_phi.Data,'r','LineWidth',1.5)
grid on
hold on
title('phi of NL model with K\_LQG')
xlabel('t (s)', 'FontSize', 13)
ylabel('phi (rad)', 'FontSize', 13)

exportgraphics(f1,".\Plot_simulazione\Foto_LQG\K_LQG_Foto_step_10.png")


%% Controllore MS
f2 = figure();
% x
subplot(3,1,1)
plot(out.NL_MS_x.Time, out.NL_MS_x.Data,'r','LineWidth',1.5)
grid on
hold on
title('x of NL model with K\_MS')
xlabel('t (s)', 'FontSize', 13)
ylabel('x (m)', 'FontSize', 13)
% theta
subplot(3,1,2)
plot(out.NL_MS_theta.Time, out.NL_MS_theta.Data,'r','LineWidth',1.5)
grid on
hold on
title('theta of NL model with K\_MS')
xlabel('t (s)', 'FontSize', 13)
ylabel('theta (rad)', 'FontSize', 13)
% phi
subplot(3,1,3)
plot(out.NL_MS_phi.Time, out.NL_MS_phi.Data,'r','LineWidth',1.5)
grid on
hold on
title('phi of NL model with K\_MS')
xlabel('t (s)', 'FontSize', 13)
ylabel('phi (rad)', 'FontSize', 13)

exportgraphics(f2,".\Plot_simulazione\Foto_MS\K_MS_Foto_step_100.png")

%% Controllore DK
f3 = figure();
% x
subplot(3,1,1)
plot(out.NL_DK_x.Time, out.NL_DK_x.Data,'r','LineWidth',1.5)
grid on
hold on
title('x of NL model with K\_DK')
xlabel('t (s)', 'FontSize', 13)
ylabel('x (m)', 'FontSize', 13)
% theta
subplot(3,1,2)
plot(out.NL_DK_theta.Time, out.NL_DK_theta.Data,'r','LineWidth',1.5)
grid on
hold on
title('theta of NL model with K\_DK')
xlabel('t (s)', 'FontSize', 13)
ylabel('theta (rad)', 'FontSize', 13)
% phi
subplot(3,1,3)
plot(out.NL_DK_phi.Time, out.NL_DK_phi.Data,'r','LineWidth',1.5)
grid on
hold on
title('phi of NL model with K\_DK')
xlabel('t (s)', 'FontSize', 13)
ylabel('phi (rad)', 'FontSize', 13)

exportgraphics(f3,".\Plot_simulazione\Foto_DK\K_DK_Foto_10deg.png")


