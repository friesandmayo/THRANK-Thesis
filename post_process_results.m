function post_process_results(run_type, out_dir, M_, options_, oo_base, oo_alt, param_name, val_base, val_alt, show_graphs)

    %% ------------- 0. Setup -------------
    if ~exist(out_dir, 'dir')
        mkdir(out_dir);
    end
    
    plot_periods = 50; 
    time_axis = 1:plot_periods;
    
    is_sens = strcmp(run_type, 'sensitivity');
    
    % Toggle Visibility
    if show_graphs
        fig_vis = 'on';
    else
        fig_vis = 'off';
    end

    param_note = '';
    if is_sens
        param_note = sprintf('%s: Base = %g | Alt = %g', param_name, val_base, val_alt);
    end
    add_footer = @() annotation('textbox', [0, 0.01, 1, 0.04], 'String', param_note, ...
        'EdgeColor', 'none', 'HorizontalAlignment', 'center', ...
        'FontSize', 12, 'FontWeight', 'bold', 'Interpreter', 'none');


    %% ------------- 1. Calculate Welfare Variation (CEV) -------------
    % Extract necessary parameters
    betta_H = M_.params(strmatch('betta_H', M_.param_names, 'exact'));
    betta_M = M_.params(strmatch('betta_M', M_.param_names, 'exact'));
    betta_S = M_.params(strmatch('betta_S', M_.param_names, 'exact'));
    sigma   = M_.params(strmatch('sigma',   M_.param_names, 'exact'));

    % Helper function to calculate CEV for a given scenario 
    calc_cev = @(idx_V, idx_C, betta, oo_str) ...
        (1 + (oo_str.endo_simul(idx_V, 2:plot_periods+1) - oo_str.endo_simul(idx_V, 1)) .* ...
        (1 - betta) .* (1 - sigma) ./ (oo_str.endo_simul(idx_C, 1).^(1-sigma))).^(1/(1-sigma)) - 1;

    idx_V_H = strmatch('V_H', M_.endo_names, 'exact'); idx_C_H = strmatch('C_H', M_.endo_names, 'exact');
    idx_V_M = strmatch('V_M', M_.endo_names, 'exact'); idx_C_M = strmatch('C_M', M_.endo_names, 'exact');
    idx_V_S = strmatch('V_S', M_.endo_names, 'exact'); idx_C_S = strmatch('C_S', M_.endo_names, 'exact');

    % Calculate Base CEVs
    CEV_H_base = calc_cev(idx_V_H, idx_C_H, betta_H, oo_base);
    CEV_M_base = calc_cev(idx_V_M, idx_C_M, betta_M, oo_base);
    CEV_S_base = calc_cev(idx_V_S, idx_C_S, betta_S, oo_base);

    if is_sens
        CEV_H_alt = calc_cev(idx_V_H, idx_C_H, betta_H, oo_alt);
        CEV_M_alt = calc_cev(idx_V_M, idx_C_M, betta_M, oo_alt);
        CEV_S_alt = calc_cev(idx_V_S, idx_C_S, betta_S, oo_alt);
    end

    %% ------------- 2. Plotting Consumption Equivalent Variation -------------
    cev_fig = figure('Name', 'Consumption Equivalent Variation', 'Position', [150, 150, 800, 500], 'Visible', fig_vis);
    hold on; grid on;
    plot(time_axis, CEV_H_base * 100, 'b-', time_axis, CEV_M_base * 100, 'r-', time_axis, CEV_S_base * 100, 'g-', 'LineWidth', 2);
    
    if is_sens
        plot(time_axis, CEV_H_alt * 100, 'b--', time_axis, CEV_M_alt * 100, 'r--', time_axis, CEV_S_alt * 100, 'g--', 'LineWidth', 1.5);
        legend('CEV_H (Base)', 'CEV_M (Base)', 'CEV_S (Base)', 'CEV_H (Alt)', 'CEV_M (Alt)', 'CEV_S (Alt)', 'Location', 'best');
    else
        legend('CEV_H', 'CEV_M', 'CEV_S', 'Location', 'best');
    end
    
    title({'Consumption Equivalent Variation over Time', param_note}, 'Interpreter', 'none');
    xlabel('Period'); ylabel('CEV (%)'); xlim([1 plot_periods]);
    exportgraphics(cev_fig, fullfile(out_dir, 'Fig4_CEV_Dynamics.pdf'), 'ContentType', 'vector');


    %% ------------- 3. Data Extraction Helpers -------------
    get_dev = @(var, oo_str) (oo_str.endo_simul(strmatch(var, M_.endo_names, 'exact'), 2:plot_periods+1) - ...
                              oo_str.endo_simul(strmatch(var, M_.endo_names, 'exact'), 1)) ...
                              ./ oo_str.endo_simul(strmatch(var, M_.endo_names, 'exact'), 1) * 100;

    get_pp  = @(var, oo_str) (oo_str.endo_simul(strmatch(var, M_.endo_names, 'exact'), 2:plot_periods+1) - ...
                              oo_str.endo_simul(strmatch(var, M_.endo_names, 'exact'), 1)) * 400; 

    get_lvl = @(var, oo_str) oo_str.endo_simul(strmatch(var, M_.endo_names, 'exact'), 2:plot_periods+1);
    
    get_exo_lvl = @(var, oo_str) oo_str.exo_simul(2:plot_periods+1, strmatch(var, M_.exo_names, 'exact'))';


    %% ------------- FIGURE 1: Macro & Household Dynamics -------------
    fig1 = figure('Name', 'Macro & Household Dynamics', 'Position', [100, 100, 1200, 800], 'Visible', fig_vis);

    subplot(3,3,1); hold on; grid on;
    plot(time_axis, get_dev('C_H', oo_base), 'b-', time_axis, get_dev('C_M', oo_base), 'r-', time_axis, get_dev('C_S', oo_base), 'g-', 'LineWidth', 2);
    if is_sens; plot(time_axis, get_dev('C_H', oo_alt), 'b--', time_axis, get_dev('C_M', oo_alt), 'r--', time_axis, get_dev('C_S', oo_alt), 'g--', 'LineWidth', 1.5); legend('C_H (Base)','C_M (Base)','C_S (Base)','C_H (Alt)','C_M (Alt)','C_S (Alt)','Location','best');
    else; legend('C_H', 'C_M', 'C_S', 'Location', 'best'); end
    title('Consumption (% Dev)'); xlim([1 plot_periods]);

    subplot(3,3,2); hold on; grid on;
    plot(time_axis, get_dev('L_H', oo_base), 'b-', time_axis, get_dev('L_M', oo_base), 'r-', 'LineWidth', 2);
    if is_sens; plot(time_axis, get_dev('L_H', oo_alt), 'b--', time_axis, get_dev('L_M', oo_alt), 'r--', 'LineWidth', 1.5); legend('L_H (Base)','L_M (Base)','L_H (Alt)','L_M (Alt)','Location','best');
    else; legend('L_H', 'L_M', 'Location', 'best'); end
    title('Labour (% Dev)'); xlim([1 plot_periods]);

    subplot(3,3,3); hold on; grid on;
    plot(time_axis, get_dev('INC_H', oo_base), 'b-', time_axis, get_dev('INC_M', oo_base), 'r-', time_axis, get_dev('INC_S', oo_base), 'g-', 'LineWidth', 2);
    if is_sens; plot(time_axis, get_dev('INC_H', oo_alt), 'b--', time_axis, get_dev('INC_M', oo_alt), 'r--', time_axis, get_dev('INC_S', oo_alt), 'g--', 'LineWidth', 1.5); legend('INC_H (Base)','INC_M (Base)','INC_S (Base)','INC_H (Alt)','INC_M (Alt)','INC_S (Alt)','Location','best');
    else; legend('INC_H', 'INC_M', 'INC_S', 'Location', 'best'); end
    title('Incomes (% Dev)'); xlim([1 plot_periods]);

    subplot(3,3,4); hold on; grid on;
    plot(time_axis, get_dev('NW_H', oo_base), 'b-', time_axis, get_dev('NW_M', oo_base), 'r-', time_axis, get_dev('NW_S', oo_base), 'g-', 'LineWidth', 2);
    if is_sens; plot(time_axis, get_dev('NW_H', oo_alt), 'b--', time_axis, get_dev('NW_M', oo_alt), 'r--', time_axis, get_dev('NW_S', oo_alt), 'g--', 'LineWidth', 1.5); legend('NW_H (Base)','NW_M (Base)','NW_S (Base)','NW_H (Alt)','NW_M (Alt)','NW_S (Alt)','Location','best');
    else; legend('NW_H', 'NW_M', 'NW_S', 'Location', 'best'); end
    title('Net Wealth (% Dev)'); xlim([1 plot_periods]);

    subplot(3,3,5); hold on; grid on;
    plot(time_axis, get_dev('Y', oo_base), 'b-', time_axis, get_dev('L', oo_base), 'r-', time_axis, get_dev('K', oo_base), 'g-', 'LineWidth', 2);
    if is_sens; plot(time_axis, get_dev('Y', oo_alt), 'b--', time_axis, get_dev('L', oo_alt), 'r--', time_axis, get_dev('K', oo_alt), 'g--', 'LineWidth', 1.5); legend('Y (Base)','L (Base)','K (Base)','Y (Alt)','L (Alt)','K (Alt)','Location','best');
    else; legend('Y', 'L', 'K', 'Location', 'best'); end
    title('Aggregates (% Dev)'); xlim([1 plot_periods]);

    subplot(3,3,6); hold on; grid on;
    plot(time_axis, get_dev('mc', oo_base), 'b-', time_axis, get_dev('I', oo_base), 'r-', time_axis, get_dev('w', oo_base), 'g-', 'LineWidth', 2);
    if is_sens; plot(time_axis, get_dev('mc', oo_alt), 'b--', time_axis, get_dev('I', oo_alt), 'r--', time_axis, get_dev('w', oo_alt), 'g--', 'LineWidth', 1.5); legend('mc (Base)','I (Base)','w (Base)','mc (Alt)','I (Alt)','w (Alt)','Location','best');
    else; legend('mc', 'I', 'w', 'Location', 'best'); end
    title('Firm Metrics (% Dev)'); xlim([1 plot_periods]);

    subplot(3,3,7); hold on; grid on;
    plot(time_axis, get_dev('s', oo_base), 'b-', time_axis, get_dev('q', oo_base), 'r-', time_axis, get_dev('r', oo_base), 'g-', 'LineWidth', 2);
    if is_sens; plot(time_axis, get_dev('s', oo_alt), 'b--', time_axis, get_dev('q', oo_alt), 'r--', time_axis, get_dev('r', oo_alt), 'g--', 'LineWidth', 1.5); legend('s (Base)','q (Base)','r (Base)','s (Alt)','q (Alt)','r (Alt)','Location','best');
    else; legend('s', 'q', 'r', 'Location', 'best'); end
    title('Prices (% Dev)'); xlim([1 plot_periods]);

    subplot(3,3,8); hold on; grid on;
    plot(time_axis, get_pp('i', oo_base), 'k-', time_axis, get_pp('i_m', oo_base), 'r-', time_axis, get_pp('i_d', oo_base), 'b-', 'LineWidth', 2);
    if is_sens; plot(time_axis, get_pp('i', oo_alt), 'k--', time_axis, get_pp('i_m', oo_alt), 'r--', time_axis, get_pp('i_d', oo_alt), 'b--', 'LineWidth', 1.5); legend('i (Base)','i_m (Base)','i_d (Base)','i (Alt)','i_m (Alt)','i_d (Alt)','Location','southeast');
    else; legend('Policy (i)', 'Mortgage (i^m)', 'Deposit (i^d)', 'Location', 'southeast'); end
    title('Interest Rates (Ann. pp dev)'); xlim([1 plot_periods]);

    subplot(3,3,9); hold on; grid on;
    plot(time_axis, get_pp('pi_var', oo_base), 'k-', time_axis, get_pp('pi_w_H', oo_base), 'b-', time_axis, get_pp('pi_w_M', oo_base), 'r-', 'LineWidth', 2);
    if is_sens; plot(time_axis, get_pp('pi_var', oo_alt), 'k--', time_axis, get_pp('pi_w_H', oo_alt), 'b--', time_axis, get_pp('pi_w_M', oo_alt), 'r--', 'LineWidth', 1.5); legend('pi (Base)','pi_w_H (Base)','pi_w_M (Base)','pi (Alt)','pi_w_H (Alt)','pi_w_M (Alt)','Location','best');
    else; legend('pi', 'pi_w_H', 'pi_w_M', 'Location', 'best'); end
    title('Inflation (Ann. pp dev)'); xlim([1 plot_periods]);

    if is_sens; add_footer(); end
    exportgraphics(fig1, fullfile(out_dir, 'Fig1_HH_Dynamics.pdf'), 'ContentType', 'vector');


    %% ------------- FIGURE 2: Financial, Housing & Public Sector -------------
    fig2 = figure('Name', 'Financial, Housing & Public Sector', 'Position', [150, 150, 1200, 800], 'Visible', fig_vis);

    subplot(3,3,1); hold on; grid on;
    plot(time_axis, get_dev('m_H', oo_base), 'b-', time_axis, get_dev('m_cH', oo_base), 'r-', 'LineWidth', 2);
    if is_sens; plot(time_axis, get_dev('m_H', oo_alt), 'b--', time_axis, get_dev('m_cH', oo_alt), 'r--', 'LineWidth', 1.5); legend('m_H (Base)','m_cH (Base)','m_H (Alt)','m_cH (Alt)','Location','best');
    else; legend('Bank Deposits (m_H)', 'RFA Deposits (m_cH)', 'Location', 'best'); end
    title('H Deposits (% Dev)'); xlim([1 plot_periods]);

    subplot(3,3,2); hold on; grid on;
    plot(time_axis, get_dev('n_M', oo_base), 'r-', time_axis, get_dev('b_S', oo_base), 'g-', 'LineWidth', 2);
    if is_sens; plot(time_axis, get_dev('n_M', oo_alt), 'r--', time_axis, get_dev('b_S', oo_alt), 'g--', 'LineWidth', 1.5); legend('n_M (Base)','b_S (Base)','n_M (Alt)','b_S (Alt)','Location','best');
    else; legend('M Mortgages (n_M)', 'S Bonds (b_S)', 'Location', 'best'); end
    title('Debt & Bonds (% Dev)'); xlim([1 plot_periods]);

    subplot(3,3,3); hold on; grid on;
    plot(time_axis, get_dev('H_M', oo_base), 'b-', time_axis, get_dev('H_S', oo_base), 'g-', time_axis, get_dev('mu', oo_base), 'r-', 'LineWidth', 2);
    if is_sens; plot(time_axis, get_dev('H_M', oo_alt), 'b--', time_axis, get_dev('H_S', oo_alt), 'g--', time_axis, get_dev('mu', oo_alt), 'r--', 'LineWidth', 1.5); legend('H_M (Base)','H_S (Base)','mu (Base)','H_M (Alt)','H_S (Alt)','mu (Alt)','Location','best');
    else; legend('H_M', 'H_S', 'Multiplier (mu)', 'Location', 'best'); end
    title('Housing & Constraint (% Dev)'); xlim([1 plot_periods]);

    subplot(3,3,4); hold on; grid on;
    plot(time_axis, get_dev('C', oo_base), 'k-', 'LineWidth', 2);
    if is_sens; plot(time_axis, get_dev('C', oo_alt), 'k--', 'LineWidth', 1.5); legend('C (Base)','C (Alt)','Location','best');
    else; legend('Total Consumption (C)', 'Location', 'best'); end
    title('Aggregate Consumption (% Dev)'); xlim([1 plot_periods]);

    subplot(3,3,5); hold on; grid on;
    plot(time_axis, get_lvl('d_i', oo_base), 'b-', time_axis, get_lvl('d_b', oo_base), 'r-', time_axis, get_lvl('d_k', oo_base), 'g-', 'LineWidth', 2);
    if is_sens; plot(time_axis, get_lvl('d_i', oo_alt), 'b--', time_axis, get_lvl('d_b', oo_alt), 'r--', time_axis, get_lvl('d_k', oo_alt), 'g--', 'LineWidth', 1.5); legend('d_i (Base)','d_b (Base)','d_k (Base)','d_i (Alt)','d_b (Alt)','d_k (Alt)','Location','best');
    else; legend('Goods (d^i)', 'Banks (d^b)', 'Capital (d^k)', 'Location', 'best'); end
    title('Profits (Levels)'); xlim([1 plot_periods]);

    subplot(3,3,6); hold on; grid on;
    plot(time_axis, get_lvl('T_H', oo_base), 'b-', time_axis, get_lvl('T_M', oo_base), 'r-', time_axis, get_lvl('T_S', oo_base), 'g-', 'LineWidth', 2);
    if is_sens; plot(time_axis, get_lvl('T_H', oo_alt), 'b--', time_axis, get_lvl('T_M', oo_alt), 'r--', time_axis, get_lvl('T_S', oo_alt), 'g--', 'LineWidth', 1.5); legend('T_H (Base)','T_M (Base)','T_S (Base)','T_H (Alt)','T_M (Alt)','T_S (Alt)','Location','best');
    else; legend('T_H', 'T_M', 'T_S', 'Location', 'best'); end
    title('Transfers (Levels)'); xlim([1 plot_periods]);

    if is_sens; add_footer(); end
    exportgraphics(fig2, fullfile(out_dir, 'Fig2_FHP_Dynamics.pdf'), 'ContentType', 'vector');


    %% ------------- FIGURE 3: Welfare, Inequality & Shocks -------------
    fig3 = figure('Name', 'Welfare, Inequality & Shocks', 'Position', [200, 200, 1000, 600], 'Visible', fig_vis);

    subplot(2,2,1); hold on; grid on;
    plot(time_axis, get_exo_lvl('varpi', oo_base), 'k-', 'LineWidth', 2);
    if is_sens; plot(time_axis, get_exo_lvl('varpi', oo_alt), 'k--', 'LineWidth', 1.5); legend('varpi (Base)', 'varpi (Alt)', 'Location', 'best');
    else; legend('varpi', 'Location', 'best'); end
    title('Deposit Bundle Shock (varpi)'); xlim([1 plot_periods]);

    subplot(2,2,2); hold on; grid on;
    plot(time_axis, get_lvl('W_TOT', oo_base), 'g-', 'LineWidth', 2);
    if is_sens; plot(time_axis, get_lvl('W_TOT', oo_alt), 'g--', 'LineWidth', 1.5); legend('W_TOT (Base)', 'W_TOT (Alt)', 'Location', 'best');
    else; legend('W_{TOT}', 'Location', 'best'); end
    title('Total Welfare (Levels)'); xlim([1 plot_periods]);

    subplot(2,2,3); hold on; grid on;
    plot(time_axis, get_lvl('GINI_I', oo_base), 'b-', 'LineWidth', 2);
    if is_sens; plot(time_axis, get_lvl('GINI_I', oo_alt), 'b--', 'LineWidth', 1.5); legend('Income Gini (Base)', 'Income Gini (Alt)', 'Location', 'best');
    else; legend('Income Gini', 'Location', 'best'); end
    title('Income Inequality (Levels)'); xlim([1 plot_periods]);

    subplot(2,2,4); hold on; grid on;
    plot(time_axis, get_lvl('GINI_W', oo_base), 'r-', 'LineWidth', 2);
    if is_sens; plot(time_axis, get_lvl('GINI_W', oo_alt), 'r--', 'LineWidth', 1.5); legend('Wealth Gini (Base)', 'Wealth Gini (Alt)', 'Location', 'best');
    else; legend('Wealth Gini', 'Location', 'best'); end
    title('Wealth Inequality (Levels)'); xlim([1 plot_periods]);

    if is_sens; add_footer(); end
    exportgraphics(fig3, fullfile(out_dir, 'Fig3_WI_Dynamics.pdf'), 'ContentType', 'vector');


    %% ------------- FIGURE 5: Banking -------------
    fig5 = figure('Name', 'Banking', 'Position', [200, 200, 1000, 600], 'Visible', fig_vis);

    subplot(2,2,1); hold on; grid on;
    plot(time_axis, get_dev('m', oo_base), 'b-', 'LineWidth', 2);
    if is_sens; plot(time_axis, get_dev('m', oo_alt), 'b--', 'LineWidth', 1.5); legend('m (Base)', 'm (Alt)', 'Location', 'best');
    else; legend('m', 'Location', 'best'); end
    title('Bank Deposit Funding (% Dev)'); xlim([1 plot_periods]);

    subplot(2,2,3); hold on; grid on;
    plot(time_axis, get_dev('n', oo_base), 'r-', time_axis, get_dev('b', oo_base), 'g-', 'LineWidth', 2);
    if is_sens; plot(time_axis, get_dev('n', oo_alt), 'r--', time_axis, get_dev('b', oo_alt), 'g--', 'LineWidth', 1.5); legend('n (Base)', 'b (Base)', 'n (Alt)', 'b (Alt)', 'Location', 'best');
    else; legend('n', 'b', 'Location', 'best'); end
    title('Bank Bonds & Mortgages (% Dev)'); xlim([1 plot_periods]);

    subplot(2,2,2); hold on; grid on;
    plot(time_axis, get_dev('m_cB', oo_base), 'b-', time_axis, get_dev('f', oo_base), 'r-', 'LineWidth', 2);
    if is_sens; plot(time_axis, get_dev('m_cB', oo_alt), 'b--', time_axis, get_dev('f', oo_alt), 'r--', 'LineWidth', 1.5); legend('m_cB (Base)', 'f (Base)', 'm_cB (Alt)', 'f (Alt)', 'Location', 'best');
    else; legend('m_cB', 'f', 'Location', 'best'); end
    title('Bank Reserves & CB Loans (% Dev)'); xlim([1 plot_periods]);

    subplot(2,2,4); hold on; grid on;
    plot(time_axis, get_pp('i_f', oo_base), 'r-', 'LineWidth', 2);
    if is_sens; plot(time_axis, get_pp('i_f', oo_alt), 'r--', 'LineWidth', 1.5); legend('i_f (Base)', 'i_f (Alt)', 'Location', 'southeast');
    else; legend('i^f', 'Location', 'southeast'); end
    title('Lending Rate (Ann. pp dev)'); xlim([1 plot_periods]);

    if is_sens; add_footer(); end
    exportgraphics(fig5, fullfile(out_dir, 'Fig5_Bank_Dynamics.pdf'), 'ContentType', 'vector');


    %% ------------- 4. Steady-State Comparison Table -------------
    var_names = cellstr(M_.endo_names);

    if is_sens
        num_vars = length(var_names);
        
        % Preallocate cell arrays for the TRUE/FALSE strings
        Check_Init_SS  = cell(num_vars, 1);
        Check_Final_SS = cell(num_vars, 1);
        
        % Adds check to see if paramter change changes steady-states.
        % Using 1e-6 tolerance to avoid floating-point errors.
        for i = 1:num_vars
            % Check Initial SS
            if abs(oo_base.endo_simul(i, 1) - oo_alt.endo_simul(i, 1)) < 1e-6
                Check_Init_SS{i} = 'TRUE';
            else
                Check_Init_SS{i} = 'FALSE';
            end
            
            % Check Final SS
            if abs(oo_base.endo_simul(i, end) - oo_alt.endo_simul(i, end)) < 1e-6
                Check_Final_SS{i} = 'TRUE';
            else
                Check_Final_SS{i} = 'FALSE';
            end
        end
        
        % Append the calculated TRUE/FALSE columns to the table
        SS_Table = table(var_names, oo_base.endo_simul(:, 1), oo_base.endo_simul(:, end), ...
                                    oo_alt.endo_simul(:, 1), oo_alt.endo_simul(:, end), ...
                                    Check_Init_SS, Check_Final_SS, ...
            'VariableNames', {'Variable', 'Base_Init_SS', 'Base_Final_SS', 'Alt_Init_SS', 'Alt_Final_SS', 'Check_Init_SS', 'Check_Final_SS'});
            
        writetable(SS_Table, fullfile(out_dir, sprintf('SS_Comparison_%s.xlsx', param_name)));
    else
        SS_Table = table(var_names, oo_base.endo_simul(:, 1), oo_base.endo_simul(:, end), ...
            'VariableNames', {'Variable', 'Init_SS', 'Final_SS'});
        writetable(SS_Table, fullfile(out_dir, 'SS_Comparison.xlsx'));
    end


    %% ------------- 5. Path in Levels -------------
    var_list = {'C_H', 'C_M', 'C_S', 'L_H', 'L_M', 'C', 'INC_H', 'INC_M', 'INC_S', ...
                'NW_H', 'NW_M', 'NW_S', 'mc', 'Y', 'L', 'K', 'I', 'w', 's', 'q', ...
                'r', 'i', 'i_m', 'i_d', 'pi_var', 'mu', 'i_r', 'm_H', 'm_cH', 'H_M' ...
                'H_S', 'n_M', 'b_S', 'd_S', 'd_i', 'd_b', 'd_k', 'SR_H', 'SR_M', 'SR_S', 'GINI_I', 'GINI_W', ...
                'm_cB', 'f', 'i_f', 'V_H', 'V_M', 'V_S', 'W_TOT'};

    num_vars = length(var_list);
    num_cols = 7;
    num_rows = ceil(num_vars / num_cols);

    figf = figure('Name', 'Steady-State Transition (Zoomed)', 'Position', [50, 50, 2000, 1300], 'Visible', fig_vis);

    for iter = 1:num_vars
        var_name = var_list{iter};
        subplot(num_rows, num_cols, iter);
        hold on;
        
        var_idx = strmatch(var_name, M_.endo_names, 'exact');
        if ~isempty(var_idx)
            y_base    = oo_base.endo_simul(var_idx, 2:plot_periods+1);
            ss_i_base = oo_base.endo_simul(var_idx, 1);
            ss_f_base = oo_base.endo_simul(var_idx, end); 
            
            plot(1:plot_periods, y_base, 'LineWidth', 2, 'Color', 'b');
            yline(ss_i_base, '--c', 'LineWidth', 1.2); 
            yline(ss_f_base, '-.m', 'LineWidth', 1.5); 
            
            if is_sens
                y_alt    = oo_alt.endo_simul(var_idx, 2:plot_periods+1);
                ss_f_alt = oo_alt.endo_simul(var_idx, end);
                plot(1:plot_periods, y_alt, 'LineWidth', 1.5, 'Color', 'r', 'LineStyle', '--');
                yline(ss_f_alt, ':r', 'LineWidth', 1.5);
            end
            
        else
            var_idx = strmatch(var_name, M_.exo_names, 'exact');
            if ~isempty(var_idx)
                y_base    = oo_base.exo_simul(2:plot_periods+1, var_idx)';
                ss_i_base = oo_base.exo_simul(1, var_idx);
                ss_f_base = oo_base.exo_simul(end, var_idx);
                
                plot(1:plot_periods, y_base, 'LineWidth', 2, 'Color', 'b');
                yline(ss_i_base, '--k', 'LineWidth', 1.2);
                yline(ss_f_base, ':r', 'LineWidth', 1.5);
                
                if is_sens
                    y_alt    = oo_alt.exo_simul(2:plot_periods+1, var_idx)';
                    ss_f_alt = oo_alt.exo_simul(end, var_idx);
                    plot(1:plot_periods, y_alt, 'LineWidth', 1.5, 'Color', 'r', 'LineStyle', '--');
                    yline(ss_f_alt, ':m', 'LineWidth', 1.5);
                end
            else
                warning(['Variable ' var_name ' not found.']);
                continue;
            end
        end
        
        title(var_name, 'Interpreter', 'none'); 
        grid on;
        xlim([1 plot_periods]);
        hold off;
    end

    hLgdAxes = axes(figf, 'Position', [0 0 1 1], 'Visible', 'off');
    hold(hLgdAxes, 'on');

    % 2. Create invisible "dummy" lines that perfectly match your line styles
    h_base = plot(hLgdAxes, NaN, NaN, 'b-', 'LineWidth', 2);
    h_ss_i = plot(hLgdAxes, NaN, NaN, 'c--', 'LineWidth', 1.2);
    h_ss_f = plot(hLgdAxes, NaN, NaN, 'm-.', 'LineWidth', 1.5);

    % 3. Group handles and labels
    lgd_handles = [h_base, h_ss_i, h_ss_f];
    lgd_labels  = {'Baseline Path', 'Initial SS', 'Final SS'};

    % 4. Add the sensitivity (alt) lines if applicable
    if is_sens
        h_alt      = plot(hLgdAxes, NaN, NaN, 'r--', 'LineWidth', 1.5);
        h_ss_f_alt = plot(hLgdAxes, NaN, NaN, 'r:', 'LineWidth', 1.5);
        
        lgd_handles = [lgd_handles, h_alt, h_ss_f_alt];
        lgd_labels  = [lgd_labels, {'Alt Path', 'Final SS (Alt)'}];
    end

    % 5. Create the global legend
    lgd = legend(hLgdAxes, lgd_handles, lgd_labels, ...
        'Orientation', 'horizontal', ...
        'Location', 'south', ... % Places it at the bottom center of the figure
        'FontSize', 12, ...
        'Box', 'off');
    % --- END OF LEGEND CODE ---

    if is_sens; add_footer(); end
    exportgraphics(figf, fullfile(out_dir, 'Fig6_transition_levels.pdf'), 'ContentType', 'vector');


    %% ------------- 6. Full Diagnostic Path (All Periods) -------------
    % Massive, zoomed-out 49-panel grid for full diagnostic checking over 500 periods
    
    fig_diag = figure('Name', 'Full Diagnostic Path (All Periods)', 'Position', [50, 50, 2000, 1300], 'Visible', fig_vis);

    for iter = 1:num_vars
        var_name = var_list{iter};
        subplot(num_rows, num_cols, iter);
        hold on;
        
        var_idx = strmatch(var_name, M_.endo_names, 'exact');
        
        if ~isempty(var_idx)
            % Plot Endogenous from period 1 to options_.periods + 2
            plot(1:options_.periods+2, oo_base.endo_simul(var_idx, 1:options_.periods+2), 'LineWidth', 2, 'Color', 'b');
            if is_sens
                plot(1:options_.periods+2, oo_alt.endo_simul(var_idx, 1:options_.periods+2), 'LineWidth', 1.5, 'Color', 'r', 'LineStyle', '--');
            end
        else
            % Plot Exogenous from period 1 to options_.periods + 2
            var_idx = strmatch(var_name, M_.exo_names, 'exact');
            if ~isempty(var_idx)
                % oo_.exo_simul needs transposed orienting to match X-axis length
                plot(1:options_.periods+2, oo_base.exo_simul(1:options_.periods+2, var_idx)', 'LineWidth', 2, 'Color', 'b');
                if is_sens
                    plot(1:options_.periods+2, oo_alt.exo_simul(1:options_.periods+2, var_idx)', 'LineWidth', 1.5, 'Color', 'r', 'LineStyle', '--');
                end
            else
                warning(['Variable ' var_name ' not found.']);
                continue;
            end
        end
        
        title(var_name, 'Interpreter', 'none'); 
        grid on;
        xlim([1 options_.periods+2]);
        hold off;
    end

    if is_sens; add_footer(); end
    exportgraphics(fig_diag, fullfile(out_dir, 'full_diagnostic.pdf'), 'ContentType', 'vector');


    %% ------------- Clean Up -------------
    % Close memory load safely if figures are hidden
    if ~show_graphs
        close all; 
    end

end