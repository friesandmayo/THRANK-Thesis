clear all; close all; clc;

% =========================================================================
% USER OPTIONS
% =========================================================================
show_graphs      = false; % Set to true to display windows, false to run silently
run_optimization = true; % Set to true to search for optimal varpi
% =========================================================================

% Setup Paths
addpath C:\dynare\6.5\matlab
base_output_folder = 'models_results';
if ~exist(base_output_folder, 'dir')
    mkdir(base_output_folder);
end

%% ------------- 1. Baseline Run -------------
dynare model.mod noclearall

% Save baseline environment
oo_base      = oo_;
M_base       = M_;
options_base = options_;

% Generate baseline outputs
baseline_dir = fullfile(base_output_folder, 'baseline');
post_process_results('baseline', baseline_dir, M_base, options_base, oo_base, [], '', [], [], show_graphs);

%% ------------- 2. Optimize varpi for Maximum Aggregate CEV -------------
if run_optimization
    disp('========================================');
    disp('>>> RUNNING VARPI OPTIMIZATION <<<');
    
    % Define grid of varpi values to test 
    varpi_grid = linspace(0.01, 0.999999, 70); 
    
    % Preallocate arrays for both CEV measures
    cev_results = NaN(length(varpi_grid), 1);
    cev_results_ss = NaN(length(varpi_grid), 1);
    
    % Suppress Dynare output to keep the console clean during the loop
    options_.noprint = 1; 
    for v = 1:length(varpi_grid)
        clear global oo_
        current_varpi = varpi_grid(v);
        fprintf('Evaluating varpi target = %g... ', current_varpi);
        
        % Call Dynare and pass the target varpi using the -D flag
        dynare_cmd = sprintf('dynare model.mod noclearall -Dvarpi_end_val=%g', current_varpi);
        
        try
            % Run Dynare silently
            evalc(dynare_cmd); 
            
            % Re-extract parameters for the CEV function
            betta_H  = M_.params(strmatch('betta_H', M_.param_names, 'exact'));
            betta_M  = M_.params(strmatch('betta_M', M_.param_names, 'exact'));
            betta_S  = M_.params(strmatch('betta_S', M_.param_names, 'exact'));
            lambda_H = M_.params(strmatch('lambda_H', M_.param_names, 'exact'));
            lambda_M = M_.params(strmatch('lambda_M', M_.param_names, 'exact'));
            lambda_S = M_.params(strmatch('lambda_S', M_.param_names, 'exact'));
            sigma    = M_.params(strmatch('sigma', M_.param_names, 'exact'));
            
            params_opt = struct('betta_H', betta_H, 'betta_M', betta_M, 'betta_S', betta_S, ...
                                'lambda_H', lambda_H, 'lambda_M', lambda_M, 'lambda_S', lambda_S, ...
                                'sigma', sigma);
                            
            idx_opt.U_H = strmatch('U_H', M_.endo_names, 'exact'); idx_opt.C_H = strmatch('C_H', M_.endo_names, 'exact');
            idx_opt.U_M = strmatch('U_M', M_.endo_names, 'exact'); idx_opt.C_M = strmatch('C_M', M_.endo_names, 'exact');
            idx_opt.U_S = strmatch('U_S', M_.endo_names, 'exact'); idx_opt.C_S = strmatch('C_S', M_.endo_names, 'exact');
            
            % Calculate CEV using your local functions
            cev_seq    = calc_aggregate_cev(oo_, options_, idx_opt, params_opt);
            cev_seq_ss = calc_aggregate_cev_ss(oo_, options_, idx_opt, params_opt);
            
            % Store aggregate CEV results
            cev_results(v)    = cev_seq(end);
            cev_results_ss(v) = cev_seq_ss; 
            
            fprintf('Success. Dyn CEV = %g%% | SS CEV = %g%%\n', cev_seq(end) * 100, cev_seq_ss * 100);
            
        catch ME
            fprintf('Solver failed to converge. Skipping.\n');
            cev_results(v)    = -Inf; % Heavily penalize failed combinations
            cev_results_ss(v) = -Inf;
        end
    end
    
    % Extract Optimal Values
    [max_cev, max_idx] = max(cev_results);
    optimal_varpi = varpi_grid(max_idx);
    
    [max_cev_ss, max_idx_ss] = max(cev_results_ss);
    optimal_varpi_ss = varpi_grid(max_idx_ss);
    
    fprintf('\n========================================\n');
    fprintf('OPTIMIZATION COMPLETE\n');
    fprintf('Optimal varpi (Dynamic): %g\n', optimal_varpi);
    fprintf('Maximum Aggregate CEV (Dynamic): %g%%\n', max_cev * 100);
    fprintf('----------------------------------------\n');
    fprintf('Optimal varpi (Steady-State): %g\n', optimal_varpi_ss);
    fprintf('Maximum Aggregate CEV (Steady-State): %g%%\n', max_cev_ss * 100);
    fprintf('========================================\n');
    
    % Plot Optimization Results
    if show_graphs
        fig_vis = 'on';
    else
        fig_vis = 'off';
    end
    opt_fig = figure('Name', 'Optimal Varpi Search', 'Position', [200, 200, 700, 450], 'Visible', fig_vis);
    
    % Plot Dynamic CEV
    plot(varpi_grid, cev_results * 100, '-ko', 'LineWidth', 2, 'MarkerFaceColor', 'k', 'MarkerSize', 2.3);
    hold on; grid on;
    % Plot Steady-State CEV
    plot(varpi_grid, cev_results_ss * 100, '-bo', 'LineWidth', 2, 'MarkerFaceColor', 'b', 'MarkerSize', 2.3);
    
    % Reference lines for optimals
    %xline(optimal_varpi, '--k', 'Opt \varpi (Dyn)', 'LabelVerticalAlignment', 'bottom', 'LineWidth', 1.5);
    
    %if optimal_varpi ~= optimal_varpi_ss
    %    xline(optimal_varpi_ss, '--b', 'Opt \varpi (SS)', 'LabelVerticalAlignment', 'top', 'LineWidth', 1.5);
    %end
    
    xlabel('Target RFA Weight (\varpi)');
    ylabel('Aggregate CEV (%)');
    %title('Welfare Optimization: Aggregate CEV vs. Target \varpi');
    legend('Backward-looking CEV (terminal)', 'Forward-looking CEV', 'Location', 'best');
    
    exportgraphics(opt_fig, fullfile(base_output_folder, 'baseline/optimal_varpi.pdf'), 'ContentType', 'vector');
end















function post_process_results(run_type, out_dir, M_, options_, oo_base, oo_alt, param_name, val_base, val_alt, show_graphs)

    %% ------------- 0. Setup -------------
    if ~exist(out_dir, 'dir')
        mkdir(out_dir);
    end
    
    plot_periods = 100; 
    time_axis = 1:plot_periods;
    time_axis_full = 1:options_.periods;
    
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


    %% ------------- Calculate Welfare Variation (CEV) -------------
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

    if is_sens
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
    

    %% ------------- Data Extraction Helpers -------------
    get_dev = @(var, oo_str) (oo_str.endo_simul(strmatch(var, M_.endo_names, 'exact'), 1:plot_periods) - ...
                              oo_str.endo_simul(strmatch(var, M_.endo_names, 'exact'), 1)) ...
                              ./ oo_str.endo_simul(strmatch(var, M_.endo_names, 'exact'), 1) * 100;

    get_pp  = @(var, oo_str) (oo_str.endo_simul(strmatch(var, M_.endo_names, 'exact'), 1:plot_periods) - ...
                              oo_str.endo_simul(strmatch(var, M_.endo_names, 'exact'), 1)) * 400; 

    get_lvl = @(var, oo_str) oo_str.endo_simul(strmatch(var, M_.endo_names, 'exact'), 1:plot_periods);
    
    get_exo_lvl = @(var, oo_str) oo_str.exo_simul(1:plot_periods, strmatch(var, M_.exo_names, 'exact'))';

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
    
    % Extract Final SS Utilities 
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