# THRANK-Thesis

This repository contains all the code and models I created for my Master's Thesis.
*Title: "Central Bank Reserves for All: Welfare & Inequality in a THRANK Model"
*Author: Marcos Constantinou, University of Lausanne
*Supervised by: Aurélien Eyquem, University of Lausanne


## TLDR
There is only one mod file to run the baseline perfect foresight model and the sensitivity analyses, including the tiered remuneration extension. There is another mod file for the stochastic simulations model. As for the optimal varpi analysis, the mod file is the same as the baseline but the matlab code is different.

In order to run the models, use the "model_run.m", "model_irf_run.m", and "welfare_maxxing.m" Matlab scripts. 
The model run scripts have two selectable options.
* run_sensitivity:
  + true: Runs a loop over the baseline model file which changes one parameter at a time
  + false: Only runs the baseline model
* run_joint_scenario:
  + true: Runs a loop over the baseline model file which changes multiple parameters at a time
  + false: Only runs the baseline model
* show_graphs:
  + true: Matlab will display each graph as is printed. This is mainly useful for running quick tests
  + false: Does not display the graphs as they run, but still saves them as pdfs.
This script also contains the alternate parameter calibrations which one can edit to run sensitivity analysis for whichever parameter values.

## Structure

```
THRANK-Thesis/
├── 0_Baseline/
  ├── model.mod                           # Main "baseline" model file. Creates the main policy experiment and the comparative graphs. Also contains tiered remuneration extension (turned on by recalibrating)
  ├── model_run.m                         # Runs model.mod. Contains user selectable options, as well as the alternative values of parameters for the reclibration analyses and extension
  ├── post_process_results.m              # Creates the output graphs and excel files
  ├── model/                              # Folder containing Dynare default output
  ├── models_results/                     # Folder containing all results stemming from the baseline model as well as the sensititivy analyses
    ├── baseline/                         # Folder containing the graphs and steady-state values resulting from the baseline model
    ├── scenario_betaH_99/                # Folder containing the graphs and steady-state values resulting from the recalibration analysis of betta_H from 0.994 to 0.99
    ├── scenario_high_substitution/       # Folder containing the graphs and steady-state values resulting from the recalibration analysis of epsilon_c from 6 to 18
    ├── scenario_low_substitution/        # Folder containing the graphs and steady-state values resulting from the recalibration analysis of epsilon_c from 6 to 3
    ├── sensitivity_varpi_end/            # Folder containing the graphs and steady-state values resulting from the recalibration analysis of the final varpi from 0.50 to 0.01
    ├── scenario_omega/                   # Folder containing the graphs and steady-state values resulting from the recalibration analysis of omega from 0.025 to 0.25
    ├── scenario_log_utility/             # Folder containing the graphs and steady-state values resulting from the recalibration analysis with log utility
    ├── scenario_ql_05/                   # Folder containing the graphs and steady-state values resulting from the tiered remuneration extension where m_bar = 0.50
    ├── scenario_ql_07/                   # Folder containing the graphs and steady-state values resulting from the tiered remuneration extension where m_bar = 0.70
├── 1_Stochastic/
  ├── model_irf.mod                       # Uses the same model in model.mod but changes the perfect foresight computation to stochastic shock simulation
  ├── model_irf_run.m                     # Runs model_irf.mod.
  ├── Table_StandardDeviations.tex        # Table of standard deviations taken from results
  ├── IRFs_varepsilon_xi/                 # Folder containing all the IRFs from the monetary policy shock
  ├── IRFs_varepsilon_z/                  # Folder containing all the IRFs from the technology shock
├── 2_Optimal/
  ├── model.mod                           # Same Dynare mod file as baseline model
  ├── welfare_maxxing.m                   # Runs model.mod in a loop to plot welfare outcomes for different varpi values, in order to find the welfare maximising one
  ├── models_results/                     # Contains resulting figure
```
