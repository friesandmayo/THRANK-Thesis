/*
* This file implements the New Keynesian DSGE model described in my thesis 
*/

// Baseline model.


%--------------------------------------------------------------------------------
% Variables
%--------------------------------------------------------------------------------

var 
  // Household variables
  C_H      $C_\mathrm{H}$      (long_name='H Consumption')
  L_H      $L_\mathrm{H}$      (long_name='H Labour')
  m_H      $m_\mathrm{H}$      (long_name='H Bank Deposits')
  m_cH     $m^c_\mathrm{H}$    (long_name='H RFA Deposits')
  m_tilde_H $\widetilde{m}_\mathrm{H}$     (long_name='H Deposit Bundle')
  C_M      $C_\mathrm{M}$      (long_name='M Consumption')
  L_M      $L_\mathrm{M}$      (long_name='M Labour')
  H_M      $H_\mathrm{M}$      (long_name='M Housing')
  n_M      $n_\mathrm{M}$      (long_name='M Mortgage Debt')
  m_M      $m_\mathrm{M}$      (long_name='M Bank Deposits')
  m_cM     $m^c_\mathrm{M}$    (long_name='M RFA Deposits')
  m_tilde_M $\widetilde{m}_\mathrm{M}$     (long_name='M Deposit Bundle')
  C_S      $C_\mathrm{S}$      (long_name='S Consumption')
  H_S      $H_\mathrm{S}$      (long_name='S Housing')
  b_S      $b_\mathrm{S}$      (long_name='S Bonds')
  K_S      $K_\mathrm{S}$      (long_name='S Capital')
  I_S      $I_\mathrm{S}$      (long_name='S Investment')
  d_S      $d_\mathrm{S}$      (long_name='S Dividends')
  m_S      $m_\mathrm{S}$      (long_name='S Bank Deposits')
  m_cS     $m^c_\mathrm{S}$    (long_name='S RFA Deposits')
  m_tilde_S $\widetilde{m}_\mathrm{S}$     (long_name='S Deposit Bundle')

  // Aggregates
  C        $C$                 (long_name='Aggregate Consumption')
  H        $H$                 (long_name='Aggregate Housing')
  d        $d$                 (long_name='Aggregate Profits')
  m        $m$                 (long_name='Aggregate Deposits')
  m_c      $m^c$               (long_name='Aggregate CB Reserves')
  n        $n$                 (long_name='Aggregate Mortgages')
  b        $b$                 (long_name='Aggregate Bonds')

  // Private-Sector variables
  Y        $Y$                 (long_name='Aggregate Output')
  K        $K$                 (long_name='Aggregate Capital')
  I        $I$                 (long_name='Aggregate Investment')
  L        $L$                 (long_name='Aggregate Labour')
  mc       $mc$                (long_name='Marginal Cost')
  d_i      $d^i$               (long_name='Intermediate Goods Firm Profits')
  d_k      $d^k$               (long_name='Capital Producer Firm Profits')
  d_b      $d^b$               (long_name='Commercial Bank Profits')
  DELTA    $\Delta$            (long_name='Price Dispersion')
  X_1      $X_1$               (long_name='Auxiliary Variable 1')
  X_2      $X_2$               (long_name='Auxiliary Variable 2')

  // Public-Sector variables
  T_H      $T_\mathrm{H}$      (long_name='H Union Fees')
  T_M      $T_\mathrm{M}$      (long_name='M Union Fees')
  f        $f$                 (long_name='Central Bank Lending')
  m_cB     $m^c_\mathrm{B}$    (long_name='Central Bank Reserves')
  G        $G$                 (long_name='Seigniorage')

  // Interest Rates
  i_d      $i^d$               (long_name='Interest on Bank Deposits')
  i_b      $i^b$               (long_name='Interest on Bonds')
  i_n      $i^n$               (long_name='Interest on Mortgages')
  i        $i$                 (long_name='Policy Interest Rate')
  i_f      $i^f$               (long_name='Central Bank Lending Rate')

  // Prices and rates
  p_tilde  $\tilde{p}$         (long_name='Reset Price')
  w        $w$                 (long_name='Wage')
  w_H      $w_\mathrm{H}$      (long_name='H Wage')
  w_M      $w_\mathrm{M}$      (long_name='M Wage')
  s        $s$                 (long_name='Price of Housing')
  q        $q$                 (long_name='Tobins Q (shadow value of installed capital)')
  r        $r$                 (long_name='Rental Rate of Capital')
  pi_var   $\pi$               (long_name='Price Inflation')
  pi_w_H   $\pi^w_\mathrm{H}$  (long_name='H Wage Inflation')
  pi_w_M   $\pi^w_\mathrm{M}$  (long_name='M Wage Inflation')
  mu       $\mu$               (long_name='Borrowing Constraint Multiplier')

  // Exogenous variables
  Z        $Z$                 (long_name='Technology')
  xi       $\xi$               (long_name='Discretionary Monetary Policy')

  // Measurement additions (not present in algebra)
  U_H      $U_\mathrm{H}$      (long_name='H Period Utility')
  V_H      $V_\mathrm{H}$      (long_name='H Welfare')
  INC_H    $INC_\mathrm{H}$    (long_name='H Income')      
  NW_H     $NW_\mathrm{H}$     (long_name='H Net Wealth') 
  U_M      $U_\mathrm{M}$      (long_name='M Period Utility')
  V_M      $V_\mathrm{M}$      (long_name='M Welfare')
  INC_M    $INC_\mathrm{M}$    (long_name='M Income')
  NW_M     $NW_\mathrm{M}$     (long_name='M Net Wealth')
  U_S      $U_\mathrm{S}$      (long_name='S Period Utility')
  V_S      $V_\mathrm{S}$      (long_name='S Welfare')
  INC_S    $INC_\mathrm{S}$    (long_name='S Income')
  NW_S     $NW_\mathrm{S}$     (long_name='S Net Wealth')
  W_TOT    $W_\mathrm{TOT}$    (long_name='Total Welfare')
  INC_TOT  $INC_\mathrm{TOT}$  (long_name='Total Income')
  NW_TOT   $NW_\mathrm{TOT}$   (long_name='Total Net Wealth')
  NWR      $NWR$               (long_name='Net Wealth Ratio')
  GINI_W   $GINI_W$            (long_name='Gini Coefficient for Wealth')
  GINI_I   $GINI_I$            (long_name='Gini Coefficient for Income')
  WR       $WR$                (long_name='Walras Residual')
  i_r      $i^r$               (long_name='Real Policy Rate')
  SR_H     $SR_\mathrm{H}$     (long_name='H Savings Rate')
  SR_M     $SR_\mathrm{M}$     (long_name='M Savings Rate')
  SR_S     $SR_\mathrm{S}$     (long_name='S Savings Rate')

  // Extension: Quantity Limits
  i_cH     $i^c_\mathrm{H}$    (long_name='H Tiered CBDC Rate')
  i_cM     $i^c_\mathrm{M}$    (long_name='M Tiered CBDC Rate')
  i_cS     $i^c_\mathrm{S}$    (long_name='S Tiered CBDC Rate')
  excess_m_H                   (long_name='H Excess CBDC Holdings')
  excess_m_M                   (long_name='M Excess CBDC Holdings')
  excess_m_S                   (long_name='S Excess CBDC Holdings')
;




%--------------------------------------------------------------------------------
% Exogenous Shocks
%--------------------------------------------------------------------------------

varexo 
  varepsilon_z   $\varepsilon_z$    (long_name='Technological Shock')
  varepsilon_xi  $\varepsilon_\xi$  (long_name='Monetary Policy Shock')
  varpi          $\varpi$           (long_name='Deposit Bundle Weight')
;


%--------------------------------------------------------------------------------
% Parameters
%--------------------------------------------------------------------------------

parameters 

  // Agents
  lambda_H  $\lambda_\mathrm{H}$    (long_name='H Population Share')
  lambda_M  $\lambda_\mathrm{M}$    (long_name='M Population Share')
  lambda_S  $\lambda_\mathrm{S}$    (long_name='S Population Share')
  betta_H   $\beta_\mathrm{H}$      (long_name='H Discount Factor')
  betta_M   $\beta_\mathrm{M}$      (long_name='M Discount Factor')
  betta_S   $\beta_\mathrm{S}$      (long_name='S Discount Factor')
  sigma     $\sigma$                (long_name='Relative Risk Aversion')
  psi       $\psi$                  (long_name='Inverse Elasticity of Money Demand')
  eta       $\eta$                  (long_name='Inverse Elasticity of substitution for Housing')
  varphi    $\varphi$               (long_name='Inverse Frisch Elasticity of Labour Supply') 
  epsilon_c $\epsilon^c$            (long_name='Elasticity of Substitution between Deposits and RFA')
  chi_H     $\chi_\mathrm{H}$       (long_name='H Labour Disutility Parameter') 
  chi_M     $\chi_\mathrm{M}$       (long_name='M Labour Disutility Parameter')   
  PSI       $\Psi$                  (long_name='Money Utility Parameter') 
  THETA     $\Theta$                (long_name='Housing Utility Parameter')

  // Housing 
  Gamma     $\Gamma$                (long_name='LTV Ratio')
  H_bar     $\bar{H}$               (long_name='Fixed Housing Supply')

  // Production
  alppha    $\alpha$                (long_name='Capital Share of Production')
  theta     $\theta$                (long_name='Calvo Sticky Price Parameter')
  delta     $\delta$                (long_name='Capital Depreciation Rate')
  kappa_y   $\kappa^y$              (long_name='Investment Adjustment Costs Parameter')
  epsilon_y $\epsilon^y$            (long_name='Elasticity of Substitution between Good varieties')
  kappa_w   $\kappa^w$              (long_name='Wage Adjustment Cost Parameter')
  epsilon_w $\epsilon_w$            (long_name='Elasticity of Substitution between Labour varieties')
  alpha_L   $\alpha_l$              (long_name='H Share in Labour Aggregator')
  
  // Banking
  kappa_n   $\kappa^n$              (long_name='Mortgage Rate Adjustment Costs')
  kappa_d   $\kappa^d$              (long_name='Deposit Rate Adjustment Costs') 
  kappa_b   $\kappa^b$              (long_name='Bond Rate Adjustment Costs')                      
  epsilon_n $\epsilon^n$            (long_name='Elasticity of Substitution between Mortgage varieties')
  epsilon_d $\epsilon^d$            (long_name='Elasticity of Substitution between Bank Deposit varieties')
  epsilon_b $\epsilon^b$            (long_name='Elasticity of Substitution between Bond varieties')

  // Policy
  phi_pi    $\phi_\pi$              (long_name='Taylor Rule Inflation Reaction Parameter')
  phi_f     $\phi_f$                (long_name='Central Bank Lending Rate Penalty')
  omega     $\omega$                (long_name='Reserve Requirement')
  rho_i     $\rho_i$                (long_name='Taylor Rule Interest Rate Smoothing Parameter')

  // Shocks
  rho_z     $\rho_z$                (long_name='Technology Shock Persistence')
  rho_xi    $\rho_\xi$              (long_name='Monetary Policy Shock Persistence')
  sigma_z   $\sigma_z$              (long_name='Standard Deviation of Technological Shock')
  sigma_xi  $\sigma_\xi$            (long_name='Standard Deviation of Monetary Policy Shock')
  varpi_end

  // Extension: Quantity Limits
  m_bar     $\bar{m}^c$             (long_name='CBDC Threshold for Penalty')
  tau       $\tau$                  (long_name='Penalty Rate on Excess CBDC')
;




%--------------------------------------------------------------------------------
% Macro-Processor Calibration (Receives inputs from run_project.m)
%--------------------------------------------------------------------------------
@#ifndef theta_val
    @#define theta_val = 0.75
@#endif
@#ifndef Gamma_val
    @#define Gamma_val = 0.70
@#endif
@#ifndef lambda_H_val
    @#define lambda_H_val = 0.50
@#endif
@#ifndef betta_H_val
    @#define betta_H_val = 0.994    
@#endif
@#ifndef lambda_M_val
    @#define lambda_M_val = 0.40
@#endif
@#ifndef betta_M_val
    @#define betta_M_val = 0.99
@#endif
@#ifndef lambda_S_val
    @#define lambda_S_val = 0.10
@#endif
@#ifndef betta_S_val
    @#define betta_S_val = 0.994
@#endif
@#ifndef sigma_val
    @#define sigma_val = 1.50
@#endif
@#ifndef delta_val
    @#define delta_val = 0.025
@#endif
@#ifndef psi_val
    @#define psi_val = 1.50
@#endif
@#ifndef kappa_y_val
    @#define kappa_y_val = 2.00
@#endif
@#ifndef eta_val
    @#define eta_val = 1.50
@#endif
@#ifndef epsilon_y_val
    @#define epsilon_y_val = 6.00
@#endif
@#ifndef varphi_val
    @#define varphi_val = 1.00
@#endif
@#ifndef kappa_w_val
    @#define kappa_w_val = 50.00
@#endif
@#ifndef chi_H_val
    @#define chi_H_val = 17.6335
@#endif
@#ifndef chi_M_val
    @#define chi_M_val = 12.7612
@#endif
@#ifndef epsilon_w_val
    @#define epsilon_w_val = 5.00
@#endif
@#ifndef PSI_val
    @#define PSI_val = 0.0183808
@#endif
@#ifndef alpha_L_val
    @#define alpha_L_val = 0.35
@#endif
@#ifndef epsilon_c_val
    @#define epsilon_c_val = 6.00
@#endif
@#ifndef alppha_val
    @#define alppha_val = 0.33
@#endif
@#ifndef THETA_val
    @#define THETA_val = 0.20
@#endif
@#ifndef H_bar_val
    @#define H_bar_val = 1.00
@#endif
@#ifndef omega_val
    @#define omega_val = 0.025
@#endif
@#ifndef kappa_n_val
    @#define kappa_n_val = 10
@#endif
@#ifndef kappa_d_val
    @#define kappa_d_val = 3
@#endif
@#ifndef kappa_b_val
    @#define kappa_b_val = 0
@#endif
@#ifndef epsilon_n_val
    @#define epsilon_n_val = 6
@#endif
@#ifndef epsilon_d_val
    @#define epsilon_d_val = -0.3
@#endif
@#ifndef epsilon_b_val
    @#define epsilon_b_val = -30
@#endif
@#ifndef phi_pi_val
    @#define phi_pi_val = 1.50
@#endif
@#ifndef phi_f_val
    @#define phi_f_val = 0.0025
@#endif
@#ifndef rho_z_val
    @#define rho_z_val = 0.90
@#endif
@#ifndef rho_xi_val
    @#define rho_xi_val = 0.70
@#endif
@#ifndef rho_i_val
    @#define rho_i_val = 0.80
@#endif
@#ifndef varpi_end_val
    @#define varpi_end_val = 0.50
@#endif
@#ifndef m_bar_val
    @#define m_bar_val = 100    // For baseline scenario     
@#endif
@#ifndef tau_val
    @#define tau_val = 0
@#endif

lambda_H   = @{lambda_H_val};    betta_H    = @{betta_H_val}; 
lambda_M   = @{lambda_M_val};    betta_M    = @{betta_M_val};  
lambda_S   = @{lambda_S_val};    betta_S    = @{betta_S_val};
sigma      = @{sigma_val};       delta      = @{delta_val};
psi        = @{psi_val};         kappa_y    = @{kappa_y_val};
eta        = @{eta_val};         epsilon_y  = @{epsilon_y_val};
varphi     = @{varphi_val};      kappa_w    = @{kappa_w_val};
chi_H      = @{chi_H_val};       epsilon_w  = @{epsilon_w_val};
chi_M      = @{chi_M_val};       alpha_L    = @{alpha_L_val};
PSI        = @{PSI_val};         Gamma      = @{Gamma_val};
epsilon_c  = @{epsilon_c_val};   alppha     = @{alppha_val}; 
THETA      = @{THETA_val};       H_bar      = @{H_bar_val}; 
omega      = @{omega_val};       theta      = @{theta_val};  
kappa_n    = @{kappa_n_val};     epsilon_n  = @{epsilon_n_val};
kappa_d    = @{kappa_d_val};     epsilon_d  = @{epsilon_d_val};
kappa_b    = @{kappa_b_val};     epsilon_b  = @{epsilon_b_val};
phi_pi     = @{phi_pi_val};      rho_z      = @{rho_z_val}; 
phi_f      = @{phi_f_val};       rho_i      = @{rho_i_val};
sigma_z    = 0.01;               rho_xi     = @{rho_xi_val}; 
sigma_xi   = 0.0025;             varpi_end  = @{varpi_end_val};   
m_bar      = @{m_bar_val};       tau        = @{tau_val};


%--------------------------------------------------------------------------------
% Model Block
%--------------------------------------------------------------------------------

model;

  // ---------- Hand-to-Mouth Agents ----------
  [name='1. H Budget Constraint']
  C_H + m_H + m_cH + T_H = w_H*L_H + (1+i_d(-1))/(1+pi_var)*m_H(-1) + (1+i_cH(-1))/(1+pi_var)*m_cH(-1);

  [name='2. H Deposit CES Bundle']
  m_tilde_H = ( varpi^(1/epsilon_c) * m_H^((epsilon_c-1)/epsilon_c) + (1-varpi)^(1/epsilon_c) * m_cH^((epsilon_c-1)/epsilon_c) )^(epsilon_c/(epsilon_c-1)); 

  [name='3. H Deposit Euler']
  C_H^(-sigma) =  PSI*m_tilde_H^(-psi) * (varpi*m_tilde_H/m_H)^(1/epsilon_c) + betta_H * ( ((C_H(+1))^(-sigma)) * (1+i_d)/(1+pi_var(+1)) );
  
  [name='4. H RFA Deposit Euler']
  C_H^(-sigma) =  PSI*m_tilde_H^(-psi) * ((1-varpi)*m_tilde_H/m_cH)^(1/epsilon_c) + betta_H * ( ((C_H(+1))^(-sigma)) * (1+i_cH)/(1+pi_var(+1)) );
  
  // ---------- Middle-Income Agents ----------
  [name='5. M Budget Constraint']
  C_M + s*H_M + m_M + m_cM + (1+i_n(-1))/(1+pi_var)*n_M(-1) + T_M = w_M*L_M + s*H_M(-1) + n_M + (1+i_d(-1))/(1+pi_var)*m_M(-1) + (1+i_cM(-1))/(1+pi_var)*m_cM(-1);

  [name='6. M Collateral Constraint (binds in baseline)'] 
  n_M = Gamma * s(+1)*(1+pi_var(+1)) * H_M / (1+i_n); 

  [name='7. M Housing Euler']
  s * C_M^(-sigma) = THETA*H_M^(-eta) + betta_M * ( s(+1) * (C_M(+1))^(-sigma) ) + Gamma * mu * s(+1)*(1+pi_var(+1)) / (1+i_n);

  [name='8. M Mortgage Euler']
  C_M^(-sigma) = mu + betta_M * ( ((C_M(+1))^(-sigma)) * (1+i_n)/(1+pi_var(+1)) );

  [name='9. M Deposit CES Bundle']
  m_tilde_M = ( varpi^(1/epsilon_c) * m_M^((epsilon_c-1)/epsilon_c) + (1-varpi)^(1/epsilon_c) * m_cM^((epsilon_c-1)/epsilon_c) )^(epsilon_c/(epsilon_c-1)); 

  [name='10. M Deposit Euler']
  C_M^(-sigma) = PSI*m_tilde_M^(-psi) * (varpi*m_tilde_M/m_M)^(1/epsilon_c) + betta_M * ( ((C_M(+1))^(-sigma)) * (1+i_d)/(1+pi_var(+1)) );
  
  [name='11. M RFA Deposit Euler']
  C_M^(-sigma) = PSI*m_tilde_M^(-psi) * ((1-varpi)*m_tilde_M/m_cM)^(1/epsilon_c) + betta_M * ( ((C_M(+1))^(-sigma)) * (1+i_cM)/(1+pi_var(+1)) );

  // ---------- Superior-Income Agents ----------
  [name='12. S Budget Constraint']
  C_S + s*H_S + q*I_S + b_S + m_S + m_cS = r*K_S(-1) + d_S + (1+i_b(-1))/(1+pi_var)*b_S(-1) + s*H_S(-1) + (1+i_d(-1))/(1+pi_var)*m_S(-1) + (1+i_cS(-1))/(1+pi_var)*m_cS(-1);

  [name='13. S Capital Accumulation']
  K_S = (1-delta) * K_S(-1) + I_S ;

  [name='14. S Housing Euler']
  s * C_S^(-sigma) = THETA*H_S^(-eta) + betta_S * ( s(+1) * (C_S(+1))^(-sigma) );

  [name='15. S Capital Euler']
  q * (C_S^(-sigma)) = betta_S * ( ((C_S(+1))^(-sigma)) * ( r(+1) + (1-delta)*(q(+1)) ) );
 
  [name='16. S Bond Euler']
  C_S^(-sigma) = betta_S * ( ((C_S(+1))^(-sigma)) * (1+i_b)/(1+pi_var(+1)) );

  [name='17. S Deposit CES Bundle']
  m_tilde_S = ( varpi^(1/epsilon_c) * m_S^((epsilon_c-1)/epsilon_c) + (1-varpi)^(1/epsilon_c) * m_cS^((epsilon_c-1)/epsilon_c) )^(epsilon_c/(epsilon_c-1)); 

  [name='18. S Deposit Euler']
  C_S^(-sigma) = PSI*m_tilde_S^(-psi) * (varpi*m_tilde_S/m_S)^(1/epsilon_c) + betta_S * ( ((C_S(+1))^(-sigma)) * (1+i_d)/(1+pi_var(+1)) );
  
  [name='19. S RFA Deposit Euler']
  C_S^(-sigma) = PSI*m_tilde_S^(-psi) * ((1-varpi)*m_tilde_S/m_cS)^(1/epsilon_c) + betta_S * ( ((C_S(+1))^(-sigma)) * (1+i_cS)/(1+pi_var(+1)) );

  // ---------- Labour Market ----------
  [name='20. H Union Fees'] 
  T_H = kappa_w/2 * (pi_w_H)^2 * w_H;

  [name='21. M Union Fees']
  T_M = kappa_w/2 * (pi_w_M)^2 * w_M;
 
  [name='22. H Wage Inflation']
  1 + pi_w_H = (w_H / w_H(-1)) * (1 + pi_var);

  [name='23. M Wage Inflation']
  1 + pi_w_M = (w_M / w_M(-1)) * (1 + pi_var);

  [name='24. H Wage Phillips Curve']
  kappa_w * pi_w_H * (1 + pi_w_H) = (1 - epsilon_w)*L_H 
    + epsilon_w * ( chi_H * (L_H^(1+varphi)) / (C_H^(-sigma)) ) / w_H 
    + betta_H * kappa_w * ( (C_H(+1)/C_H)^(-sigma) ) * pi_w_H(+1) * (1 + pi_w_H(+1))^2 / (1+pi_var(+1));

  [name='25. M Wage Phillips Curve']
  kappa_w * pi_w_M * (1 + pi_w_M) = (1 - epsilon_w)*L_M 
    + epsilon_w * ( chi_M * (L_M^(1+varphi)) / (C_M^(-sigma)) ) / w_M 
    + betta_M * kappa_w * ( (C_M(+1)/C_M)^(-sigma) ) * pi_w_M(+1) * (1 + pi_w_M(+1))^2 / (1+pi_var(+1));
  
  // ---------- Production / pricing ----------

  [name='26. Goods Producer Profits']
  d_i = Y - w*L - r*K(-1);

  [name='27. Production']
  Y * DELTA = Z * ((K(-1))^alppha) * (L^ (1-alppha));

  [name='28. Aggregate Labour']
  L = ((lambda_H*L_H)^alpha_L) * ((lambda_M*L_M)^(1-alpha_L));

  [name='29. H Labour Demand']
  lambda_H * w_H * L_H = alpha_L * w * L;

  [name='30. M Labour Demand']
  lambda_M * w_M * L_M = (1 - alpha_L) * w * L;

  [name='31. Marginal Cost']
  mc = 1/Z * (( w / (1-alppha) )^(1-alppha)) * ((r/alppha)^alppha);
  
  [name='32. Optimal Input Ratio']
  r / w = ( alppha / (1-alppha) ) * ( L / K(-1) );
  
  [name='33. Auxiliary Equation 1']
  X_1 = (C_S^(-sigma)) * Y * mc + theta * betta_S * ( ((1+pi_var(+1))^epsilon_y) * X_1(+1) ) ;
  
  [name='34. Auxiliary Equation 2']
  X_2 = (C_S^(-sigma)) * Y + theta * betta_S * ( ((1+pi_var(+1))^(epsilon_y-1)) * X_2(+1) ) ;
  
  [name='35. Optimal Pricing Rule']
  p_tilde = ( epsilon_y / (epsilon_y - 1) ) * ( X_1 / X_2 );
  
  [name='36. Aggregate Price Evolution']
  p_tilde = ( ( 1 - theta*((1+pi_var)^(epsilon_y-1)) ) / ( 1 - theta ) )^( 1 / (1-epsilon_y) );
  
  [name='37. Price Dispersion Evolution']
  DELTA = (1-theta) * ( (p_tilde)^(-epsilon_y) ) + theta * ( (1+pi_var)^epsilon_y ) * DELTA(-1);
  
  [name='38. Capital Producer Profits']
  d_k = q*I - I*( 1 + (kappa_y/2) * (( I/(I(-1)) - 1 )^2) );
  
  [name='39. Tobins Q']
  q = 1 + kappa_y*( I/(I(-1)) - 1 )*( I / (I(-1)) ) + (kappa_y/2)*(( I / (I(-1)) - 1 )^2) - 
    betta_S * ( ((C_S(+1))^(-sigma)) / (C_S^(-sigma)) * kappa_y * ( (I(+1))/I - 1 ) * ( (I(+1)) / I )^2);

  // ---------- Commercial Banks ----------
  [name='40. Banks Balance Sheet']
  m_cB + n = f + m + b;

  [name='41. Banks Reserve Requirement']
  m_cB = omega*m ;

  [name='42. Banks Profit']  
  d_b = ((i_n(-1)-i_f(-1))/(1+pi_var))*n(-1) - ((i_d(-1)-omega*i(-1)-(1-omega)*i_f(-1))/(1+pi_var))*m(-1) - ((i_b(-1)-i_f(-1))/(1+pi_var))*b(-1) 
        - kappa_n/2*(( i_n/(i_n(-1)) -1 )^2)*i_n*n 
        - kappa_d/2*(( i_d/(i_d(-1)) -1 )^2)*i_d*m
        - kappa_b/2*(( i_b/(i_b(-1)) -1 )^2)*i_b*b;
 
  [name='43. Mortgage Rate Setting']
  i_n = epsilon_n/(epsilon_n-1)*i_f - (1+i_b)*kappa_n/(epsilon_n-1)*
                      ( i_n/(i_n(-1)) -1 )*(i_n^2)/(i_n(-1))
            + (1+i_b)*(betta_S*(C_S(+1)^(-sigma))/(C_S^(-sigma))*kappa_n/(epsilon_n-1)*
                      ((i_n(+1))/i_n-1)*(i_n(+1)^2)/i_n*n(+1)/n);

  [name='44. Deposit Rate Setting']
  i_d = epsilon_d/(epsilon_d-1)*(omega*i+(1-omega)*i_f) + (1+i_b)*kappa_d/(epsilon_d-1)*     
                      ( i_d/(i_d(-1)) -1 )*(i_d^2)/(i_d(-1))
           - (1+i_b)*( betta_S*(C_S(+1)^(-sigma))/(C_S^(-sigma))*kappa_d/(epsilon_d-1)*
                      ((i_d(+1))/i_d-1)*(i_d(+1)^2)/i_d*m(+1)/m);

  [name='45. Bond Rate Setting']
  i_b = epsilon_b/(epsilon_b-1)*i_f + (1+i_b)*kappa_b/(epsilon_b-1)*     
                      ( i_b/(i_b(-1)) -1 )*(i_b^2)/(i_b(-1))
           - (1+i_b)*( betta_S*(C_S(+1)^(-sigma))/(C_S^(-sigma))*kappa_b/(epsilon_b-1)*
                      ((i_b(+1))/i_b-1)*(i_b(+1)^2)/i_b*b(+1)/b);

  // ---------- Central Bank ----------

  [name='46. Central Bank Balance Sheet'] 
  f = m_c;

  [name='47. Central Bank Profits']
  G = i_f(-1)/(1+pi_var)*f(-1) - 1/(1+pi_var)*(i(-1)*m_cB(-1) + i_cH(-1)*lambda_H*m_cH(-1) + i_cM(-1)*lambda_M*m_cM(-1) + i_cS(-1)*lambda_S*m_cS(-1));

  [name='48. Taylor Rule'] 
  log( (1+i) / (1+steady_state(i)) ) = rho_i*log( (1+i(-1)) / (1+steady_state(i)) ) + (1-rho_i)*phi_pi*log(1+pi_var) + xi;

  [name='49. Central Bank Lending Rule']
  i_f = phi_f + i;

  [name='Central Bank Reserves'] // (Not in pdf)
  m_c = lambda_H*m_cH + lambda_M*m_cM + lambda_S*m_cS + m_cB;

  // ---------- Aggregation / Market Clearing ----------

  [name='50. Total Profits']
  d = d_i + d_k + d_b;

  [name='51. Aggregate Consumption']
  C = lambda_H*C_H + lambda_M*C_M + lambda_S*C_S;

  [name='52. Aggregate Deposits']
  m = lambda_H*m_H + lambda_M*m_M + lambda_S*m_S;

  [name='53. Aggregate Housing']
  H = lambda_M*H_M + lambda_S*H_S;

  [name='54. Aggregate Mortgages']
  n = lambda_M*n_M;

  [name='55. Aggregate Investment']
  I = lambda_S*I_S;

  [name='56. Aggregate Capital']
  K = lambda_S*K_S; // 

  [name='57. Aggregate Bonds'] 
  b = lambda_S*b_S;

  [name='58. Aggregate Dividends']
  d = lambda_S*d_S;

  [name='59. Housing Market Clearing']
  H = H_bar;

  [name='Goods Market Clearing'] // checking that Walras Law holds (not in pdf)
  WR = - Y + C + I + G + (kappa_y/2)*((I/(I(-1))-1)^2)*I 
         + (kappa_n/2) * (( i_n/(i_n(-1)) - 1 )^2) * i_n * n 
         + (kappa_d/2) * (( i_d/(i_d(-1)) - 1 )^2) * i_d * m
         + (kappa_b/2) * (( i_b/(i_b(-1)) - 1 )^2) * i_b * b
         + lambda_H * (kappa_w/2) * (pi_w_H^2) * w_H
         + lambda_M * (kappa_w/2) * (pi_w_M^2) * w_M;

  // ---------- Shocks ----------
  [name='60. Technological Process']
  log(Z) = rho_z*log(Z(-1)) + varepsilon_z;
  
  [name='61. Monetary Policy Shock']
  xi = rho_xi*xi(-1) + varepsilon_xi;

  // ---------- Wealth & Income ----------

  [name='Real Policy Rate']
  1+i_r = (1+i)/(1+pi_var(+1));

  [name='H Income']
  INC_H = w_H*L_H + i_d(-1)/(1+pi_var)*m_H(-1) + i_cH(-1)/(1+pi_var)*m_cH(-1) - T_H;
  [name='H Net Wealth']
  NW_H = m_H + m_cH;
  [name='H Savings Rate']
  SR_H = (INC_H - C_H) / INC_H;

  [name='M Income']        
  INC_M = w_M*L_M + (s - s(-1))*H_M(-1) - i_n(-1)/(1+pi_var)*n_M(-1) +  i_d(-1)/(1+pi_var)*m_M(-1) + i_cM(-1)/(1+pi_var)*m_cM(-1) - T_M;
  [name='M Net Wealth']
  NW_M = s*H_M - n_M + m_M + m_cM;
  [name='M Savings Rate'] 
  SR_M = (INC_M - C_M) / INC_M;

  [name='S Income']
  INC_S = (s - s(-1))*H_S(-1) + (q - q(-1))*K_S(-1) + i_b(-1)/(1+pi_var)*b_S(-1) + r*K_S(-1) + d_S + i_d(-1)/(1+pi_var)*m_S(-1) + i_cS(-1)/(1+pi_var)*m_cS(-1);
  [name='S Net Wealth']
  NW_S = q*K_S + s*H_S + b_S + m_S + m_cS;
  [name='S Savings Rate'] 
  SR_S = (INC_S - C_S) / INC_S;

  [name='Total Income'] 
  INC_TOT = lambda_H*INC_H + lambda_M*INC_M + lambda_S*INC_S;
  [name='Total Net Wealth']
  NW_TOT = lambda_H*NW_H + lambda_M*NW_M + lambda_S*NW_S;
  [name='Net Wealth Ratio']
  NWR = NW_S*lambda_S / NW_TOT; 

  // ---------- Welfare ----------
  
  [name='H Period Utility']
  U_H = (C_H^(1-sigma))/(1-sigma) + PSI*(m_tilde_H^(1-psi))/(1-psi) - chi_H*(L_H^(1+varphi))/(1+varphi);
  [name='M Period Utility']
  U_M = (C_M^(1-sigma))/(1-sigma) + PSI*(m_tilde_M^(1-psi))/(1-psi) + THETA*(H_M^(1-eta))/(1-eta) - chi_M*(L_M^(1+varphi))/(1+varphi);
  [name='S Period Utility']
  U_S = (C_S^(1-sigma))/(1-sigma) + PSI*(m_tilde_S^(1-psi))/(1-psi) + THETA*(H_S^(1-eta))/(1-eta);

  [name='H Welfare']
  V_H = U_H + betta_H * V_H(+1); 
  [name='M Welfare']
  V_M = U_M + betta_M * V_M(+1);
  [name='S Welfare']
  V_S = U_S + betta_S * V_S(+1);
  [name='Total Welfare']
  W_TOT = lambda_H*V_H + lambda_M*V_M + lambda_S*V_S;

  // ---------- Gini ----------

  [name='Income Gini Coefficient'] // Important: I assume that INC_H is smaller than INC_M which is smaller than INC_S
  GINI_I = ( lambda_H*lambda_M*(INC_M - INC_H)+lambda_S*lambda_H*(INC_S - INC_H)+lambda_S*lambda_M*(INC_S - INC_M) ) / (lambda_H*INC_H + lambda_M*INC_M + lambda_S*INC_S);
  [name='Wealth Gini Coefficient']
  GINI_W = ( lambda_H*lambda_M*(NW_M - NW_H)+lambda_S*lambda_H*(NW_S - NW_H)+lambda_S*lambda_M*(NW_S - NW_M) ) / (lambda_H*NW_H + lambda_M*NW_M + lambda_S*NW_S);

  // ---------- Extension: Quantity Limits ----------

  [name='H Excess CBDC Holdings']
  excess_m_H = ( (m_cH - m_bar) + sqrt((m_cH - m_bar)^2 ) ) / 2;

  [name='M Excess CBDC Holdings']
  excess_m_M = ( (m_cM - m_bar) + sqrt((m_cM - m_bar)^2 ) ) / 2;

  [name='S Excess CBDC Holdings']
  excess_m_S = ( (m_cS - m_bar) + sqrt((m_cS - m_bar)^2 ) ) / 2;

  [name='H Tiered CBDC Rate']
  i_cH = i - tau * excess_m_H;
  
  [name='M Tiered CBDC Rate']
  i_cM = i - tau * excess_m_M;

  [name='S Tiered CBDC Rate']
  i_cS = i - tau * excess_m_S;


end;




%--------------------------------------------------------------------------------
% Initial Steady-State
%--------------------------------------------------------------------------------

initval;  
  // Frictions and Shocks 
  varpi = 0.999999;
  pi_var = 0;
  pi_w_H = 0;
  pi_w_M = 0;
  T_H = 0; 
  T_M = 0;
  p_tilde = 1;
  DELTA = 1;
  q = 1;
  Z = 1;
  xi = 0;

  // Analytically Solvable
  d_k = 0;
  i = 1/betta_S - 1 - phi_f;   
  H = H_bar;
  r = 1/betta_S - 1 + delta;
  mc = (epsilon_y-1)/epsilon_y;
  w = (1-alppha)*( mc*(r/alppha)^(-alppha) )^(1/(1-alppha));
  i_b = (1-betta_S) / betta_S;
  i_f = (epsilon_b-1)/epsilon_b * i_b;
  i = i_f - phi_f;
  i_d = (i_f - omega*phi_f)*epsilon_d/(epsilon_d-1);
  i_n = epsilon_n/(epsilon_n-1)*i_f; 
  
  // Guesses
  L_H = 0.33;
  L_M = 0.35;
  H_S = H; 

  // H 
  L = ((lambda_H*L_H)^alpha_L) * ((lambda_M*L_M)^(1-alpha_L));
  w_H = alpha_L * w * L / (lambda_H * L_H);
  w_M = (1 - alpha_L) * w * L / (lambda_M * L_M);
  C_H = ( (w_H * (epsilon_w-1)/epsilon_w) / (chi_H * L_H^varphi) )^(1/sigma);
  m_tilde_H = ( varpi * ( PSI / ( (1 - betta_H*(1+i_d))*C_H^(-sigma) ) )^(epsilon_c-1) + (1-varpi) * ( PSI / ( (1 - betta_H*(1+i))*C_H^(-sigma) ) )^(epsilon_c-1) )^(1/(psi*(epsilon_c-1)));
  m_H = m_tilde_H^(1-psi*epsilon_c) * varpi * ( PSI / ( (1 - betta_H*(1+i_d))*C_H^(-sigma) ) )^epsilon_c;
  m_cH = m_tilde_H^(1-psi*epsilon_c) * (1-varpi) * ( PSI / ( (1 - betta_H*(1+i))*C_H^(-sigma) ) )^epsilon_c; 
  
  // M 
  H_M = (H - lambda_S*H_S)/lambda_M; 
  C_M = ( (w_M * (epsilon_w-1)/epsilon_w) / (chi_M * L_M^varphi) )^(1/sigma);
  n_M = 1/i_n * (w_M*L_M - C_M);
  n = lambda_M*n_M;
  s = n_M/(Gamma*H_M) * (1+i_n);
  mu = (1-betta_M*(1+i_n))*(C_M^(-sigma));
  m_tilde_M = ( varpi * ( PSI / ( (1 - betta_M*(1+i_d))*C_M^(-sigma) ) )^(epsilon_c-1) + (1-varpi) * ( PSI / ( (1 - betta_M*(1+i))*C_M^(-sigma) ) )^(epsilon_c-1) )^(1/(psi*(epsilon_c-1)));
  m_M = m_tilde_M^(1-psi*epsilon_c) * varpi * ( PSI / ( (1 - betta_M*(1+i_d))*C_M^(-sigma) ) )^epsilon_c;
  m_cM = m_tilde_M^(1-psi*epsilon_c) * (1-varpi) * ( PSI / ( (1 - betta_M*(1+i))*C_M^(-sigma) ) )^epsilon_c;

  // Firms
  K = alppha/(1-alppha)*L*w/r;
  Y = Z*(K^alppha)*(L^(1-alppha));
  d_i = Y - w*L - r*K;
  K_S = K/lambda_S;
  I_S = delta*K_S;
  I = lambda_S*I_S;
  C = Y - I;
  C_S = 1/lambda_S * (C-lambda_H*C_H-lambda_M*C_M);
  X_1 = (C_S^(-sigma)) * Y * mc / (1 - theta * betta_S) ;
  X_2 = (C_S^(-sigma)) * Y / (1 - theta * betta_S) ;
  WR = - Y + C + I ;

  // S 
  m_tilde_S = ( varpi * ( PSI / ( (1 - betta_S*(1+i_d))*C_S^(-sigma) ) )^(epsilon_c-1) + (1-varpi) * ( PSI / ( (1 - betta_S*(1+i))*C_S^(-sigma) ) )^(epsilon_c-1) )^(1/(psi*(epsilon_c-1)));
  m_S = m_tilde_S^(1-psi*epsilon_c) * varpi * ( PSI / ( (1 - betta_S*(1+i_d))*C_S^(-sigma) ) )^epsilon_c;
  m_cS = m_tilde_S^(1-psi*epsilon_c) * (1-varpi) * ( PSI / ( (1 - betta_S*(1+i))*C_S^(-sigma) ) )^epsilon_c;
  m = lambda_H*m_H + lambda_M*m_M + lambda_S*m_S;
  m_cB = omega*m;
  b_S = (1/i_f)*(C_S + I_S - r*K_S - i_d*m_S - i*m_cS - 1/lambda_S*(d_i + (i_n-i_f)*n - (i_d-omega*i-(1-omega)*i_f)*m));
  b = lambda_S*b_S;
  d_b = (i_n-i_f)*n - (i_d-omega*i-(1-omega)*i_f)*m - (i-i_f)*b;
  d = d_i + d_b;
  d_S = d/lambda_S;

  // Else Updates
  INC_H = w_H*L_H + i_d*m_H + i*m_cH + T_H;
  NW_H = m_H + m_cH;
  INC_M = w_M*L_M + i_d*m_M + i*m_cM + T_M;
  NW_M = s*H_M - n_M + m_M + m_cM;
  INC_S = i*b_S + r*K_S + d_S + i_d*m_S + i*m_cS;
  NW_S = q*K_S + s*H_S + b_S + m_S + m_cS;
  INC_TOT = 100*(lambda_H*INC_H + lambda_M*INC_M + lambda_S*INC_S);
  NW_TOT = 100*(lambda_H*NW_H + lambda_M*NW_M + lambda_S*NW_S);
  NWR = NW_S*100*lambda_S / NW_TOT; 
  U_H = (C_H^(1-sigma))/(1-sigma) + PSI*(m_tilde_H^(1-psi))/(1-psi) - chi_H*(L_H^(1+varphi))/(1+varphi);
  U_M = (C_M^(1-sigma))/(1-sigma) + PSI*(m_tilde_M^(1-psi))/(1-psi) + THETA*(H_M^(1-eta))/(1-eta) - chi_M*(L_M^(1+varphi))/(1+varphi);
  U_S = (C_S^(1-sigma))/(1-sigma) + PSI*(m_tilde_S^(1-psi))/(1-psi) + THETA*(H_S^(1-eta))/(1-eta);
  V_H = U_H/(1-betta_H); 
  V_M = U_M/(1-betta_M);
  V_S = U_S/(1-betta_S);
  W_TOT = lambda_H*V_H + lambda_M*V_M + lambda_S*V_S;
  GINI_I = ( lambda_H*lambda_M*(INC_M - INC_H)+lambda_S*lambda_H*(INC_S - INC_H)+lambda_S*lambda_M*(INC_S - INC_M) ) / (lambda_H*INC_H + lambda_M*INC_M + lambda_S*INC_S);
  GINI_W = ( lambda_H*lambda_M*(NW_M - NW_H)+lambda_S*lambda_H*(NW_S - NW_H)+lambda_S*lambda_M*(NW_S - NW_M) ) / (lambda_H*NW_H + lambda_M*NW_M + lambda_S*NW_S);
  i_cH = i;
  i_cM = i;
  i_cS = i;
  excess_m_H = 0;
  excess_m_M = 0;
  excess_m_S = 0;
end;
steady(solve_algo=4);


%--------------------------------------------------------------------------------
% End Steady-State
%--------------------------------------------------------------------------------

endval;
    // Frictions and Shocks 
  varpi = varpi_end;
  pi_var = 0;
  pi_w_H = 0;
  pi_w_M = 0;
  T_H = 0; 
  T_M = 0;
  p_tilde = 1;
  DELTA = 1;
  q = 1;
  Z = 1;
  xi = 0;

  // Analytically Solvable
  d_k = 0;
  i = 1/betta_S - 1 - phi_f;  
  H = H_bar;
  r = 1/betta_S - 1 + delta;
  mc = (epsilon_y-1)/epsilon_y;
  w = (1-alppha)*( mc*(r/alppha)^(-alppha) )^(1/(1-alppha));
  i_b = (1-betta_S) / betta_S;
  i_f = (epsilon_b-1)/epsilon_b * i_b;
  i = i_f - phi_f;
  i_d = (i_f - omega*phi_f)*epsilon_d/(epsilon_d-1);
  i_n = epsilon_n/(epsilon_n-1)*i_f; 
  
  // Guesses
  L_H = 0.33;
  L_M = 0.35;
  H_S = H; 

  // H 
  L = ((lambda_H*L_H)^alpha_L) * ((lambda_M*L_M)^(1-alpha_L));
  w_H = alpha_L * w * L / (lambda_H * L_H);
  w_M = (1 - alpha_L) * w * L / (lambda_M * L_M);
  C_H = ( (w_H * (epsilon_w-1)/epsilon_w) / (chi_H * L_H^varphi) )^(1/sigma);
  m_tilde_H = ( varpi * ( PSI / ( (1 - betta_H*(1+i_d))*C_H^(-sigma) ) )^(epsilon_c-1) + (1-varpi) * ( PSI / ( (1 - betta_H*(1+i))*C_H^(-sigma) ) )^(epsilon_c-1) )^(1/(psi*(epsilon_c-1)));
  m_H = m_tilde_H^(1-psi*epsilon_c) * varpi * ( PSI / ( (1 - betta_H*(1+i_d))*C_H^(-sigma) ) )^epsilon_c;
  m_cH = m_tilde_H^(1-psi*epsilon_c) * (1-varpi) * ( PSI / ( (1 - betta_H*(1+i))*C_H^(-sigma) ) )^epsilon_c; 
  
  // M 
  H_M = (H - lambda_S*H_S)/lambda_M; 
  C_M = ( (w_M * (epsilon_w-1)/epsilon_w) / (chi_M * L_M^varphi) )^(1/sigma);
  n_M = 1/i_n * (w_M*L_M - C_M);
  n = lambda_M*n_M;
  s = n_M/(Gamma*H_M) * (1+i_n);
  mu = (1-betta_M*(1+i_n))*(C_M^(-sigma));
  m_tilde_M = ( varpi * ( PSI / ( (1 - betta_M*(1+i_d))*C_M^(-sigma) ) )^(epsilon_c-1) + (1-varpi) * ( PSI / ( (1 - betta_M*(1+i))*C_M^(-sigma) ) )^(epsilon_c-1) )^(1/(psi*(epsilon_c-1)));
  m_M = m_tilde_M^(1-psi*epsilon_c) * varpi * ( PSI / ( (1 - betta_M*(1+i_d))*C_M^(-sigma) ) )^epsilon_c;
  m_cM = m_tilde_M^(1-psi*epsilon_c) * (1-varpi) * ( PSI / ( (1 - betta_M*(1+i))*C_M^(-sigma) ) )^epsilon_c;

  // Firms
  K = alppha/(1-alppha)*L*w/r;
  Y = Z*(K^alppha)*(L^(1-alppha));
  d_i = Y - w*L - r*K;
  K_S = K/lambda_S;
  I_S = delta*K_S;
  I = lambda_S*I_S;
  C = Y - I;
  C_S = 1/lambda_S * (C-lambda_H*C_H-lambda_M*C_M);
  X_1 = (C_S^(-sigma)) * Y * mc / (1 - theta * betta_S) ;
  X_2 = (C_S^(-sigma)) * Y / (1 - theta * betta_S) ;
  WR = - Y + C + I ;

  // S 
  m_tilde_S = ( varpi * ( PSI / ( (1 - betta_S*(1+i_d))*C_S^(-sigma) ) )^(epsilon_c-1) + (1-varpi) * ( PSI / ( (1 - betta_S*(1+i))*C_S^(-sigma) ) )^(epsilon_c-1) )^(1/(psi*(epsilon_c-1)));
  m_S = m_tilde_S^(1-psi*epsilon_c) * varpi * ( PSI / ( (1 - betta_S*(1+i_d))*C_S^(-sigma) ) )^epsilon_c;
  m_cS = m_tilde_S^(1-psi*epsilon_c) * (1-varpi) * ( PSI / ( (1 - betta_S*(1+i))*C_S^(-sigma) ) )^epsilon_c;
  m = lambda_H*m_H + lambda_M*m_M + lambda_S*m_S;
  m_cB = omega*m;
  b_S = (1/i_f)*(C_S + I_S - r*K_S - i_d*m_S - i*m_cS - 1/lambda_S*(d_i + (i_n-i_f)*n - (i_d-omega*i-(1-omega)*i_f)*m));
  b = lambda_S*b_S;
  d_b = (i_n-i_f)*n - (i_d-omega*i-(1-omega)*i_f)*m - (i-i_f)*b;
  d = d_i + d_b;
  d_S = d/lambda_S;

  // Else Updates
  INC_H = w_H*L_H + i_d*m_H + i*m_cH + T_H;
  NW_H = m_H + m_cH;
  INC_M = w_M*L_M + i_d*m_M + i*m_cM + T_M;
  NW_M = s*H_M - n_M + m_M + m_cM;
  INC_S = i*b_S + r*K_S + d_S + i_d*m_S + i*m_cS;
  NW_S = q*K_S + s*H_S + b_S + m_S + m_cS;
  INC_TOT = 100*(lambda_H*INC_H + lambda_M*INC_M + lambda_S*INC_S);
  NW_TOT = 100*(lambda_H*NW_H + lambda_M*NW_M + lambda_S*NW_S);
  NWR = NW_S*100*lambda_S / NW_TOT; 
  U_H = (C_H^(1-sigma))/(1-sigma) + PSI*(m_tilde_H^(1-psi))/(1-psi) - chi_H*(L_H^(1+varphi))/(1+varphi);
  U_M = (C_M^(1-sigma))/(1-sigma) + PSI*(m_tilde_M^(1-psi))/(1-psi) + THETA*(H_M^(1-eta))/(1-eta) - chi_M*(L_M^(1+varphi))/(1+varphi);
  U_S = (C_S^(1-sigma))/(1-sigma) + PSI*(m_tilde_S^(1-psi))/(1-psi) + THETA*(H_S^(1-eta))/(1-eta);
  V_H = U_H/(1-betta_H); 
  V_M = U_M/(1-betta_M);
  V_S = U_S/(1-betta_S);
  W_TOT = lambda_H*V_H + lambda_M*V_M + lambda_S*V_S;
  GINI_I = ( lambda_H*lambda_M*(INC_M - INC_H)+lambda_S*lambda_H*(INC_S - INC_H)+lambda_S*lambda_M*(INC_S - INC_M) ) / (lambda_H*INC_H + lambda_M*INC_M + lambda_S*INC_S);
  GINI_W = ( lambda_H*lambda_M*(NW_M - NW_H)+lambda_S*lambda_H*(NW_S - NW_H)+lambda_S*lambda_M*(NW_S - NW_M) ) / (lambda_H*NW_H + lambda_M*NW_M + lambda_S*NW_S);
  i_cH = i;
  i_cM = i;
  i_cS = i;
  excess_m_H = 0;
  excess_m_M = 0;
  excess_m_S = 0;
end;
steady(solve_algo=4);




%--------------------------------------------------------------------------------
% Checks
%--------------------------------------------------------------------------------
//check;
//model_diagnostics;
//model_info;
//resid;
write_latex_original_model;
write_latex_dynamic_model;
write_latex_parameter_table;
write_latex_definitions;




%--------------------------------------------------------------------------------
% Perfect Foresight Simulation 
%--------------------------------------------------------------------------------

perfect_foresight_setup(periods=600);
perfect_foresight_solver(maxit=15);

// Author: Marcos Constantinou