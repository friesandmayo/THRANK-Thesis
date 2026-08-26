function post_process_results(run_type, out_dir, M_, options_, oo_base, oo_alt, param_name, val_base, val_alt, show_graphs)
    %% ------------- 0. Setup -------------
    if ~exist(out_dir, 'dir')
        mkdir(out_dir);
    end
    
    plot_periods = 70; 
    time_axis = 1:plot_periods;     % Do not change
    data_idx  = 1:plot_periods;     % 1:plot_periods to start graphs before shock, 2:plot_periods+1 to start graphs on shock impact. DOES NOT apply to CEV. 
    time_axis_full = 1:options_.periods;
    small_graph_size = [100, 100, 500, 300];

    % Identify run type
    is_sens = strcmp(run_type, 'sensitivity');
    is_scen = strcmp(run_type, 'scenario');
    is_alt  = is_sens || is_scen; % Master flag for plotting/saving alternate data
    
    % Toggle Visibility
    if show_graphs
        fig_vis = 'on';
    else
        fig_vis = 'off';
    end
    
    % Footer logic
    param_note = '';
    file_suffix = param_name; 
    if is_sens
        param_note = sprintf('%s: Base = %g | Alt = %g', param_name, val_base, val_alt);
    elseif is_scen
        % For scenarios, val_base carries the pre-constructed multi-parameter string
        param_note = val_base; 
    end
    
    add_footer = @() annotation('textbox', [0, 0.01, 1, 0.04], 'String', param_note, ...
        'EdgeColor', 'none', 'HorizontalAlignment', 'center', ...
        'FontSize', 10, 'FontWeight', 'bold', 'Interpreter', 'none');
        
    %% ------------- 1. Data Extraction Helpers -------------
    get_dev = @(var, oo_str) (oo_str.endo_simul(strmatch(var, M_.endo_names, 'exact'), data_idx) - ...
                              oo_str.endo_simul(strmatch(var, M_.endo_names, 'exact'), 1)) ...
                              ./ oo_str.endo_simul(strmatch(var, M_.endo_names, 'exact'), 1) * 100;
                              
    get_pp  = @(var, oo_str) (oo_str.endo_simul(strmatch(var, M_.endo_names, 'exact'), data_idx) - ...
                              oo_str.endo_simul(strmatch(var, M_.endo_names, 'exact'), 1)) * 400; 
                              
    get_pp_not_int  = @(var, oo_str) (oo_str.endo_simul(strmatch(var, M_.endo_names, 'exact'), data_idx) - ...
                              oo_str.endo_simul(strmatch(var, M_.endo_names, 'exact'), 1)) * 100; 
                              
    get_lvl = @(var, oo_str) oo_str.endo_simul(strmatch(var, M_.endo_names, 'exact'), data_idx);
    
    get_exo_lvl = @(var, oo_str) oo_str.exo_simul(data_idx, strmatch(var, M_.exo_names, 'exact'))';

    %% ------------- 2. Calculate Welfare Variation (CEV) ------------- 
    % Extract necessary parameters
    betta_H  = M_.params(strmatch('betta_H', M_.param_names, 'exact'));
    betta_M  = M_.params(strmatch('betta_M', M_.param_names, 'exact'));
    betta_S  = M_.params(strmatch('betta_S', M_.param_names, 'exact'));
    lambda_H = M_.params(strmatch('lambda_H', M_.param_names, 'exact'));
    lambda_M = M_.params(strmatch('lambda_M', M_.param_names, 'exact'));
    lambda_S = M_.params(strmatch('lambda_S', M_.param_names, 'exact'));
    sigma    = M_.params(strmatch('sigma', M_.param_names, 'exact'));
    
    % Package parameters for local functions
    params = struct('betta_H', betta_H, 'betta_M', betta_M, 'betta_S', betta_S, ...
                    'lambda_H', lambda_H, 'lambda_M', lambda_M, 'lambda_S', lambda_S, ...
                    'sigma', sigma);
                    
    % Indices for Period Utility (U) and Consumption (C)
    idx.U_H = strmatch('U_H', M_.endo_names, 'exact'); idx.C_H = strmatch('C_H', M_.endo_names, 'exact');
    idx.U_M = strmatch('U_M', M_.endo_names, 'exact'); idx.C_M = strmatch('C_M', M_.endo_names, 'exact');
    idx.U_S = strmatch('U_S', M_.endo_names, 'exact'); idx.C_S = strmatch('C_S', M_.endo_names, 'exact');
    
    % Function to calculate cumulative backward-looking CEV (Individual)
    calc_cev_cumulative = @(idx_U, idx_C, betta, oo_str) ...
    (1 + ( ...
        (cumsum(oo_str.endo_simul(idx_U, 1:options_.periods) .* (betta.^(0:options_.periods-1))) ./ ...
         cumsum(betta.^(0:options_.periods-1))) ... 
        - oo_str.endo_simul(idx_U, 1) ... 
    ) .* (1 - sigma) ./ (oo_str.endo_simul(idx_C, 1).^(1-sigma))) .^ (1/(1-sigma)) - 1;
    
    % Function to calculate the CEV gains/losses from the old SS to the new SS (Individual)
    calc_cev_ss = @(idx_U, idx_C, oo_str) ...
        (1 + ( ...
            (oo_str.endo_simul(idx_U, end) - oo_str.endo_simul(idx_U, 1))*(1-sigma) / ...
            ((oo_str.endo_simul(idx_C, 1))^(1-sigma))))^(1/(1-sigma)) - 1;
            
    % Calculate Base CEVs
    CEV_H_base = calc_cev_cumulative(idx.U_H, idx.C_H, betta_H, oo_base);
    CEV_M_base = calc_cev_cumulative(idx.U_M, idx.C_M, betta_M, oo_base);
    CEV_S_base = calc_cev_cumulative(idx.U_S, idx.C_S, betta_S, oo_base);
    CEV_Agg_base = calc_aggregate_cev(oo_base, options_, idx, params);
    
    CEV_H_ss_base   = calc_cev_ss(idx.U_H, idx.C_H, oo_base);
    CEV_M_ss_base   = calc_cev_ss(idx.U_M, idx.C_M, oo_base);
    CEV_S_ss_base   = calc_cev_ss(idx.U_S, idx.C_S, oo_base);
    CEV_Agg_ss_base = calc_aggregate_cev_ss(oo_base, options_, idx, params);
    
    if is_alt
        % Calculate Alt CEVs
        CEV_H_alt = calc_cev_cumulative(idx.U_H, idx.C_H, betta_H, oo_alt);
        CEV_M_alt = calc_cev_cumulative(idx.U_M, idx.C_M, betta_M, oo_alt);
        CEV_S_alt = calc_cev_cumulative(idx.U_S, idx.C_S, betta_S, oo_alt);
        CEV_Agg_alt = calc_aggregate_cev(oo_alt, options_, idx, params);
        
        CEV_H_ss_alt   = calc_cev_ss(idx.U_H, idx.C_H, oo_alt);
        CEV_M_ss_alt   = calc_cev_ss(idx.U_M, idx.C_M, oo_alt);
        CEV_S_ss_alt   = calc_cev_ss(idx.U_S, idx.C_S, oo_alt);
        CEV_Agg_ss_alt = calc_aggregate_cev_ss(oo_alt, options_, idx, params);
    end
    
    % Create a summary table to save (values in percentage)
    Agent = {'H'; 'M'; 'S'; 'Aggregate'};
    CEV_SS_Base_Pct = [CEV_H_ss_base; CEV_M_ss_base; CEV_S_ss_base; CEV_Agg_ss_base] * 100;
    CEV_Trans_Final_Base_Pct = [CEV_H_base(end); CEV_M_base(end); CEV_S_base(end); CEV_Agg_base(end)] * 100;
    
    if is_alt        
        CEV_SS_Alt_Pct = [CEV_H_ss_alt; CEV_M_ss_alt; CEV_S_ss_alt; CEV_Agg_ss_alt] * 100;
        CEV_Trans_Final_Alt_Pct = [CEV_H_alt(end); CEV_M_alt(end); CEV_S_alt(end); CEV_Agg_alt(end)] * 100;
        
        CEV_Table = table(Agent, CEV_SS_Base_Pct, CEV_Trans_Final_Base_Pct, CEV_SS_Alt_Pct, CEV_Trans_Final_Alt_Pct);
        writetable(CEV_Table, fullfile(out_dir, sprintf('SS_CEV_Summary_%s.xlsx', file_suffix)));
    else
        CEV_Table = table(Agent, CEV_SS_Base_Pct, CEV_Trans_Final_Base_Pct);
        writetable(CEV_Table, fullfile(out_dir, 'SS_CEV_Summary.xlsx'));
    end

    %% ------------- Transition Plots -------------
    dir_fig_trans = fullfile(out_dir, 'Transition_Plots');
    if ~exist(dir_fig_trans, 'dir'); mkdir(dir_fig_trans); end
    
    % Plot 1: Saving Rates
    fig = figure('Name', 'Saving Rates', 'Position', small_graph_size, 'Visible', fig_vis);
    hold on; grid on; box on;
    plot(time_axis, get_pp_not_int('SR_H', oo_base), 'b-', time_axis, get_pp_not_int('SR_M', oo_base), 'r-', time_axis, get_pp_not_int('SR_S', oo_base), 'g-', 'LineWidth', 1.5);
    if is_alt
        plot(time_axis, get_pp_not_int('SR_H', oo_alt), 'b--', time_axis, get_pp_not_int('SR_M', oo_alt), 'r--', time_axis, get_pp_not_int('SR_S', oo_alt), 'g--', 'LineWidth', 1.0); 
        legend('SR_H (Base)', 'SR_M (Base)', 'SR_S (Base)', 'SR_H (Alt)', 'SR_M (Alt)', 'SR_S (Alt)', 'Location', 'best');
    else
        legend('SR_H', 'SR_M', 'SR_S', 'Location', 'best'); 
    end
    %title('Saving Rates (pp dev)'); 
    xlabel('Periods'); ylabel('pp dev'); xlim([1 plot_periods]);
    if is_alt; add_footer(); end
    exportgraphics(fig, fullfile(dir_fig_trans, 'trans_Saving_Rates.pdf'), 'ContentType', 'vector');
    if ~show_graphs; close(fig); end

    % Plot 2: Individual Consumption
    fig = figure('Name', 'Individual Consumption', 'Position', small_graph_size, 'Visible', fig_vis);
    hold on; grid on; box on;
    plot(time_axis, get_dev('C_H', oo_base), 'b-', time_axis, get_dev('C_M', oo_base), 'r-', time_axis, get_dev('C_S', oo_base), 'g-', 'LineWidth', 1.5);
    if is_alt
        plot(time_axis, get_dev('C_H', oo_alt), 'b--', time_axis, get_dev('C_M', oo_alt), 'r--', time_axis, get_dev('C_S', oo_alt), 'g--', 'LineWidth', 1.0); 
        legend('C_H (Base)','C_M (Base)','C_S (Base)','C_H (Alt)','C_M (Alt)','C_S (Alt)', 'Location', 'best');
    else
        legend('C_H', 'C_M', 'C_S', 'Location', 'best'); 
    end
    %title('Individual Consumption (% Dev)');
    xlabel('Periods'); ylabel('% Dev'); xlim([1 plot_periods]);
    if is_alt; add_footer(); end
    exportgraphics(fig, fullfile(dir_fig_trans, 'trans_Individual_Consumption.pdf'), 'ContentType', 'vector');
    if ~show_graphs; close(fig); end

    % Plot 3: Individual Incomes
    fig = figure('Name', 'Individual Incomes', 'Position', small_graph_size, 'Visible', fig_vis);
    hold on; grid on; box on;
    plot(time_axis, get_dev('INC_H', oo_base), 'b-', time_axis, get_dev('INC_M', oo_base), 'r-', time_axis, get_dev('INC_S', oo_base), 'g-', 'LineWidth', 1.5);
    if is_alt
        plot(time_axis, get_dev('INC_H', oo_alt), 'b--', time_axis, get_dev('INC_M', oo_alt), 'r--', time_axis, get_dev('INC_S', oo_alt), 'g--', 'LineWidth', 1.0); 
        legend('INC_H (Base)','INC_M (Base)','INC_S (Base)','INC_H (Alt)','INC_M (Alt)','INC_S (Alt)', 'Location', 'best');
    else
        legend('INC_H', 'INC_M', 'INC_S', 'Location', 'best'); 
    end
    %title('Individual Incomes (% Dev)'); 
    xlabel('Periods'); ylabel('% Dev'); xlim([1 plot_periods]);
    if is_alt; add_footer(); end
    exportgraphics(fig, fullfile(dir_fig_trans, 'trans_Individual_Incomes.pdf'), 'ContentType', 'vector');
    if ~show_graphs; close(fig); end

    % Plot 4: Individual Wealth
    fig = figure('Name', 'Individual Wealth', 'Position', small_graph_size, 'Visible', fig_vis);
    hold on; grid on; box on;
    plot(time_axis, get_dev('NW_H', oo_base), 'b-', time_axis, get_dev('NW_M', oo_base), 'r-', time_axis, get_dev('NW_S', oo_base), 'g-', 'LineWidth', 1.5);
    if is_alt
        plot(time_axis, get_dev('NW_H', oo_alt), 'b--', time_axis, get_dev('NW_M', oo_alt), 'r--', time_axis, get_dev('NW_S', oo_alt), 'g--', 'LineWidth', 1.0); 
        legend('NW_H (Base)','NW_M (Base)','NW_S (Base)','NW_H (Alt)','NW_M (Alt)','NW_S (Alt)', 'Location', 'best');
    else
        legend('NW_H', 'NW_M', 'NW_S', 'Location', 'best'); 
    end
    %title('Individual Wealth (% Dev)');
    xlabel('Periods'); ylabel('% Dev'); xlim([1 plot_periods]);
    if is_alt; add_footer(); end
    exportgraphics(fig, fullfile(dir_fig_trans, 'trans_Individual_Wealth.pdf'), 'ContentType', 'vector');
    if ~show_graphs; close(fig); end

    % Plot 5: Individual Labour
    fig = figure('Name', 'Individual Labour', 'Position', small_graph_size, 'Visible', fig_vis);
    hold on; grid on; box on;
    plot(time_axis, get_dev('L_H', oo_base), 'b-', time_axis, get_dev('L_M', oo_base), 'r-', 'LineWidth', 1.5);
    if is_alt
        plot(time_axis, get_dev('L_H', oo_alt), 'b--', time_axis, get_dev('L_M', oo_alt), 'r--', 'LineWidth', 1.0); 
        legend('L_H (Base)','L_M (Base)','L_H (Alt)','L_M (Alt)', 'Location', 'best');
    else
        legend('L_H', 'L_M', 'Location', 'best'); 
    end
    %title('Individual Labour (% Dev)'); 
    xlabel('Periods'); ylabel('% Dev'); xlim([1 plot_periods]);
    if is_alt; add_footer(); end
    exportgraphics(fig, fullfile(dir_fig_trans, 'trans_Individual_Labour.pdf'), 'ContentType', 'vector');
    if ~show_graphs; close(fig); end

    % Plot 6: Housing
    fig = figure('Name', 'Housing', 'Position', small_graph_size, 'Visible', fig_vis);
    hold on; grid on; box on;
    plot(time_axis, get_dev('H_M', oo_base), 'b-', time_axis, get_dev('H_S', oo_base), 'g-', 'LineWidth', 1.5);
    if is_alt
        plot(time_axis, get_dev('H_M', oo_alt), 'b--', time_axis, get_dev('H_S', oo_alt), 'g--', 'LineWidth', 1.0); 
        legend('H_M (Base)', 'H_S (Base)', 'H_M (Alt)', 'H_S (Alt)', 'Location', 'best');
    else
        legend('H_M', 'H_S', 'Location', 'best'); 
    end
    %title('Housing (% Dev)'); 
    xlabel('Periods'); ylabel('% Dev'); xlim([1 plot_periods]);
    if is_alt; add_footer(); end
    exportgraphics(fig, fullfile(dir_fig_trans, 'trans_Housing.pdf'), 'ContentType', 'vector');
    if ~show_graphs; close(fig); end

    % Plot 7: Consumption and Output
    fig = figure('Name', 'Consumption and Output', 'Position', small_graph_size, 'Visible', fig_vis);
    hold on; grid on; box on;
    plot(time_axis, get_dev('C', oo_base), 'k-', time_axis, get_dev('Y', oo_base), 'b-', 'LineWidth', 1.5);
    if is_alt
        plot(time_axis, get_dev('C', oo_alt), 'k--', time_axis, get_dev('Y', oo_alt), 'b--', 'LineWidth', 1.0); 
        legend('C (Base)', 'Y (Base)', 'C (Alt)', 'Y (Alt)', 'Location', 'best');
    else
        legend('Aggregate Consumption (C)', 'Aggregate Output (Y)', 'Location', 'best'); 
    end
    %title('Consumption and Output (% Dev)'); 
    xlabel('Periods'); ylabel('% Dev'); xlim([1 plot_periods]);
    if is_alt; add_footer(); end
    exportgraphics(fig, fullfile(dir_fig_trans, 'trans_Consumption_and_Output.pdf'), 'ContentType', 'vector');
    if ~show_graphs; close(fig); end

    % Plot 8: Capital and Investment
    fig = figure('Name', 'Capital and Investment', 'Position', small_graph_size, 'Visible', fig_vis);
    hold on; grid on; box on;
    plot(time_axis, get_dev('K', oo_base), 'b-', time_axis, get_dev('I', oo_base), 'r-', 'LineWidth', 1.5);
    if is_alt
        plot(time_axis, get_dev('K', oo_alt), 'b--', time_axis, get_dev('I', oo_alt), 'r--', 'LineWidth', 1.0); 
        legend('K (Base)', 'I (Base)', 'K (Alt)', 'I (Alt)', 'Location', 'best');
    else
        legend('Capital (K)', 'Investment (I)', 'Location', 'best'); 
    end
    %title('Capital and Investment (% Dev)'); 
    xlabel('Periods'); ylabel('% Dev'); xlim([1 plot_periods]);
    if is_alt; add_footer(); end
    exportgraphics(fig, fullfile(dir_fig_trans, 'trans_Capital_and_Investment.pdf'), 'ContentType', 'vector');
    if ~show_graphs; close(fig); end

    % Plot 9: CB Lending and Deposits
    fig = figure('Name', 'CB Lending and Deposits', 'Position', small_graph_size, 'Visible', fig_vis);
    hold on; grid on; box on;
    plot(time_axis, get_lvl('f', oo_base), 'b-', time_axis, get_lvl('m', oo_base), 'r-', 'LineWidth', 1.5);
    if is_alt
        plot(time_axis, get_lvl('f', oo_alt), 'b--', time_axis, get_lvl('m', oo_alt), 'r--', 'LineWidth', 1.0); 
        legend('f (Base)', 'm (Base)', 'f (Alt)', 'm (Alt)', 'Location', 'best');
    else
        legend('CB Lending (f)', 'Total Deposits (m)', 'Location', 'best'); 
    end
    %title('CB Lending and Deposits (Levels)'); 
    xlabel('Periods'); ylabel('Levels'); xlim([1 plot_periods]);
    if is_alt; add_footer(); end
    exportgraphics(fig, fullfile(dir_fig_trans, 'trans_CB_Lending_Deposits.pdf'), 'ContentType', 'vector');
    if ~show_graphs; close(fig); end

    % Plot 10: Inflation
    fig = figure('Name', 'Inflation', 'Position', small_graph_size, 'Visible', fig_vis);
    hold on; grid on; box on;
    plot(time_axis, get_pp('pi_var', oo_base), 'k-', time_axis, get_pp('pi_w_H', oo_base), 'b-', time_axis, get_pp('pi_w_M', oo_base), 'r-', 'LineWidth', 1.5);
    if is_alt
        plot(time_axis, get_pp('pi_var', oo_alt), 'k--', time_axis, get_pp('pi_w_H', oo_alt), 'b--', time_axis, get_pp('pi_w_M', oo_alt), 'r--', 'LineWidth', 1.0); 
        legend('\pi (Base)', '\pi^w_H (Base)', '\pi^w_M (Base)', '\pi (Alt)', '\pi^w_H (Alt)', '\pi^w_M (Alt)', 'Location', 'best');
    else
        legend('Price (\pi)', 'H Wage (\pi^w_H)', 'M Wage (\pi^w_M)', 'Location', 'best'); 
    end
    %title('Inflation (Ann. pp dev)'); 
    xlabel('Periods'); ylabel('Ann. pp dev'); xlim([1 plot_periods]);
    if is_alt; add_footer(); end
    exportgraphics(fig, fullfile(dir_fig_trans, 'trans_Inflation.pdf'), 'ContentType', 'vector');
    if ~show_graphs; close(fig); end

    % Plot 11: Interest Rates
    fig = figure('Name', 'Interest Rates', 'Position', small_graph_size, 'Visible', fig_vis);
    hold on; grid on; box on;
    plot(time_axis, get_pp('i', oo_base), 'k-', time_axis, get_pp('i_d', oo_base), 'b-', time_axis, get_pp('i_n', oo_base), 'r-', time_axis, get_pp('i_b', oo_base), 'g-', 'LineWidth', 1.5);
    if is_alt
        plot(time_axis, get_pp('i', oo_alt), 'k--', time_axis, get_pp('i_d', oo_alt), 'b--', time_axis, get_pp('i_n', oo_alt), 'r--', time_axis, get_pp('i_b', oo_alt), 'g--', 'LineWidth', 1.0); 
        legend('i', 'i_d', 'i_n', 'i_b',  'Alt versions...', 'Location', 'best'); 
    else
        legend('Policy (i)', 'Deposit (i_d)', 'Mortgage (i_n)', 'Bank Bond (i_b)',  'Location', 'best'); 
    end
    %title('Interest Rates (Ann. pp dev)'); 
    xlabel('Periods'); ylabel('Ann. pp dev'); xlim([1 plot_periods]);
    if is_alt; add_footer(); end
    exportgraphics(fig, fullfile(dir_fig_trans, 'trans_Interest_Rates.pdf'), 'ContentType', 'vector');
    if ~show_graphs; close(fig); end

    % Plot 12: Bonds and Borrowing Multiplier
    fig = figure('Name', 'Bonds and Borrowing Multiplier', 'Position', small_graph_size, 'Visible', fig_vis);
    hold on; grid on; box on;
    plot(time_axis, get_dev('b', oo_base), 'g-', time_axis, get_dev('mu', oo_base), 'r-', 'LineWidth', 1.5);
    if is_alt
        plot(time_axis, get_dev('b', oo_alt), 'g--', time_axis, get_dev('mu', oo_alt), 'r--', 'LineWidth', 1.0); 
        legend('b (Base)', '\mu (Base)', 'b (Alt)', '\mu (Alt)', 'Location', 'best');
    else
        legend('Total Bonds (b)', 'Borrowing Multiplier (\mu)', 'Location', 'best'); 
    end
    %title('Bonds and Borrowing Multiplier (% Dev)'); 
    xlabel('Periods'); ylabel('% Dev'); xlim([1 plot_periods]);
    if is_alt; add_footer(); end
    exportgraphics(fig, fullfile(dir_fig_trans, 'trans_Bonds_Multiplier.pdf'), 'ContentType', 'vector');
    if ~show_graphs; close(fig); end

    % Plot 13: Mortgages and House Prices
    fig = figure('Name', 'Mortgages and House Prices', 'Position', small_graph_size, 'Visible', fig_vis);
    hold on; grid on; box on;
    plot(time_axis, get_dev('n', oo_base), 'r-', time_axis, get_dev('s', oo_base), 'k-', 'LineWidth', 1.5);
    if is_alt
        plot(time_axis, get_dev('n', oo_alt), 'r--', time_axis, get_dev('s', oo_alt), 'k--', 'LineWidth', 1.0); 
        legend('n (Base)', 's (Base)', 'n (Alt)', 's (Alt)', 'Location', 'best');
    else
        legend('Total Mortgages (n)', 'House Price (s)', 'Location', 'best'); 
    end
    %title('Mortgages and House Prices (% Dev)'); 
    xlabel('Periods'); ylabel('% Dev'); xlim([1 plot_periods]);
    if is_alt; add_footer(); end
    exportgraphics(fig, fullfile(dir_fig_trans, 'trans_Mortgages_House_Prices.pdf'), 'ContentType', 'vector');
    if ~show_graphs; close(fig); end

    % Plot 14: Firm Metrics
    fig = figure('Name', 'Firm Metrics', 'Position', small_graph_size, 'Visible', fig_vis);
    hold on; grid on; box on;
    plot(time_axis, get_dev('mc', oo_base), 'b-', time_axis, get_dev('q', oo_base), 'r-', 'LineWidth', 1.5);
    if is_alt
        plot(time_axis, get_dev('mc', oo_alt), 'b--', time_axis, get_dev('q', oo_alt), 'r--', 'LineWidth', 1.0); 
        legend('mc (Base)', 'q (Base)', 'mc (Alt)', 'q (Alt)', 'Location', 'best');
    else
        legend('Marginal Cost (mc)', 'Tobins Q (q)', 'Location', 'best'); 
    end
    %title('Firm Metrics (% Dev)'); 
    xlabel('Periods'); ylabel('% Dev'); xlim([1 plot_periods]);
    if is_alt; add_footer(); end
    exportgraphics(fig, fullfile(dir_fig_trans, 'trans_Firm_Metrics.pdf'), 'ContentType', 'vector');
    if ~show_graphs; close(fig); end

    %% ------------- GINI AND CEV PLOTS -------------
    
    % Plot: Income Gini
    fig = figure('Name', 'Income Gini', 'Position', small_graph_size, 'Visible', fig_vis);
    hold on; grid on; box on;
    plot(time_axis, get_lvl('GINI_I', oo_base), 'b-', 'LineWidth', 1.5);
    if is_alt
        plot(time_axis, get_lvl('GINI_I', oo_alt), 'b--', 'LineWidth', 1.0); 
        legend('Income Gini (Base)', 'Income Gini (Alt)', 'Location', 'best');
    else
        legend('Income Gini', 'Location', 'best'); 
    end
    %title('Income Gini (Levels)'); 
    xlabel('Periods'); ylabel('Levels'); xlim([1 plot_periods]);
    if is_alt; add_footer(); end
    exportgraphics(fig, fullfile(dir_fig_trans, 'Income_Gini.pdf'), 'ContentType', 'vector');
    if ~show_graphs; close(fig); end

    % Plot: Wealth Gini
    fig = figure('Name', 'Wealth Gini', 'Position', small_graph_size, 'Visible', fig_vis);
    hold on; grid on; box on;
    plot(time_axis, get_lvl('GINI_W', oo_base), 'r-', 'LineWidth', 1.5);
    if is_alt
        plot(time_axis, get_lvl('GINI_W', oo_alt), 'r--', 'LineWidth', 1.0); 
        legend('Wealth Gini (Base)', 'Wealth Gini (Alt)', 'Location', 'best');
    else
        legend('Wealth Gini', 'Location', 'best'); 
    end
    %title('Wealth Gini (Levels)'); 
    xlabel('Periods'); ylabel('Levels'); xlim([1 plot_periods]);
    if is_alt; add_footer(); end
    exportgraphics(fig, fullfile(dir_fig_trans, 'Wealth_Gini.pdf'), 'ContentType', 'vector');
    if ~show_graphs; close(fig); end

    % Plot: Consumption Equivalent Variation
    fig = figure('Name', 'Consumption Equivalent Variation', 'Position', [100, 100, 600, 400], 'Visible', fig_vis);
    hold on; grid on; box on;
    plot(time_axis_full, CEV_H_base * 100, 'b-', time_axis_full, CEV_M_base * 100, 'r-', time_axis_full, CEV_S_base * 100, 'g-', time_axis_full, CEV_Agg_base * 100, 'k-', 'LineWidth', 1.5);
    if is_alt
        plot(time_axis_full, CEV_H_alt  * 100, 'b--', time_axis_full, CEV_M_alt * 100, 'r--', time_axis_full, CEV_S_alt * 100, 'g--', time_axis_full, CEV_Agg_alt * 100, 'k--', 'LineWidth', 1.0); 
        plot(NaN, NaN, 'k:', 'LineWidth', 1.0);
        plot(NaN, NaN, 'k-.', 'LineWidth', 1.0);
        legend('BL-CEV_H (Base)', 'BL-CEV_M (Base)', 'BL-CEV_S (Base)', 'Agg (Base)', ...
               'BL-CEV_H (Alt)', 'BL-CEV_M (Alt)', 'BL-CEV_S (Alt)', 'Agg (Alt)', ...
               'FL-CEV (Base)', 'FL-CEV (Alt)', 'Location', 'best');
    else
        yline(CEV_H_ss_base * 100, 'b:', 'LineWidth', 1.5, 'HandleVisibility', 'off');
        yline(CEV_M_ss_base * 100, 'r:', 'LineWidth', 1.5, 'HandleVisibility', 'off');
        yline(CEV_S_ss_base * 100, 'g:', 'LineWidth', 1.5, 'HandleVisibility', 'off');
        yline(CEV_Agg_ss_base * 100, 'k:', 'LineWidth', 1.5, 'HandleVisibility', 'off');
        plot(NaN, NaN, 'k:', 'LineWidth', 1.0);
        legend('BL-CEV_H', 'BL-CEV_M', 'BL-CEV_S', 'Aggregate', 'FL-CEV', 'Location', 'best'); 
    end
    %title('Consumption Equivalent Variation (%)'); 
    xlabel('Periods'); ylabel('%'); xlim([1 options_.periods]);
    if is_alt; add_footer(); end
    exportgraphics(fig, fullfile(dir_fig_trans, 'Consumption_Equivalent_Variation.pdf'), 'ContentType', 'vector');
    if ~show_graphs; close(fig); end
    
    %% ------------- 4. Steady-State Comparison Table -------------
    var_names = cellstr(M_.endo_names);
    if is_alt
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
            
        writetable(SS_Table, fullfile(out_dir, sprintf('SS_Comparison_%s.xlsx', file_suffix)));
    else
        SS_Table = table(var_names, oo_base.endo_simul(:, 1), oo_base.endo_simul(:, end), ...
            'VariableNames', {'Variable', 'Init_SS', 'Final_SS'});
        writetable(SS_Table, fullfile(out_dir, 'SS_Comparison.xlsx'));
    end
    
    %% ------------- 5. Path in Levels -------------
    
    % Full diagnostic plot (Large)
    var_list_full = {'C_H', 'C_M', 'C_S', 'L_H', 'L_M', 'C', 'INC_H', 'INC_M', 'INC_S', ...
                'NW_H', 'NW_M', 'NW_S', 'mc', 'Y', 'L', 'K', 'I', 'w', 's', 'q', ...
                'r', 'i', 'i_n', 'i_d', 'pi_var', 'mu', 'i_r', 'm_H', 'm_cH', 'H_M', ...
                'H_S', 'n_M', 'b_S', 'd_S', 'd_i', 'd_b', 'd_k', 'SR_H', 'SR_M', 'SR_S', 'GINI_I', 'GINI_W', ...
                'm_cB', 'f', 'i_f', 'V_H', 'V_M', 'V_S', 'W_TOT'};
    generate_level_plots(var_list_full, 7, [50, 50, 2000, 1300], plot_periods, M_, oo_base, oo_alt, is_alt, fig_vis, out_dir, 'Fig6_transition_levels_full.pdf', add_footer);

    % Appendix 1 plot (Small)
    var_list_appendix1 = {'C_H', 'C_M', 'C_S', 'INC_H', 'INC_M', 'INC_S', 'NW_H', 'NW_M', 'NW_S'};
    generate_level_plots(var_list_appendix1, 3, [100, 100, 800, 600], plot_periods, M_, oo_base, oo_alt, is_alt, fig_vis, out_dir, 'Fig6_transition_levels_appendix1.pdf', add_footer);

    % Appendix 2 plot (Small)
    var_list_appendix2 = {'Y', 'L', 'K', 'I', 'w', 'm', 'm_c', 'b', 'n'};
    generate_level_plots(var_list_appendix2, 3, [100, 100, 800, 600], plot_periods, M_, oo_base, oo_alt, is_alt, fig_vis, out_dir, 'Fig6_transition_levels_appendix2.pdf', add_footer);
    
    % GINI W plot (Small)
    var_list_giniw = {'GINI_W'};
    generate_level_plots(var_list_giniw, 1, [100, 100, 800, 600], plot_periods, M_, oo_base, oo_alt, is_alt, fig_vis, out_dir, 'Fig6_transition_levels_giniw.pdf', add_footer);

    % GINI I plot (Small)
    var_list_ginii = {'GINI_I'};
    generate_level_plots(var_list_ginii, 1, [100, 100, 800, 600], plot_periods, M_, oo_base, oo_alt, is_alt, fig_vis, out_dir, 'Fig6_transition_levels_ginii.pdf', add_footer);

    % Gini combined (Small)
    var_list_gini = {'GINI_I','GINI_W'};
    generate_level_plots(var_list_gini, 2, [100, 100, 900, 350], plot_periods, M_, oo_base, oo_alt, is_alt, fig_vis, out_dir, 'Fig6_gini_combined.pdf', add_footer);
    
    %% ------------- 6. Full Diagnostic Path (All Periods) -------------        
    generate_diagnostic_plots(var_list_full, 7, [50, 50, 2000, 1300], options_, M_, oo_base, oo_alt, is_alt, fig_vis, out_dir, 'full_diagnostic.pdf', add_footer, false);

    var_app = {'C_H', 'C_M', 'C_S', 'L_H', 'L_M', 'INC_H', 'INC_M', 'INC_S', ...
                'NW_H', 'NW_M', 'NW_S', 'C', 'Y', 'K', 'I', 'w', 's', 'n', ...
                'b', 'm', 'm_c', 'f', 'mu', 'd', 'd_b', 'i', 'i_n', 'i_d', 'GINI_I', 'GINI_W'};
  
    generate_diagnostic_plots(var_app, 6, [50, 50, 1200, 700], options_, M_, oo_base, oo_alt, is_alt, fig_vis, out_dir, 'diagnostic_appendix.pdf', add_footer, false);

    
    %% ------------- Clean Up -------------
    % Close memory load safely if figures are hidden
    if ~show_graphs
        close all; 
    end
end

% =========================================================================
% LOCAL FUNCTIONS
% =========================================================================
function cev_agg = calc_aggregate_cev(oo_str, options_, idx, params)
    % Calculates cumulative dynamic aggregate CEV
    T = options_.periods;
    t_vec = 0:T-1;
    
    disc_H = params.betta_H .^ t_vec;
    disc_M = params.betta_M .^ t_vec;
    disc_S = params.betta_S .^ t_vec;
    
    cum_disc_H = cumsum(disc_H);
    cum_disc_M = cumsum(disc_M);
    cum_disc_S = cumsum(disc_S);
    
    U_H_0 = oo_str.endo_simul(idx.U_H, 1);
    U_M_0 = oo_str.endo_simul(idx.U_M, 1);
    U_S_0 = oo_str.endo_simul(idx.U_S, 1);
    
    C_H_0 = oo_str.endo_simul(idx.C_H, 1);
    C_M_0 = oo_str.endo_simul(idx.C_M, 1);
    C_S_0 = oo_str.endo_simul(idx.C_S, 1);
    
    U_H_sim = oo_str.endo_simul(idx.U_H, 1:T);
    U_M_sim = oo_str.endo_simul(idx.U_M, 1:T);
    U_S_sim = oo_str.endo_simul(idx.U_S, 1:T);
    
    diff_H = cumsum(disc_H .* (U_H_sim - U_H_0));
    diff_M = cumsum(disc_M .* (U_M_sim - U_M_0));
    diff_S = cumsum(disc_S .* (U_S_sim - U_S_0));
    
    numerator = params.lambda_H * diff_H + params.lambda_M * diff_M + params.lambda_S * diff_S;
                
    u_C_H_0 = (C_H_0 ^ (1 - params.sigma)) / (1 - params.sigma);
    u_C_M_0 = (C_M_0 ^ (1 - params.sigma)) / (1 - params.sigma);
    u_C_S_0 = (C_S_0 ^ (1 - params.sigma)) / (1 - params.sigma);
    
    denominator = params.lambda_H * u_C_H_0 * cum_disc_H + ...
                  params.lambda_M * u_C_M_0 * cum_disc_M + ...
                  params.lambda_S * u_C_S_0 * cum_disc_S;
                  
    cev_agg = (1 + numerator ./ denominator) .^ (1 / (1 - params.sigma)) - 1;
end

function cev_agg_ss = calc_aggregate_cev_ss(oo_str, options_, idx, params)
    % Calculates steady-state aggregate CEV (comparing initial to final SS)
        
    % Calculate the cumulative discount weights for the simulated horizon T
    omega_H = 1 / (1 - params.betta_H);
    omega_M = 1 / (1 - params.betta_M);
    omega_S = 1 / (1 - params.betta_S);
    
    % Extract Initial SS Utilities and Consumptions (period 1)
    U_H_0 = oo_str.endo_simul(idx.U_H, 1);
    U_M_0 = oo_str.endo_simul(idx.U_M, 1);
    U_S_0 = oo_str.endo_simul(idx.U_S, 1);
    
    C_H_0 = oo_str.endo_simul(idx.C_H, 1);
    C_M_0 = oo_str.endo_simul(idx.C_M, 1);
    C_S_0 = oo_str.endo_simul(idx.C_S, 1);
    
    % Extract Final SS Utilities (period T)
    U_H_T = oo_str.endo_simul(idx.U_H, end);
    U_M_T = oo_str.endo_simul(idx.U_M, end);
    U_S_T = oo_str.endo_simul(idx.U_S, end);
    
    % Utility differences between Final and Initial SS
    diff_H = U_H_T - U_H_0;
    diff_M = U_M_T - U_M_0;
    diff_S = U_S_T - U_S_0;
    
    % Numerator: population and discount-weighted sum of utility changes
    numerator = params.lambda_H * omega_H * diff_H + ...
                params.lambda_M * omega_M * diff_M + ...
                params.lambda_S * omega_S * diff_S;
    
    % Base consumption utility
    u_C_H_0 = (C_H_0 ^ (1 - params.sigma)) / (1 - params.sigma);
    u_C_M_0 = (C_M_0 ^ (1 - params.sigma)) / (1 - params.sigma);
    u_C_S_0 = (C_S_0 ^ (1 - params.sigma)) / (1 - params.sigma);
    
    % Denominator: population and discount-weighted sum of base consumption utilities
    denominator = params.lambda_H * omega_H * u_C_H_0 + ...
                  params.lambda_M * omega_M * u_C_M_0 + ...
                  params.lambda_S * omega_S * u_C_S_0;
    
    % Final Aggregate SS CEV
    cev_agg_ss = (1 + numerator / denominator) ^ (1 / (1 - params.sigma)) - 1;
end

function generate_level_plots(var_list, num_cols, fig_pos, plot_periods, M_, oo_base, oo_alt, is_alt, fig_vis, out_dir, file_name, add_footer)

    dir_fig = fullfile(out_dir, 'Levels_SS_Plots');
    if ~exist(dir_fig, 'dir'); mkdir(dir_fig); end
    % Dynamically builds subplots for given variables and exports to PDF
    
    num_vars = length(var_list);
    num_rows = ceil(num_vars / num_cols);
        
    figf = figure('Name', 'Steady-State Transition', 'Position', fig_pos, 'Visible', fig_vis);
    
    for iter = 1:num_vars
        var_name = var_list{iter};
        subplot(num_rows, num_cols, iter);
        hold on;
        
        var_idx_endo = strmatch(var_name, M_.endo_names, 'exact');
        var_idx_exo  = strmatch(var_name, M_.exo_names, 'exact');
        
        if ~isempty(var_idx_endo)
            y_base    = oo_base.endo_simul(var_idx_endo, 2:plot_periods+1);
            ss_i_base = oo_base.endo_simul(var_idx_endo, 1);
            ss_f_base = oo_base.endo_simul(var_idx_endo, end); 
            
            plot(1:plot_periods, y_base, 'LineWidth', 1.5, 'Color', 'b');
            yline(ss_i_base, '--c', 'LineWidth', 1.1); 
            yline(ss_f_base, '-.m', 'LineWidth', 1.1); 
            
            if is_alt
                y_alt    = oo_alt.endo_simul(var_idx_endo, 2:plot_periods+1);
                ss_i_alt = oo_alt.endo_simul(var_idx_endo, 1);
                ss_f_alt = oo_alt.endo_simul(var_idx_endo, end);
                
                plot(1:plot_periods, y_alt, 'LineWidth', 1.4, 'Color', 'r', 'LineStyle', '--');
                yline(ss_i_alt, ':k', 'LineWidth', 1.1); % Initial SS (alt)
                yline(ss_f_alt, ':r', 'LineWidth', 1.1); % Final SS (alt)
            end
            
        elseif ~isempty(var_idx_exo)
            y_base    = oo_base.exo_simul(2:plot_periods+1, var_idx_exo)';
            ss_i_base = oo_base.exo_simul(1, var_idx_exo);
            ss_f_base = oo_base.exo_simul(end, var_idx_exo);
            
            plot(1:plot_periods, y_base, 'LineWidth', 1.5, 'Color', 'b');
            yline(ss_i_base, '--c', 'LineWidth', 1.1); 
            yline(ss_f_base, '-.m', 'LineWidth', 1.1); 
            
            if is_alt
                y_alt    = oo_alt.exo_simul(2:plot_periods+1, var_idx_exo)';
                ss_i_alt = oo_alt.exo_simul(1, var_idx_exo);
                ss_f_alt = oo_alt.exo_simul(end, var_idx_exo);
                
                plot(1:plot_periods, y_alt, 'LineWidth', 1.4, 'Color', 'r', 'LineStyle', '--');
                yline(ss_i_alt, ':g', 'LineWidth', 1.1); % Initial SS (alt)
                yline(ss_f_alt, ':r', 'LineWidth', 1.1); % Final SS (alt)
            end
        else
            warning('Variable %s not found in endogenous or exogenous lists.', var_name);
            continue;
        end
        
        title(var_name, 'Interpreter', 'tex'); 
        xlabel('Periods');
        ylabel('Level');
        grid on;
        xlim([1 plot_periods]);
        hold off;
    end
    
    % Global Legend Setup
    hLgdAxes = axes(figf, 'Position', [0 0 1 1], 'Visible', 'off');
    hold(hLgdAxes, 'on');
    
    h_base = plot(hLgdAxes, NaN, NaN, 'b-', 'LineWidth', 1.5);
    h_ss_i = plot(hLgdAxes, NaN, NaN, 'c--', 'LineWidth', 1.1);
    h_ss_f = plot(hLgdAxes, NaN, NaN, 'm-.', 'LineWidth', 1.1);
    
    lgd_handles = [h_base, h_ss_i, h_ss_f];
    lgd_labels  = {'Baseline Path', 'Initial SS', 'Final SS'};
    
    if is_alt
        h_alt      = plot(hLgdAxes, NaN, NaN, 'r--', 'LineWidth', 1.4);
        h_ss_i_alt = plot(hLgdAxes, NaN, NaN, 'g:', 'LineWidth', 1.1);
        h_ss_f_alt = plot(hLgdAxes, NaN, NaN, 'r:', 'LineWidth', 1.1);
        
        lgd_handles = [lgd_handles, h_alt, h_ss_i_alt, h_ss_f_alt];
        lgd_labels  = [lgd_labels, {'Alt Path', 'Initial SS (alt)', 'Final SS (alt)'}];
    end
    
    lgd = legend(hLgdAxes, lgd_handles, lgd_labels, ...
        'NumColumns', 3, ... 
        'FontSize', 9, ...
        'Box', 'off');
        
    % Manually position the legend to prevent collision
    %lgd.Position(3) = 0.1; 
    lgd.Position(1) = 0.33; 
    lgd.Position(2) = 0.0;
        
    if is_alt
        add_footer(); 
    end
    
    exportgraphics(figf, fullfile(dir_fig, file_name), 'ContentType', 'vector');
end

function generate_diagnostic_plots(var_list, num_cols, fig_pos, options_, M_, oo_base, oo_alt, is_alt, fig_vis, out_dir, file_name, add_footer, show_scenario_legend)
    num_vars = length(var_list);
    num_rows = ceil(num_vars / num_cols);

    %if is_large_plot
    %    fig_pos = [50, 50, 1200, 700];
    %else
    %    fig_pos = [100, 100, 800, 600];
    %end
    
    fig_diag = figure('Name', 'Full Diagnostic Path', 'Position', fig_pos, 'Visible', fig_vis);
    t = tiledlayout(fig_diag, num_rows, num_cols, 'TileSpacing', 'compact', 'Padding', 'normal');
    
    for iter = 1:num_vars
        var_name = var_list{iter};
        nexttile(t);
        hold on;
        
        var_idx = strmatch(var_name, M_.endo_names, 'exact');
        
        if ~isempty(var_idx)
            h_base = plot(1:options_.periods+2, oo_base.endo_simul(var_idx, 1:options_.periods+2), 'LineWidth', 1.5, 'Color', 'b');
            if is_alt
                h_alt = plot(1:options_.periods+2, oo_alt.endo_simul(var_idx, 1:options_.periods+2), 'LineWidth', 1.0, 'Color', 'r', 'LineStyle', '--');
            end
        else
            var_idx = strmatch(var_name, M_.exo_names, 'exact');
            if ~isempty(var_idx)
                h_base = plot(1:options_.periods+2, oo_base.exo_simul(1:options_.periods+2, var_idx)', 'LineWidth', 1.5, 'Color', 'b');
                if is_alt
                    h_alt = plot(1:options_.periods+2, oo_alt.exo_simul(1:options_.periods+2, var_idx)', 'LineWidth', 1.0, 'Color', 'r', 'LineStyle', '--');
                end
            else
                warning('Variable %s not found.', var_name);
                continue;
            end
        end
        
        tex_name = strrep(var_name, 'pi_var', '\pi');
        tex_name = strrep(tex_name, 'pi_', '\pi_');
        tex_name = strrep(tex_name, 'mu', '\mu');
        
        title(tex_name, 'Interpreter', 'tex'); 
        grid on;
        xlim([1 options_.periods+2]);
        
        % 1. Render legend only on the first subplot
        if iter == 1
            if is_alt
                legend([h_base, h_alt], {'Baseline', 'Alternative'}, 'Location', 'best', 'Box', 'off');
            else
                legend(h_base, {'Baseline'}, 'Location', 'best', 'Box', 'off');
            end
        end
        
        hold off;
    end
    
    xlabel(t, 'Periods');
    ylabel(t, 'Value');
    
    % 2. Toggle scenario legend based on the new input parameter
    if is_alt && show_scenario_legend 
        add_footer(); 
    end
    
    exportgraphics(fig_diag, fullfile(out_dir, file_name), 'ContentType', 'vector');
end