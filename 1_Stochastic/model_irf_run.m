addpath C:\dynare\6.5\matlab
clear all; close all; clc;

% --- Sensitivity Analysis Configuration ---
param_macro_name   = 'varpi_val'; 
param_display_name = 'varpi';     
val_base           = 0.999999;      % Baseline value (no RFA)
val_alt            = 0.5;           % Alternative value (RFA introduced)

%% ------------- 1. Run Scenarios -------------
% Scenario 1: Baseline (no-RFA)
dynare_cmd_base = sprintf('dynare model_irf.mod noclearall -D%s=%g', param_macro_name, val_base);
eval(dynare_cmd_base);
oo_base = oo_;
clear model_irf

% Scenario 2: Alternative (RFA)
dynare_cmd_alt = sprintf('dynare model_irf.mod noclearall -D%s=%g', param_macro_name, val_alt);
eval(dynare_cmd_alt);
oo_alt = oo_;

%% ------------- 2. Master Variable Configuration -------------
% 0 = % deviation from SS, 1 = Annualized rate, 2 = Absolute pp deviation
var_config = { 
    'C_H', 0; 'C_M', 0; 'C_S', 0; 'H_M', 0; 'H_S', 0;
    'C', 0;  'Y', 0; 'K', 0; 'I', 0; 'L', 0; 
    'L_H', 0; 'L_M', 0; 
    'INC_H', 0; 'INC_M', 0; 'INC_S', 0; 
    'NW_H', 0; 'NW_M', 0; 'NW_S', 0; 
    'pi_var', 1; 'pi_w_H', 1; 'pi_w_M', 1; 
    'i', 1; 'i_d', 1; 'i_n', 1; 'i_b', 1; 'i_f', 1; 'i_r', 1; 
    'n', 0; 's', 0; 'b', 0; 
    'f', 0; 'm', 0; 
    'd', 0; 'w', 0; 'r', 0; 
    'INC_TOT', 0; 'NW_TOT', 0; 'GINI_W', 2; 'GINI_I', 2; 
};

plot_groups = {
    {'C_H', 'C_M', 'C_S'};
    {'L_H', 'L_M'};
    {'INC_H', 'INC_M', 'INC_S'};
    {'NW_H', 'NW_M', 'NW_S'};
    {'H_M', 'H_S'};
    {'C', 'Y'};
    {'K', 'I'};
    {'pi_var', 'pi_w_H', 'pi_w_M'};
    {'i', 'i_r'};
    {'i_d', 'i_n', 'i_b'};
    {'n', 'd', 's'};
    {'f', 'm'};
    {'GINI_W', 'GINI_I'}
};

%% ------------- 3. Plot Aesthetics Configuration -------------
% Define variables, colors, legends, axis labels, and exact output filenames
plot_defs = struct( ...
    'Name', { ...
        'Individual Consumption', 'Individual Incomes', ...
        'Individual Wealth', 'Individual Labour', 'Housing', ...
        'Consumption and Output', 'Capital and Investment', 'CB Lending and Deposits', ...
        'Inflation', 'Policy Rates', 'Market Rates', 'Dividends, Debt and House Prices', ...
        'Gini Coefficients' ...
    }, ...
    'Filename', { ...
        'IRF_Individual_Consumption', 'IRF_Individual_Incomes', ...
        'IRF_Individual_Wealth', 'IRF_Individual_Labour', 'IRF_Housing', ...
        'IRF_Consumption_and_Output', 'IRF_Capital_and_Investment', 'IRF_CB_Lending_Deposits', ...
        'IRF_Inflation', 'IRF_Policy_Rates', 'IRF_Market_Rates', 'IRF_Bonds_etc', ...
        'IRF_Gini_Coefficients' ...
    }, ...
    'Vars', { ...
        {'C_H', 'C_M', 'C_S'}, {'INC_H', 'INC_M', 'INC_S'}, ...
        {'NW_H', 'NW_M', 'NW_S'}, {'L_H', 'L_M'}, {'H_M', 'H_S'}, ...
        {'C', 'Y'}, {'K', 'I'}, {'f', 'm'}, ...
        {'pi_var', 'pi_w_H', 'pi_w_M'}, {'i', 'i_r'}, {'i_d', 'i_n', 'i_b'}, {'n', 'd', 's'}, ...
        {'GINI_W', 'GINI_I'} ...
    }, ...
    'Colors', { ...
        {'b', 'r', 'g'}, {'b', 'r', 'g'}, ...
        {'b', 'r', 'g'}, {'b', 'r'}, {'b', 'g'}, ...
        {'k', 'b'}, {'b', 'r'}, {'b', 'r'}, ...
        {'k', 'b', 'r'}, {'k', 'g'}, {'b', 'r', 'g'}, {'r', 'g', 'k'}, ...
        {'b', 'r'} ...
    }, ...
    'LegendBase', { ...
        {'C_H (No RFA)', 'C_M (No RFA)', 'C_S (No RFA)'}, {'INC_H (No RFA)', 'INC_M (No RFA)', 'INC_S (No RFA)'}, ...
        {'NW_H (No RFA)', 'NW_M (No RFA)', 'NW_S (No RFA)'}, {'L_H (No RFA)', 'L_M (No RFA)'}, {'H_M (No RFA)', 'H_S (No RFA)'}, ...
        {'C (No RFA)', 'Y (No RFA)'}, {'K (No RFA)', 'I (No RFA)'}, {'f (No RFA)', 'm (No RFA)'}, ...
        {'\pi (No RFA)', '\pi^w_H (No RFA)', '\pi^w_M (No RFA)'}, {'i (No RFA)', 'i^r (No RFA)'}, {'i^d (No RFA)', 'i^n (No RFA)', 'i^b (No RFA)'}, {'n (No RFA)', 'd (No RFA)', 's (No RFA)'}, ...
        {'GINI_W (No RFA)', 'GINI_I (No RFA)'} ...
    }, ...
    'LegendAlt', { ...
        {'C_H (RFA)', 'C_M (RFA)', 'C_S (RFA)'}, {'INC_H (RFA)', 'INC_M (RFA)', 'INC_S (RFA)'}, ...
        {'NW_H (RFA)', 'NW_M (RFA)', 'NW_S (RFA)'}, {'L_H (RFA)', 'L_M (RFA)'}, {'H_M (RFA)', 'H_S (RFA)'}, ...
        {'C (RFA)', 'Y (RFA)'}, {'K (RFA)', 'I (RFA)'}, {'f (RFA)', 'm (RFA)'}, ...
        {'\pi (RFA)', '\pi^w_H (RFA)', '\pi^w_M (RFA)'}, {'i (RFA)', 'i^r (RFA)'}, {'i^d (RFA)', 'i^n (RFA)', 'i^b (RFA)'}, {'n (RFA)', 'd (RFA)', 's (RFA)'}, ...
        {'GINI_W (RFA)', 'GINI_I (RFA)'} ...
    }, ...
    'YLabel', { ...
        '% Dev', '% Dev', ...
        '% Dev', '% Dev', '% Dev', ...
        '% Dev', '% Dev', 'Levels', ...
        'Ann. pp dev', 'Ann. pp dev', 'Ann. pp dev', '% Dev', ...
        'pp dev' ...
    } ...
);

horizon = 40;
shocks = {'varepsilon_xi', 'varepsilon_z'};
num_groups = length(plot_defs);

%% ------------- 4. Replicate IRFs & Export Figures -------------
for s = 1:length(shocks)
    shock_name = shocks{s};
    
    % Create a dedicated folder for the current shock
    shock_folder = sprintf('IRFs_%s', shock_name);
    if ~exist(shock_folder, 'dir')
        mkdir(shock_folder);
    end
    
    for g = 1:num_groups
        p_def = plot_defs(g);
        num_vars = length(p_def.Vars);
        
        % Generate figure with exact requested aesthetics
        fig = figure('Name', p_def.Name, 'Position', [100, 100, 500, 300], 'Visible', 'off');
        hold on; grid on; box on;
        
        leg_str = {};
        
        % Data containers to ensure correct legend order (Base first, then Alt)
        irf_b_store = cell(1, num_vars);
        irf_a_store = cell(1, num_vars);
        plot_valid = false(1, num_vars);
        
        % Process data
        for k = 1:num_vars
            v = p_def.Vars{k};
            irf_field = [v '_' shock_name];
            
            idx_ss = find(strcmp(cellstr(M_.endo_names), v));
            if isempty(idx_ss)
                warning('Variable %s not found in model. Skipping in plot.', v);
                continue;
            end
            plot_valid(k) = true;
            
            % Determine scaling flag
            is_rate_flag = 0;
            idx_config = find(strcmp(var_config(:,1), v));
            if ~isempty(idx_config)
                is_rate_flag = var_config{idx_config, 2};
            end
            
            ss_base = oo_base.steady_state(idx_ss);
            ss_alt  = oo_alt.steady_state(idx_ss);
            
            if isfield(oo_base.irfs, irf_field), irf_b = oo_base.irfs.(irf_field)(1:horizon); else, irf_b = zeros(1, horizon); end
            if isfield(oo_alt.irfs, irf_field), irf_a = oo_alt.irfs.(irf_field)(1:horizon); else, irf_a = zeros(1, horizon); end
            
            if is_rate_flag == 1
                irf_b_store{k} = irf_b * 400; 
                irf_a_store{k} = irf_a * 400;
            elseif is_rate_flag == 2
                irf_b_store{k} = irf_b * 100; 
                irf_a_store{k} = irf_a * 100;
            else
                if abs(ss_base) > 1e-6, irf_b_store{k} = (irf_b / ss_base) * 100; else, irf_b_store{k} = irf_b * 100; end
                if abs(ss_alt) > 1e-6,  irf_a_store{k} = (irf_a / ss_alt) * 100;  else, irf_a_store{k} = irf_a * 100; end
            end
        end
        
        % Plot Base series first
        for k = 1:num_vars
            if plot_valid(k)
                plot(1:horizon, irf_b_store{k}, '-', 'Color', p_def.Colors{k}, 'LineWidth', 1.5);
                leg_str{end+1} = p_def.LegendBase{k};
            end
        end
        
        % Plot Alt series second
        for k = 1:num_vars
            if plot_valid(k)
                plot(1:horizon, irf_a_store{k}, '--', 'Color', p_def.Colors{k}, 'LineWidth', 1.0);
                leg_str{end+1} = p_def.LegendAlt{k};
            end
        end
        
        % Apply aesthetics
        xlabel('Periods'); 
        ylabel(p_def.YLabel);
        %title(sprintf('%s (%s)', p_def.Name, p_def.YLabel)); 
        xlim([1, horizon]);
        
        % Tex interpreter required to render LaTeX symbols (\pi, \mu)
        legend(leg_str, 'Interpreter', 'tex', 'Location', 'best', 'FontSize', 9);
        
        % Export logic using explicit filename mapping from old code
        file_path = fullfile(shock_folder, sprintf('%s_%s.pdf', p_def.Filename, shock_name));
        exportgraphics(fig, file_path, 'ContentType', 'vector');
        close(fig);
    end
end

%% ------------- 5. Replicate Table & Export to LaTeX -------------
irf_vars = var_config(:, 1)';
is_rate = cell2mat(var_config(:, 2))';

fid = fopen('Table_StandardDeviations.tex', 'w');
fprintf(fid, '\\begin{table}[htbp]\n\\centering\n');
fprintf(fid, '\\caption{Model Simulated Volatility}\n');
fprintf(fid, '\\begin{tabular}{lcc}\n\\hline\\hline\n');
fprintf(fid, 'Variable & no-RFA & RFA \\\\\n\\hline\n');

fprintf('\n------------------------------------------------------\n');
fprintf('Model Simulated Volatility\n');
fprintf('------------------------------------------------------\n');
fprintf('%-30s %-10s %-10s\n', 'Variable', 'no-RFA', 'RFA');
fprintf('------------------------------------------------------\n');

% Define headers for the three sections [flag, LaTeX header, Console header]
sections = {
    0, 'Standard Deviation (\\%%)', 'Standard Deviation (%)';
    1, 'Standard Deviation (Annualized pp)', 'Standard Deviation (Annualized pp)';
    2, 'Standard Deviation (Absolute pp)', 'Standard Deviation (Absolute pp)'
};

for s = 1:size(sections, 1)
    rate_flag = sections{s, 1};
    tex_header = sections{s, 2};
    console_header = sections{s, 3};
    
    % Find all variables belonging to the current metric type
    idx_group = find(is_rate == rate_flag);
    if isempty(idx_group)
        continue;
    end
    
    % Print section headers
    fprintf(fid, '\\multicolumn{3}{c}{\\textbf{%s}} \\\\\n\\hline\n', tex_header);
    fprintf('%s\n', console_header);
    fprintf('------------------------------------------------------\n');
    
    % Process and print variables for this section
    for k = 1:length(idx_group)
        j = idx_group(k);
        v = irf_vars{j};
        
        idx_var_base = find(strcmp(oo_base.var_list, v));
        idx_var_alt  = find(strcmp(oo_alt.var_list, v));
        idx_ss       = find(strcmp(M_.endo_names, v));
        
        if isempty(idx_ss) || isempty(idx_var_base) || isempty(idx_var_alt)
            std_b_scaled = NaN;
            std_a_scaled = NaN;
        else
            ss_base = oo_base.steady_state(idx_ss);
            std_base = sqrt(oo_base.var(idx_var_base, idx_var_base));
            
            ss_alt = oo_alt.steady_state(idx_ss);
            std_alt = sqrt(oo_alt.var(idx_var_alt, idx_var_alt));
            
            if rate_flag == 1
                std_b_scaled = std_base * 400;
                std_a_scaled = std_alt * 400;
            elseif rate_flag == 2
                std_b_scaled = std_base * 100;
                std_a_scaled = std_alt * 100;
            else
                % Maintains absolute value correction to prevent negative CVs
                std_b_scaled = (std_base / abs(ss_base)) * 100;
                std_a_scaled = (std_alt / abs(ss_alt)) * 100;
            end
        end
        
        % Print to console
        fprintf('%-30s %-10.2f %-10.2f\n', v, std_b_scaled, std_a_scaled);
        
        % Print to LaTeX
        v_tex = strrep(v, '_', '\_');
        fprintf(fid, '%s & %.2f & %.2f \\\\\n', v_tex, std_b_scaled, std_a_scaled);
    end
    
    % Add separation below the section in LaTeX and Console
    fprintf(fid, '\\hline\n');
    fprintf('------------------------------------------------------\n');
end

fprintf(fid, '\\hline\n\\end{tabular}\n\\end{table}\n');
fclose(fid);