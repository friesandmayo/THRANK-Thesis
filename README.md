# THRANK-Thesis

## TLDR
The main important folders are the "graphs" folders for each model run. The root directory contains the baseline model and its results.
In the sensitivity_analysis folder, the important results are the graphs folders which show the results of changing one parameter's value. 
The baseline and alternate values can be found in the "parameter.m" Matlab code which is a modular script that runs the sensitivity analysis.

## Structure

```
THRANK-Thesis/
├── model.mod                        # Main "baseline" model file. Creates the main policy experiment and the comparative graphs
├── matlab_run.m                     # Runs model.mod       
├── model/                           # Folder containing the results    
  ├── graphs/                        # Folder containing the relevant graphs stemming from the model
├── sensitivity_analysis/            # Folder containing all the parameter sensitivity analysis                
  ├── epsilon_c_sensitivity/         # Sensitivity analysis for epsilon_c 
    ├── epsilon_c.m                  # Matlab code that runs the baseline model with the baseline parameter value as well as an alternate value and creates graphs
    ├── model_sensitivity/           # Folder containing the results of the sensitivity analysis for epsilon_c
      ├── graphs/                    # Folder containing the graphs mapping the sensitivity analysis for epsilon_c
  ├── gamma_sensitivity/             # Structure follows the same as for epsilon_c which goes for all other parameter tests
    ├── gamma.m
    ├── model_sensitivity/
      ├── graphs/
  ├── omega_sensitivity/
    ├── omega.m
    ├── model_sensitivity/
      ├── graphs/
  ├── phi_f_sensitivity/
    ├── phi_f.m
    ├── model_sensitivity/
      ├── graphs/
  ├── phi_pi_sensitivity/
    ├── phi_pi.m
    ├── model_sensitivity/
      ├── graphs/
  ├── theta_sensitivity/
    ├── theta.m
    ├── model_sensitivity/
      ├── graphs/
```
