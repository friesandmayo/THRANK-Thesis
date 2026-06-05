clear all; close all; clc;

% =========================================================================
% USER OPTIONS
% =========================================================================
run_sensitivity = true; % Set to true to run sensitivity, false for baseline only
show_graphs     = false; % Set to true to display windows, false to run silently
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


%% ------------- 2. Sensitivity Analysis Runs -------------
if run_sensitivity
    % Define the parameters to shock and their alternate values.
    % Note: The parameter names must match the macro strings in model.mod 

    % Format: {'parameter_name', alternate_value}
    sensitivity_cases = {
        'betta_H',   0.95;
        'betta_M',   0.972;
        'betta_S',   0.985;
        'epsilon_c', 3.00;
        'Gamma',     0.25;
        'kappa_d',   0.00;
        'kappa_m',   0.00;
        'kappa_w',   0.00;
        'kappa_y',   0.00;
        'omega',     0.30;
        'phi_f',     0.05;
        'phi_pi',    2.50;
        'PSI',       0.50;
        'tau_H',     0.00;
        'tau_M',     0.00;
        'theta',     0.00
    };    

    for i = 1:size(sensitivity_cases, 1)
        p_name = sensitivity_cases{i, 1}; % name 
        p_alt  = sensitivity_cases{i, 2}; % alt value 
        
        % Find the parameter's baseline value from M_base
        param_idx = strmatch(p_name, M_base.param_names, 'exact');

        if isempty(param_idx)
            error('Parameter "%s" not found in the model!', p_name);
        end
        p_base = M_base.params(param_idx);
        
        fprintf('\n>>> RUNNING SENSITIVITY: %s = %g (Baseline was %g) <<<\n', p_name, p_alt, p_base);
        
        % Pass parameter using Dynare's macro processor (-D flag)
        dynare_cmd = sprintf('dynare model.mod noclearall -D%s_val=%g', p_name, p_alt);
        eval(dynare_cmd);
        
        % Save alternative results
        oo_alt = oo_;
        
        % Generate sensitivity outputs comparing base against alt
        out_dir = fullfile(base_output_folder, ['sensitivity_', p_name]);
        post_process_results('sensitivity', out_dir, M_base, options_base, oo_base, oo_alt, p_name, p_base, p_alt, show_graphs);
    end
else
    disp('========================================');
    disp('>>> SENSITIVITY ANALYSIS SKIPPED <<<');
end
