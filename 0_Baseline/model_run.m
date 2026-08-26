    
clear all; close all; clc;

% =========================================================================
% USER OPTIONS
% =========================================================================
run_sensitivity    = false;   % Set to true to run sensitivity
run_joint_scenario = true;   % Joint parameter analysis
show_graphs        = false;   % Set to true to display windows, false to run silently
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
        %'kappa_w',    100.00;
        %'kappa_d',    0.00;
        %'kappa_b',    10.00;
        %'kappa_n',    0.00;
        %'kappa_w',    0.00;
        %'kappa_y',    0.00;
        %'phi_pi',     2.50;
        %'theta',      0.00;
        %'varpi_end',  0.01;
        %'testy',       1
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



%% ------------- 3. Joint Scenario Analysis -------------
if run_joint_scenario
    
    % Initialize a struct array to hold all scenarios
    scenarios = struct('name', {}, 'cases', {});

    % Scenario: Log utility
    scenarios(end+1).name = 'log_utility';
    scenarios(end).cases = { 
        'sigma',   1.00001; 
        'eta',     1.00001; 
        'psi',     1.00001;
        'chi_H',   7.17427; 
        'chi_M',   8.10034; 
        'PSI',     0.0121909
    };

    % Scenario: High Substitution
    scenarios(end+1).name = 'high_substitution';
    scenarios(end).cases = {
        'epsilon_c', 18; 
        'chi_H',     17.5716; 
        'chi_M',     12.7559; 
        'PSI',       0.0209164
    };

    % Scenario: Low Substitution
    scenarios(end+1).name = 'low_substitution';
    scenarios(end).cases = {
        'epsilon_c', 3;
        'chi_H',     17.6335;
        'chi_M',     12.7612;
        'PSI',       0.0183802}
    
    % Scenario: betta_H at 0.99
    scenarios(end+1).name = 'betaH_99';
    scenarios(end).cases = {
        'betta_H', 0.99; 
        'chi_H',   17.6591; 
        'chi_M',   12.7566; 
        'PSI',     0.021576
    };

    % Scenario: Higher Reserve Requirement
    scenarios(end+1).name = 'omega';
    scenarios(end).cases = {
        'omega', 0.25; 
        'chi_H',   17.6423; 
        'chi_M',   12.7638; 
        'PSI',     0.0188548
    };

    % Scenario: Quantity Limits 0.70
    scenarios(end+1).name = 'ql_07';
    scenarios(end).cases = {
        'tau',     0.05; 
        'm_bar',   0.70
    };

    % Scenario: Quantity Limits 0.50
    scenarios(end+1).name = 'ql_05';
    scenarios(end).cases = {
        'tau',     0.05; 
        'm_bar',   0.50
    };

    % Loop over all populated scenarios
    for s = 1:length(scenarios)
        scenario_name = scenarios(s).name;
        joint_cases   = scenarios(s).cases;
        
        dynare_cmd = 'dynare model.mod noclearall';
        note_str = sprintf('Scenario [%s]: ', scenario_name);
        
        % Define parameters to exclude from the visual footer
        excluded_params = {'chi_H', 'chi_M', 'PSI'};
        
        for j = 1:size(joint_cases, 1)
            p_name = joint_cases{j, 1};
            p_alt  = joint_cases{j, 2};
            
            param_idx = strmatch(p_name, M_base.param_names, 'exact');
            if isempty(param_idx)
                error('Parameter "%s" not found in the model for scenario "%s"!', p_name, scenario_name);
            end
            p_base = M_base.params(param_idx);
            
            % Append each macro flag to the Dynare command
            dynare_cmd = sprintf('%s -D%s_val=%g', dynare_cmd, p_name, p_alt);
            
            % Build the footer string incrementally
            if ~ismember(p_name, excluded_params)
                note_str = sprintf('%s %s(%g->%g) |', note_str, p_name, p_base, p_alt);
            end
        end
        
        % Safely remove the trailing pipe and space for a cleaner footer
        if length(note_str) > 2 && strcmp(note_str(end-1:end), ' |')
            note_str = note_str(1:end-2);
        end
        
        % Added tracking for multiple runs
        fprintf('\n=======================================================\n');
        fprintf('>>> RUNNING JOINT SCENARIO %d/%d: %s <<<\n', s, length(scenarios), scenario_name);
        fprintf('=======================================================\n');
        
        eval(dynare_cmd);
        
        oo_alt = oo_;
        
        % Generate outputs
        out_dir = fullfile(base_output_folder, ['scenario_', scenario_name]);
        
        post_process_results('scenario', out_dir, M_base, options_base, oo_base, oo_alt, scenario_name, note_str, [], show_graphs);
    end
else
    disp('========================================');
    disp('>>> JOINT SCENARIO ANALYSIS SKIPPED <<<');
end