# THRANK-Thesis

## TLDR
There is only one mod file to run the baseline model as well as the sensitivity analyses. 
This file contains the baseline parameter calibration values.

In order to run the models, use the "matlab_run.m" Matlab script. 
This script has two selectable options.
* run_sensitivity:
  + true: Runs a loop over the baseline model file which changes one parameter at a time
  + false: Only runs the baseline model
* show_graphs:
  + true: Matlab will display each graph as is printed. This is mainly useful for running quick tests
  + false: Does not display the graphs as they run, but still saves them as pdfs.
This script also contains the alternate parameter calibrations which one can edit to run sensitivity analysis for whichever value of a parameter one needs.

## Structure

```
THRANK-Thesis/
├── model.mod                        # Main "baseline" model file. Creates the main policy experiment and the comparative graphs
├── model_run.m                      # Runs model.mod. Contains user selectable options, as well as the alternative values of parameters for the sensitivity analysis
├── post_process_results.m           # Creates the output graphs and excel file 
├── model/                           # Folder containing Dynare default output    
├── models_results/                  # Folder containing all results stemming from the baseline model as well as the sensititivy analyses
  ├── baseline/                      # Folder containing the graphs and steady-state values resulting from the baseline model
  ├── sensitivity_betta_H/           # Folder containing the graphs and steady-state values resulting from the sensitivity analysis of betta_H
  ├── sensitivity_betta_M/           # Folder containing the graphs and steady-state values resulting from the sensitivity analysis of betta_M
  ├── sensitivity_betta_S/           # Folder containing the graphs and steady-state values resulting from the sensitivity analysis of betta_S
  ├── sensitivity_epsilon_c/         # Folder containing the graphs and steady-state values resulting from the sensitivity analysis of epsilon_c
  ├── sensitivity_Gamma/             # Folder containing the graphs and steady-state values resulting from the sensitivity analysis of Gamma
  ├── sensitivity_kappa_d/           # Folder containing the graphs and steady-state values resulting from the sensitivity analysis of kappa_d
  ├── sensitivity_kappa_m/           # Folder containing the graphs and steady-state values resulting from the sensitivity analysis of kappa_m
  ├── sensitivity_kappa_w/           # Folder containing the graphs and steady-state values resulting from the sensitivity analysis of kappa_w
  ├── sensitivity_kappa_y/           # Folder containing the graphs and steady-state values resulting from the sensitivity analysis of kappa_y
  ├── sensitivity_omega/             # Folder containing the graphs and steady-state values resulting from the sensitivity analysis of omega
  ├── sensitivity_phi_f/             # Folder containing the graphs and steady-state values resulting from the sensitivity analysis of phi_f
  ├── sensitivity_phi_pi/            # Folder containing the graphs and steady-state values resulting from the sensitivity analysis of phi_pi
  ├── sensitivity_PSI/               # Folder containing the graphs and steady-state values resulting from the sensitivity analysis of PSI
  ├── sensitivity_tau_H/             # Folder containing the graphs and steady-state values resulting from the sensitivity analysis of tau_H
  ├── sensitivity_tau_M/             # Folder containing the graphs and steady-state values resulting from the sensitivity analysis of tau_M
  ├── sensitivity_theta/             # Folder containing the graphs and steady-state values resulting from the sensitivity analysis of theta
```
