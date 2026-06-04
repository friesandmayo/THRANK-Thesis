addpath C:\dynare\6.5\matlab
clear all; close all; clc;

% --- Sensitivity Analysis Configuration ---
param_macro_name   = 'PSI_val'; % Must match the @#define variable in the .mod file
param_display_name = 'PSI';     
val_base           = 0.01;        % Baseline value
val_alt            = 0.5;         % Alternative value

%% ------------- 1. Run Scenarios -------------

% Scenario 1: Baseline (parameter = baseline value)
dynare_cmd_base = sprintf('dynare model_sensitivity.mod noclearall -D%s=%g', param_macro_name, val_base);
eval(dynare_cmd_base);
oo_base = oo_;

% Scenario 2: Alternative (parameter = sensitivity value)
dynare_cmd_alt = sprintf('dynare model_sensitivity.mod noclearall -D%s=%g', param_macro_name, val_alt);
eval(dynare_cmd_alt);
oo_alt = oo_;

%% ------------- 2. Calculate Welfare Variation (CEV) -------------

% Extract necessary parameters
betta_H = M_.params(strmatch('betta_H', M_.param_names, 'exact'));
betta_M = M_.params(strmatch('betta_M', M_.param_names, 'exact'));
betta_S = M_.params(strmatch('betta_S', M_.param_names, 'exact'));
sigma   = M_.params(strmatch('sigma',   M_.param_names, 'exact'));

% Helper function to calculate CEV for a given scenario 
calc_cev = @(idx_V, idx_C, betta, oo_str) ...
    (1 + (oo_str.endo_simul(idx_V, 2:options_.periods+1) - oo_str.endo_simul(idx_V, 1)) .* ...
    (1 - betta) .* (1 - sigma) ./ (oo_str.endo_simul(idx_C, 1).^(1-sigma))).^(1/(1-sigma)) - 1;

idx_V_H = strmatch('V_H', M_.endo_names, 'exact'); idx_C_H = strmatch('C_H', M_.endo_names, 'exact');
idx_V_M = strmatch('V_M', M_.endo_names, 'exact'); idx_C_M = strmatch('C_M', M_.endo_names, 'exact');
idx_V_S = strmatch('V_S', M_.endo_names, 'exact'); idx_C_S = strmatch('C_S', M_.endo_names, 'exact');

% Calculate CEVs
CEV_H_base = calc_cev(idx_V_H, idx_C_H, betta_H, oo_base);
CEV_H_alt  = calc_cev(idx_V_H, idx_C_H, betta_H, oo_alt);

CEV_M_base = calc_cev(idx_V_M, idx_C_M, betta_M, oo_base);
CEV_M_alt  = calc_cev(idx_V_M, idx_C_M, betta_M, oo_alt);

CEV_S_base = calc_cev(idx_V_S, idx_C_S, betta_S, oo_base);
CEV_S_alt  = calc_cev(idx_V_S, idx_C_S, betta_S, oo_alt);


%% ------------- 3. Data Extraction Helpers -------------

% Helper anonymous functions to fetch and convert data cleanly

% Percent Deviation from initial steady state:
get_dev = @(var, oo_str) (oo_str.endo_simul(strmatch(var, M_.endo_names, 'exact'), 2:options_.periods+1) - ...
                          oo_str.endo_simul(strmatch(var, M_.endo_names, 'exact'), 1)) ...
                          ./ oo_str.endo_simul(strmatch(var, M_.endo_names, 'exact'), 1) * 100;

% Annualized Percentage Point deviation:              
get_pp  = @(var, oo_str) (oo_str.endo_simul(strmatch(var, M_.endo_names, 'exact'), 2:options_.periods+1) - ...
                          oo_str.endo_simul(strmatch(var, M_.endo_names, 'exact'), 1)) * 400; 

% Pure Levels:
get_lvl = @(var, oo_str) oo_str.endo_simul(strmatch(var, M_.endo_names, 'exact'), 2:options_.periods+1);


%% ------------- 4. Plotting -------------

time_axis = 1:options_.periods;
graph_dir = 'model_sensitivity/graphs';
if ~exist(graph_dir, 'dir')
    mkdir(graph_dir);
end
param_note = sprintf('%s: Base = %g | Alt = %g', param_display_name, val_base, val_alt);
add_footer = @() annotation('textbox', [0, 0.01, 1, 0.04], 'String', param_note, ...
    'EdgeColor', 'none', 'HorizontalAlignment', 'center', ...
    'FontSize', 12, 'FontWeight', 'bold', 'Interpreter', 'none');

% --- CEV Figure ---
cev_fig = figure('Name', 'Consumption Equivalent Variation', 'Position', [150, 150, 800, 500]);
plot(time_axis, CEV_H_base * 100, 'b-', time_axis, CEV_M_base * 100, 'r-', time_axis, CEV_S_base * 100, 'g-', 'LineWidth', 2); hold on;
plot(time_axis, CEV_H_alt * 100,  'b--', time_axis, CEV_M_alt * 100,  'r--', time_axis, CEV_S_alt * 100,  'g--', 'LineWidth', 1.5);
title({'Consumption Equivalent Variation over Time', param_note}, 'Interpreter', 'none');
xlabel('Period'); ylabel('CEV (%)'); grid on; xlim([1 options_.periods]);
legend('H (Base)', 'M (Base)', 'S (Base)', 'H (Alt)', 'M (Alt)', 'S (Alt)', 'Location', 'best');
exportgraphics(cev_fig, fullfile(graph_dir, 'Fig4_CEV_Dynamics.pdf'), 'ContentType', 'vector');


% --- FIGURE 1: Macro & Household Dynamics ---
fig1 = figure('Name', 'Macro & Household Dynamics', 'Position', [100, 100, 1800, 1200]);
title({'Macro & Household Dynamics', param_note}, 'Interpreter', 'none');

subplot(3,3,1); hold on; grid on;
plot(time_axis, get_dev('C_H', oo_base), 'b-', time_axis, get_dev('C_M', oo_base), 'r-', time_axis, get_dev('C_S', oo_base), 'g-', 'LineWidth', 2);
plot(time_axis, get_dev('C_H', oo_alt), 'b--', time_axis, get_dev('C_M', oo_alt), 'r--', time_axis, get_dev('C_S', oo_alt), 'g--', 'LineWidth', 1.5);
title('Consumption'); xlabel('Period'); ylabel('% Dev'); xlim([1 options_.periods]);
legend('C_H (Base)', 'C_M (Base)', 'C_S (Base)', 'C_H (Alt)', 'C_M (Alt)', 'C_S (Alt)', 'Location', 'best');

subplot(3,3,2); hold on; grid on;
plot(time_axis, get_dev('L_H', oo_base), 'b-', time_axis, get_dev('L_M', oo_base), 'r-', 'LineWidth', 2);
plot(time_axis, get_dev('L_H', oo_alt), 'b--', time_axis, get_dev('L_M', oo_alt), 'r--', 'LineWidth', 1.5);
title('Labour'); xlabel('Period'); ylabel('% Dev'); xlim([1 options_.periods]);
legend('L_H (Base)', 'L_M (Base)', 'L_H (Alt)', 'L_M (Alt)', 'Location', 'best');

subplot(3,3,3); hold on; grid on;
plot(time_axis, get_dev('INC_H', oo_base), 'b-', time_axis, get_dev('INC_M', oo_base), 'r-', time_axis, get_dev('INC_S', oo_base), 'g-', 'LineWidth', 2);
plot(time_axis, get_dev('INC_H', oo_alt), 'b--', time_axis, get_dev('INC_M', oo_alt), 'r--', time_axis, get_dev('INC_S', oo_alt), 'g--', 'LineWidth', 1.5);
title('Incomes'); xlabel('Period'); ylabel('% Dev'); xlim([1 options_.periods]);
legend('INC_H (Base)', 'INC_M (Base)', 'INC_S (Base)', 'INC_H (Alt)', 'INC_M (Alt)', 'INC_S (Alt)', 'Location', 'best');

subplot(3,3,4); hold on; grid on;
plot(time_axis, get_dev('NW_H', oo_base), 'b-', time_axis, get_dev('NW_M', oo_base), 'r-', time_axis, get_dev('NW_S', oo_base), 'g-', 'LineWidth', 2);
plot(time_axis, get_dev('NW_H', oo_alt), 'b--', time_axis, get_dev('NW_M', oo_alt), 'r--', time_axis, get_dev('NW_S', oo_alt), 'g--', 'LineWidth', 1.5);
title('Net Wealth'); xlabel('Period'); ylabel('% Dev'); xlim([1 options_.periods]);
legend('NW_H (Base)', 'NW_M (Base)', 'NW_S (Base)', 'NW_H (Alt)', 'NW_M (Alt)', 'NW_S (Alt)', 'Location', 'best');

subplot(3,3,5); hold on; grid on;
plot(time_axis, get_dev('Y', oo_base), 'b-', time_axis, get_dev('L', oo_base), 'r-', time_axis, get_dev('K', oo_base), 'g-', 'LineWidth', 2);
plot(time_axis, get_dev('Y', oo_alt), 'b--', time_axis, get_dev('L', oo_alt), 'r--', time_axis, get_dev('K', oo_alt), 'g--', 'LineWidth', 1.5);
title('Aggregates'); xlabel('Period'); ylabel('% Dev'); xlim([1 options_.periods]);
legend('Y (Base)', 'L (Base)', 'K (Base)', 'Y (Alt)', 'L (Alt)', 'K (Alt)', 'Location', 'best');

subplot(3,3,6); hold on; grid on;
plot(time_axis, get_dev('mc', oo_base), 'b-', time_axis, get_dev('I', oo_base), 'r-', time_axis, get_dev('w', oo_base), 'g-', 'LineWidth', 2);
plot(time_axis, get_dev('mc', oo_alt), 'b--', time_axis, get_dev('I', oo_alt), 'r--', time_axis, get_dev('w', oo_alt), 'g--', 'LineWidth', 1.5);
title('Firm Metrics'); xlabel('Period'); ylabel('% Dev'); xlim([1 options_.periods]);
legend('mc (Base)', 'I (Base)', 'w (Base)', 'mc (Alt)', 'I (Alt)', 'w (Alt)', 'Location', 'best');

subplot(3,3,7); hold on; grid on;
plot(time_axis, get_dev('s', oo_base), 'b-', time_axis, get_dev('q', oo_base), 'r-', time_axis, get_dev('r', oo_base), 'g-', 'LineWidth', 2);
plot(time_axis, get_dev('s', oo_alt), 'b--', time_axis, get_dev('q', oo_alt), 'r--', time_axis, get_dev('r', oo_alt), 'g--', 'LineWidth', 1.5);
title('Prices'); xlabel('Period'); ylabel('% Dev'); xlim([1 options_.periods]);
legend('s (Base)', 'q (Base)', 'r (Base)', 's (Alt)', 'q (Alt)', 'r (Alt)', 'Location', 'best');

subplot(3,3,8); hold on; grid on;
plot(time_axis, get_pp('i', oo_base), 'k-', time_axis, get_pp('i_m', oo_base), 'r-', time_axis, get_pp('i_d', oo_base), 'b-', time_axis, get_pp('i_f', oo_base), 'y-', 'LineWidth', 2);
plot(time_axis, get_pp('i', oo_alt), 'k--', time_axis, get_pp('i_m', oo_alt), 'r--', time_axis, get_pp('i_d', oo_alt), 'b--', time_axis, get_pp('i_f', oo_alt), 'y--', 'LineWidth', 1.5);
title('Interest Rates'); xlabel('Period'); ylabel('Ann. pp dev'); xlim([1 options_.periods]);
legend('i (Base)', 'i_m (Base)', 'i_d (Base)', 'i_f (Base)', 'i (Alt)', 'i_m (Alt)', 'i_d (Alt)', 'i_f (Alt)', 'Location', 'best');

subplot(3,3,9); hold on; grid on;
plot(time_axis, get_pp('pi_var', oo_base), 'k-', time_axis, get_pp('pi_w_H', oo_base), 'b-', time_axis, get_pp('pi_w_M', oo_base), 'r-', 'LineWidth', 2);
plot(time_axis, get_pp('pi_var', oo_alt), 'k--', time_axis, get_pp('pi_w_H', oo_alt), 'b--', time_axis, get_pp('pi_w_M', oo_alt), 'r--', 'LineWidth', 1.5);
title('Inflation'); xlabel('Period'); ylabel('Ann. pp dev'); xlim([1 options_.periods]);
legend('pi (Base)', 'pi_w_H (Base)', 'pi_w_M (Base)', 'pi (Alt)', 'pi_w_H (Alt)', 'pi_w_M (Alt)', 'Location', 'best');

add_footer();

exportgraphics(fig1, fullfile(graph_dir, 'Fig1_HH_Dynamics.pdf'), 'ContentType', 'vector');


% --- FIGURE 2: Financial, Housing & Public Sector ---
fig2 = figure('Name', 'Financial, Housing & Public Sector', 'Position', [150, 150, 1800, 1200]);
title({'Financial, Housing & Public Sector', param_note}, 'Interpreter', 'none');

subplot(3,3,1); hold on; grid on;
plot(time_axis, get_dev('m_H', oo_base), 'b-', time_axis, get_dev('m_cH', oo_base), 'r-', 'LineWidth', 2);
plot(time_axis, get_dev('m_H', oo_alt), 'b--', time_axis, get_dev('m_cH', oo_alt), 'r--', 'LineWidth', 1.5);
title('H Deposits'); xlabel('Period'); ylabel('% Dev'); xlim([1 options_.periods]);
legend('m_H (Base)', 'm_cH (Base)', 'm_H (Alt)', 'm_cH (Alt)', 'Location', 'best');

subplot(3,3,2); hold on; grid on;
plot(time_axis, get_dev('n_M', oo_base), 'r-', time_axis, get_dev('b_S', oo_base), 'g-', 'LineWidth', 2);
plot(time_axis, get_dev('n_M', oo_alt), 'r--', time_axis, get_dev('b_S', oo_alt), 'g--', 'LineWidth', 1.5);
title('Debt & Bonds'); xlabel('Period'); ylabel('% Dev'); xlim([1 options_.periods]);
legend('n_M (Base)', 'b_S (Base)', 'n_M (Alt)', 'b_S (Alt)', 'Location', 'best');

subplot(3,3,3); hold on; grid on;
plot(time_axis, get_dev('H_M', oo_base), 'b-', time_axis, get_dev('H_S', oo_base), 'g-', time_axis, get_dev('mu', oo_base), 'r-', 'LineWidth', 2);
plot(time_axis, get_dev('H_M', oo_alt), 'b--', time_axis, get_dev('H_S', oo_alt), 'g--', time_axis, get_dev('mu', oo_alt), 'r--', 'LineWidth', 1.5);
title('Housing & Constraint'); xlabel('Period'); ylabel('% Dev'); xlim([1 options_.periods]);
legend('H_M (Base)', 'H_S (Base)', 'mu (Base)', 'H_M (Alt)', 'H_S (Alt)', 'mu (Alt)', 'Location', 'best');

subplot(3,3,4); hold on; grid on;
plot(time_axis, get_dev('C', oo_base), 'k-', 'LineWidth', 2);
plot(time_axis, get_dev('C', oo_alt), 'k--', 'LineWidth', 1.5);
title('Aggregate Consumption'); xlabel('Period'); ylabel('% Dev'); xlim([1 options_.periods]);
legend('C (Base)', 'C (Alt)', 'Location', 'best');

subplot(3,3,5); hold on; grid on;
plot(time_axis, get_lvl('d_i', oo_base), 'b-', time_axis, get_lvl('d_b', oo_base), 'r-', time_axis, get_lvl('d_k', oo_base), 'g-', 'LineWidth', 2);
plot(time_axis, get_lvl('d_i', oo_alt), 'b--', time_axis, get_lvl('d_b', oo_alt), 'r--', time_axis, get_lvl('d_k', oo_alt), 'g--', 'LineWidth', 1.5);
title('Profits'); xlabel('Period'); ylabel('Levels'); xlim([1 options_.periods]);
legend('d_i (Base)', 'd_b (Base)', 'd_k (Base)', 'd_i (Alt)', 'd_b (Alt)', 'd_k (Alt)', 'Location', 'best');

subplot(3,3,6); hold on; grid on;
plot(time_axis, get_lvl('T_H', oo_base), 'b-', time_axis, get_lvl('T_M', oo_base), 'r-', time_axis, get_lvl('T_S', oo_base), 'g-', 'LineWidth', 2);
plot(time_axis, get_lvl('T_H', oo_alt), 'b--', time_axis, get_lvl('T_M', oo_alt), 'r--', time_axis, get_lvl('T_S', oo_alt), 'g--', 'LineWidth', 1.5);
title('Transfers'); xlabel('Period'); ylabel('Levels'); xlim([1 options_.periods]);
legend('T_H (Base)', 'T_M (Base)', 'T_S (Base)', 'T_H (Alt)', 'T_M (Alt)', 'T_S (Alt)', 'Location', 'best');

add_footer();

exportgraphics(fig2, fullfile(graph_dir, 'Fig2_FHP_Dynamics.pdf'), 'ContentType', 'vector');


% --- FIGURE 3: Welfare, Inequality & Shocks ---
fig3 = figure('Name', 'Welfare, Inequality & Shocks', 'Position', [200, 200, 1000, 600]);
title({'Welfare, Inequality & Shocks', param_note}, 'Interpreter', 'none');

subplot(2,2,1); hold on; grid on;
plot(time_axis, get_lvl('U_H', oo_base), 'b-', time_axis, get_lvl('U_M', oo_base), 'r-', time_axis, get_lvl('U_S', oo_base), 'g-', 'LineWidth', 2);
plot(time_axis, get_lvl('U_H', oo_alt), 'b--', time_axis, get_lvl('U_M', oo_alt), 'r--', time_axis, get_lvl('U_S', oo_alt), 'g--', 'LineWidth', 1.5);
title('Period Utility'); xlabel('Period'); ylabel('Levels'); xlim([1 options_.periods]);
legend('U_H (Base)', 'U_M (Base)', 'U_S (Base)', 'U_H (Alt)', 'U_M (Alt)', 'U_S (Alt)', 'Location', 'best');

subplot(2,2,2); hold on; grid on;
plot(time_axis, get_lvl('V_H', oo_base), 'b-', time_axis, get_lvl('V_M', oo_base), 'r-', time_axis, get_lvl('V_S', oo_base), 'g-', 'LineWidth', 2);
plot(time_axis, get_lvl('V_H', oo_alt), 'b--', time_axis, get_lvl('V_M', oo_alt), 'r--', time_axis, get_lvl('V_S', oo_alt), 'g--', 'LineWidth', 1.5);
title('Welfare'); xlabel('Period'); ylabel('Levels'); xlim([1 options_.periods]);
legend('V_H (Base)', 'V_M (Base)', 'V_S (Base)', 'V_H (Alt)', 'V_M (Alt)', 'V_S (Alt)', 'Location', 'best');

subplot(2,2,3); hold on; grid on;
plot(time_axis, get_lvl('GINI_I', oo_base), 'b-', 'LineWidth', 2);
plot(time_axis, get_lvl('GINI_I', oo_alt), 'b--', 'LineWidth', 1.5);
title('Income Inequality'); xlabel('Period'); ylabel('Gini Coefficient'); xlim([1 options_.periods]);
legend('Income Gini (Base)', 'Income Gini (Alt)', 'Location', 'best');

subplot(2,2,4); hold on; grid on;
plot(time_axis, get_lvl('GINI_W', oo_base), 'r-', 'LineWidth', 2);
plot(time_axis, get_lvl('GINI_W', oo_alt), 'r--', 'LineWidth', 1.5);
title('Wealth Inequality'); xlabel('Period'); ylabel('Gini Coefficient'); xlim([1 options_.periods]);
legend('Wealth Gini (Base)', 'Wealth Gini (Alt)', 'Location', 'best');

add_footer();

exportgraphics(fig3, fullfile(graph_dir, 'Fig3_WI_Dynamics.pdf'), 'ContentType', 'vector');


% --- FIGURE 5: Banking ---
fig5 = figure('Name', 'Banking', 'Position', [200, 200, 1000, 600]);
title({'Welfare, Banking', param_note}, 'Interpreter', 'none');

subplot(2,2,1); hold on; grid on;
plot(time_axis, get_dev('m', oo_base), 'b-', 'LineWidth', 2);
plot(time_axis, get_dev('m', oo_alt), 'b--', 'LineWidth', 1.5);
title('Bank Deposit Funding'); xlabel('Period'); ylabel('% Dev'); xlim([1 options_.periods]);
legend('m (Base)', 'm (Alt)', 'Location', 'best');

subplot(2,2,3); hold on; grid on;
plot(time_axis, get_dev('n', oo_base), 'r-', time_axis, get_dev('b', oo_base), 'g-', 'LineWidth', 2);
plot(time_axis, get_dev('n', oo_alt), 'r--', time_axis, get_dev('b', oo_alt), 'g--', 'LineWidth', 1.5);
title('Bank Bonds & Mortgages'); xlabel('Period'); ylabel('% Dev'); xlim([1 options_.periods]);
legend('n (Base)', 'b (Base)', 'n (Alt)', 'b (Alt)', 'Location', 'best');

subplot(2,2,2); hold on; grid on;
plot(time_axis, get_dev('m_cB', oo_base), 'b-', time_axis, get_dev('f', oo_base), 'r-', 'LineWidth', 2);
plot(time_axis, get_dev('m_cB', oo_alt), 'b--', time_axis, get_dev('f', oo_alt), 'r--', 'LineWidth', 1.5);
title('Bank Reserves & CB Loans'); xlabel('Period'); ylabel('% Dev'); xlim([1 options_.periods]);
legend('m_cB (Base)', 'f (Base)', 'm_cB (Alt)', 'f (Alt)', 'Location', 'best');

add_footer();

exportgraphics(fig5, fullfile(graph_dir, 'Fig5_Bank_Dynamics.pdf'), 'ContentType', 'vector');




%% ------------- 5. Steady-State Comparison Table -------------

% Column 1 is the initial steady state 
% Last column is the final steady state 

init_SS_base  = oo_base.endo_simul(:, 1);
final_SS_base = oo_base.endo_simul(:, end);

init_SS_alt   = oo_alt.endo_simul(:, 1);
final_SS_alt  = oo_alt.endo_simul(:, end);

% Retrieve endogenous variable names 
var_names = cellstr(M_.endo_names);

% Assemble the 4-column data table
SS_Table = table(var_names, init_SS_base, final_SS_base, init_SS_alt, final_SS_alt, ...
    'VariableNames', {'Variable', 'Base_Init_SS', 'Base_Final_SS', 'Alt_Init_SS', 'Alt_Final_SS'});

% --- Export to Excel ---
excel_filename = fullfile(graph_dir, sprintf('SS_Comparison_%s.xlsx', param_macro_name));
writetable(SS_Table, excel_filename);




















close all