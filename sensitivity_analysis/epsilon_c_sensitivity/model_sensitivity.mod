
// Copy-paste baseline model file and just change the parameter block to the one here

%--------------------------------------------------------------------------------
% Variables
%--------------------------------------------------------------------------------

var 
  // 15 Household variables
  C_H      $C_\mathrm{H}$      (long_name='H Consumption')
  L_H      $L_\mathrm{H}$      (long_name='H Labour')
  m_H      $m_\mathrm{H}$      (long_name='H Bank Deposits')
  m_cH     $m^c_\mathrm{H}$    (long_name='H RFA Deposits')
  m_tilde_H $\widetilde{m}_\mathrm{H}$     (long_name='H Deposit Bundle')
  C_M      $C_\mathrm{M}$      (long_name='M Consumption')
  L_M      $L_\mathrm{M}$      (long_name='M Labour')
  H_M      $H_\mathrm{M}$      (long_name='M Housing')
  n_M      $n_\mathrm{M}$      (long_name='M Real Debt')
  C_S      $C_\mathrm{S}$      (long_name='S Consumption')
  H_S      $H_\mathrm{S}$      (long_name='S Housing')
  b_S      $b_\mathrm{S}$      (long_name='S Real Bonds')
  K_S      $K_\mathrm{S}$      (long_name='S Capital')
  I_S      $I_\mathrm{S}$      (long_name='S Investment')
  d_S      $d_\mathrm{S}$      (long_name='S Dividends')

  // 6 Aggregates
  C        $C$                 (long_name='Total Consumption')
  H        $H$                 (long_name='Total Housing')
  d        $d$                 (long_name='Total Profits')
  m        $m$                 (long_name='Total Deposits')
  n        $n$                 (long_name='Total Mortgages')
  b        $b$                 (long_name='Total Bonds')

  // 11 Private variables
  Y        $Y$                 (long_name='Total Output')
  K        $K$                 (long_name='Total Capital')
  I        $I$                 (long_name='Total Investment')
  L        $L$                 (long_name='Total Labour')
  mc       $mc$                (long_name='Real Marginal Cost')
  d_i      $d^i$               (long_name='Intermediate Good Firm Profits')
  d_k      $d^k$               (long_name='Capital Producer Firm Profits')
  d_b      $d^b$               (long_name='Private Bank Profits')
  DELTA    $\Delta$            (long_name='Price Dispersion')
  X_1      $X_1$               (long_name='Auxiliary Variable 1')
  X_2      $X_2$               (long_name='Auxiliary Variable 2')

  // 6 Public variables
  T_H      $T_\mathrm{H}$      (long_name='H Transfers')
  T_M      $T_\mathrm{M}$      (long_name='M Transfers')
  T_S      $T_\mathrm{S}$      (long_name='S Transfers')
  T        $T$                 (long_name='Total Transfers')
  f        $f$                 (long_name='Central Bank Lending')
  m_cB     $m^c_\mathrm{B}$    (long_name='Central Bank Reserves')

  // 15 Prices and rates
  p_tilde  $\tilde{p}$         (long_name='Reset Price')
  w        $w$                 (long_name='Real Wage')
  w_H      $w_\mathrm{H}$      (long_name='H Real Wage')
  w_M      $w_\mathrm{M}$      (long_name='M Real Wage')
  s        $s$                 (long_name='Real House Price')
  q        $q$                 (long_name='Tobins Q (shadow value of installed capital)')
  r        $r$                 (long_name='Real Rental Rate of Capital')
  i_d      $i^d$               (long_name='Interest on Private Deposits')
  i_m      $i^m$               (long_name='Interest on Mortgages')
  i        $i$                 (long_name='Policy Interest Rate')
  i_f      $i^f$               (long_name='Central Bank Lending Rate')
  pi_var   $\pi$               (long_name='Inflation')
  pi_w_H   $\pi^w_\mathrm{H}$  (long_name='H Wage Inflation')
  pi_w_M   $\pi^w_\mathrm{M}$  (long_name='M Wage Inflation')
  mu       $\mu$               (long_name='Borrowing Constraint Multiplier')

  // 2 Exogenous variables
  Z        $Z$                 (long_name='Technology')
  xi       $\xi$               (long_name='Discretionary Monetary Policy')

  // Measurement additions (not present in algebra)
  spread                       (long_name='Deposit Rate Spread') // check: problem is that the i should compare total avg rate in pre vs post RFA 
  U_H                          (long_name='H Period Utility')
  V_H                          (long_name='H Welfare')
  INC_H                        (long_name='H Income')      
  NW_H                         (long_name='H Net Wealth') 
  U_M                          (long_name='M Period Utility')
  V_M                          (long_name='M Welfare')
  INC_M                        (long_name='M Income')
  NW_M                         (long_name='M Net Wealth')
  U_S                          (long_name='S Period Utility')
  V_S                          (long_name='S Welfare')
  INC_S                        (long_name='S Income')
  NW_S                         (long_name='S Net Wealth')
  W_TOT                        (long_name='Total Welfare')
  INC_TOT                      (long_name='Total Income')
  NW_TOT                       (long_name='Total Net Wealth')
  NWR                          (long_name='Net Wealth Ratio')
  GINI_W                       (long_name='Gini Coefficient for Wealth')
  GINI_I                       (long_name='Gini Coefficient for Income')
  WR                           (long_name='Walras Residual')
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
  lambda_H  $\lambda_\mathrm{H}$    (long_name='H Population Share')
  lambda_M  $\lambda_\mathrm{M}$    (long_name='M Population Share')
  lambda_S  $\lambda_\mathrm{S}$    (long_name='S Population Share')
  betta_H   $\beta_\mathrm{H}$      (long_name='H Discount Factor')
  betta_M   $\beta_\mathrm{M}$      (long_name='M Discount Factor')
  betta_S   $\beta_\mathrm{S}$      (long_name='S Discount Factor')
  s_T       $s_T$                   (long_name='H Transfer Income Share')
  sigma     $\sigma$                (long_name='Elasticity of substitution for Goods')
  psi       $\psi$                  (long_name='Elasticity of substitution for Money')
  eta       $\eta$                  (long_name='Elasticity of substitution for Housing')
  varphi    $\varphi$               (long_name='Elasticity of substitution for Labour') 
  epsilon_c $\epsilon^c$            (long_name='Elasticity of Substitution between Deposit varieties')
  chi       $\chi$                  (long_name='Labour Disutility Parameter')  
  PSI       $\Psi$                  (long_name='Money Utility Parameter') 
  THETA_M   $\Theta_\mathrm{M}$     (long_name='M Housing Utility Parameter')
  THETA_S   $\Theta_\mathrm{S}$     (long_name='S Housing Utility Parameter')         
  delta     $\delta$                (long_name='Capital Depreciation Rate')
  kappa_y   $\kappa^y$              (long_name='Capital Adjustment Costs Parameter')
  epsilon_y $\epsilon^y$            (long_name='Elasticity of Substitution between Good varieties')
  kappa_w   $\kappa^w$              (long_name='Wage Adjustment Cost Parameter')
  epsilon_w $\epsilon_w$            (long_name='Elasticity of Substitution between Labour varieties')
  alpha_L   $\alpha_l$              (long_name='H Share in Labour Aggregator')
  Gamma     $\Gamma$                (long_name='LTV Ratio')
  alppha    $\alpha$                (long_name='Capital Share of Production')
  theta     $\theta$                (long_name='Proportion of Firms stuck with Sticky Prices')
  omega     $\omega$                (long_name='Reserve Requirement')
  kappa_m   $\kappa^m$              (long_name='Mortgage Rate Adjustment Costs')
  kappa_d   $\kappa^d$              (long_name='Deposit Rate Adjustment Costs') 
  epsilon_m $\epsilon^m$            (long_name='Elasticity of Substitution between Mortgage varieties')
  epsilon_d $\epsilon^d$            (long_name='Elasticity of Substitution between Deposit varieties')
  phi_pi    $\phi_\pi$              (long_name='Taylor Rule Inflation Reaction Parameter')
  phi_f     $\phi_f$                (long_name='Lending Rate Penalty')
  H_bar     $\bar{H}$               (long_name='Fixed Housing Quantity')
  i_bar     $\bar{i}$               (long_name='Steady-State Policy Rate')
  rho_z     $\rho_z$                (long_name='Technology Shock Persistence')
  rho_xi    $\rho_\xi$              (long_name='Monetary Policy Shock Persistence')
  rho_i     $\rho_i$                (long_name='Interest Rate Smoothing')
  sigma_z   $\sigma_z$              (long_name='Standard Deviation of Technological Shock')
  sigma_xi  $\sigma_\xi$            (long_name='Standard Deviation of Monetary Policy Shock')
;

%--------------------------------------------------------------------------------
% Calibration
%--------------------------------------------------------------------------------

//--------- Macro Parameter Definitions ---------//

@#ifndef theta_val
    @#define theta_val = 0.75
@#endif
@#ifndef Gamma_val
    @#define Gamma_val = 0.25
@#endif
@#ifndef lambda_H_val
    @#define lambda_H_val = 0.40
@#endif
@#ifndef betta_H_val
    @#define betta_H_val = 0.94
@#endif
@#ifndef lambda_M_val
    @#define lambda_M_val = 0.59
@#endif
@#ifndef betta_M_val
    @#define betta_M_val = 0.97
@#endif
@#ifndef lambda_S_val
    @#define lambda_S_val = 0.01
@#endif
@#ifndef betta_S_val
    @#define betta_S_val = 0.99
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
    @#define kappa_y_val = 3.00
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
@#ifndef chi_val
    @#define chi_val = 12.00
@#endif
@#ifndef epsilon_w_val
    @#define epsilon_w_val = 5.00
@#endif
@#ifndef PSI_val
    @#define PSI_val = 0.01
@#endif
@#ifndef alpha_L_val
    @#define alpha_L_val = 0.12
@#endif
@#ifndef epsilon_c_val
    @#define epsilon_c_val = 5.00
@#endif
@#ifndef THETA_M_val
    @#define THETA_M_val = 0.50
@#endif
@#ifndef alppha_val
    @#define alppha_val = 0.33
@#endif
@#ifndef THETA_S_val
    @#define THETA_S_val = 0.005
@#endif
@#ifndef H_bar_val
    @#define H_bar_val = 1.00
@#endif
@#ifndef s_T_val
    @#define s_T_val = 0.40
@#endif
@#ifndef omega_val
    @#define omega_val = 0.05
@#endif
@#ifndef kappa_m_val
    @#define kappa_m_val = 10
@#endif
@#ifndef kappa_d_val
    @#define kappa_d_val = 10
@#endif
@#ifndef epsilon_m_val
    @#define epsilon_m_val = 1.66
@#endif
@#ifndef epsilon_d_val
    @#define epsilon_d_val = -1
@#endif
@#ifndef phi_pi_val
    @#define phi_pi_val = 1.50
@#endif
@#ifndef phi_f_val
    @#define phi_f_val = 0.05
@#endif
@#ifndef rho_z_val
    @#define rho_z_val = 0.90
@#endif
@#ifndef rho_xi_val
    @#define rho_xi_val = 0.50
@#endif
@#ifndef rho_i_val
    @#define rho_i_val = 0.80
@#endif

//--------- Parameter Assignments ---------//

lambda_H   = @{lambda_H_val};    betta_H    = @{betta_H_val}; 
lambda_M   = @{lambda_M_val};    betta_M    = @{betta_M_val};  
lambda_S   = @{lambda_S_val};    betta_S    = @{betta_S_val};  

sigma      = @{sigma_val};       delta      = @{delta_val};
psi        = @{psi_val};         kappa_y    = @{kappa_y_val}; 
eta        = @{eta_val};         epsilon_y  = @{epsilon_y_val};  
varphi     = @{varphi_val};      kappa_w    = @{kappa_w_val}; 
chi        = @{chi_val};         epsilon_w  = @{epsilon_w_val};
PSI        = @{PSI_val};         alpha_L    = @{alpha_L_val}; // set to target SS labour  
epsilon_c  = @{epsilon_c_val};   Gamma      = @{Gamma_val}; 
THETA_M    = @{THETA_M_val};     alppha     = @{alppha_val}; 
THETA_S    = @{THETA_S_val};     H_bar      = @{H_bar_val}; 
s_T        = @{s_T_val};         theta      = @{theta_val};  

omega      = @{omega_val}; // check calibrations
kappa_m    = @{kappa_m_val};
kappa_d    = @{kappa_d_val};
epsilon_m  = @{epsilon_m_val};
epsilon_d  = @{epsilon_d_val};

i_bar      = 1/betta_S - 1; 
phi_pi     = @{phi_pi_val};  
phi_f      = @{phi_f_val};

rho_z      = @{rho_z_val}; 
rho_xi     = @{rho_xi_val}; 
rho_i      = @{rho_i_val};

sigma_z    = 0.01; 
sigma_xi   = 0.0025;  



%--------------------------------------------------------------------------------
% Model Block
%--------------------------------------------------------------------------------

model;

  // ---------- High-Constrained Agents ----------
  [name='1. H Budget Constraint']
  C_H + m_H + m_cH = w_H*L_H + (1+i_d(-1))/(1+pi_var)*m_H(-1) + (1+i(-1))/(1+pi_var)*m_cH(-1) + T_H;

  [name='2. H Wage Phillips Curve']
  kappa_w * pi_w_H * (1 + pi_w_H) = (1 - epsilon_w)*L_H 
    + epsilon_w * ( chi * (L_H^(1+varphi)) / (C_H^(-sigma)) ) / w_H 
    + betta_H * kappa_w * ( (C_H(+1)/C_H)^(-sigma) ) * pi_w_H(+1) * (1 + pi_w_H(+1))^2 / (1+pi_var(+1));

  [name='3. H Deposit Euler']
  C_H^(-sigma) =  PSI*m_tilde_H^(-psi) * (varpi*m_tilde_H/m_H)^(1/epsilon_c) + betta_H * ( ((C_H(+1))^(-sigma)) * (1+i_d)/(1+pi_var(+1)) );
  
  [name='4. H RFA Deposit Euler']
  C_H^(-sigma) =  PSI*m_tilde_H^(-psi) * ((1-varpi)*m_tilde_H/m_cH)^(1/epsilon_c) + betta_H * ( ((C_H(+1))^(-sigma)) * (1+i)/(1+pi_var(+1)) );

  [name='5. Deposit CES Bundle']
  m_tilde_H = ( varpi^(1/epsilon_c) * m_H^((epsilon_c-1)/epsilon_c) + (1-varpi)^(1/epsilon_c) * m_cH^((epsilon_c-1)/epsilon_c) )^(epsilon_c/(epsilon_c-1)); 
  
  // ---------- Middle-Income Agents (borrowing / housing) ----------
  [name='6. M Budget Constraint']
  C_M + s*H_M + (1+i_m(-1))/(1+pi_var)*n_M(-1) = w_M*L_M + s*H_M(-1) + n_M + T_M;

  [name='7. M Collateral Constraint (binds in baseline)' , mcp='mu > 0'] //check
  n_M = Gamma * s(+1)*(1+pi_var(+1)) * H_M / (1+i_m); 

  [name='8. M Wage Phillips Curve']
  kappa_w * pi_w_M * (1 + pi_w_M) = (1 - epsilon_w)*L_M 
    + epsilon_w * ( chi * (L_M^(1+varphi)) / (C_M^(-sigma)) ) / w_M 
    + betta_M * kappa_w * ( (C_M(+1)/C_M)^(-sigma) ) * pi_w_M(+1) * (1 + pi_w_M(+1))^2 / (1+pi_var(+1));
  
  [name='9. M Housing Euler']
  s * C_M^(-sigma) = THETA_M*H_M^(-eta) + betta_M * ( s(+1) * (C_M(+1))^(-sigma) ) + Gamma * mu * s(+1)*(1+pi_var(+1)) / (1+i_m);

  [name='10. M Mortgage Euler']
  C_M^(-sigma) = mu + betta_M * ( ((C_M(+1))^(-sigma)) * (1+i_m)/(1+pi_var(+1)) );

  // ---------- Rich (lender / capital owner) ----------
  [name='11. S Budget Constraint']
  C_S + s*H_S + q*I_S + b_S = r*K_S(-1) + d_S + (1+i(-1))/(1+pi_var)*b_S(-1) + s*H_S(-1) + T_S ;

  [name='12. S Capital Accumulation']
  K_S = (1-delta) * K_S(-1) + I_S ;

  [name='13. S Housing Euler']
  s * C_S^(-sigma) = THETA_S*H_S^(-eta) + betta_S * ( s(+1) * (C_S(+1))^(-sigma) );

  [name='14. S Capital Euler']
  q * (C_S^(-sigma)) = betta_S * ( ((C_S(+1))^(-sigma)) * ( r(+1) + (1-delta)*(q(+1)) ) );
 
  [name='15. S Bond Euler']
  C_S^(-sigma) = betta_S * ( ((C_S(+1))^(-sigma)) * (1+i)/(1+pi_var(+1)) );

  // ---------- Labour Unions ----------

  [name='16. H Wage Inflation']
  1 + pi_w_H = (w_H / w_H(-1)) * (1 + pi_var);

  [name='17. M Wage Inflation']
  1 + pi_w_M = (w_M / w_M(-1)) * (1 + pi_var);
  
  [name='18. H Labour Demand']
  lambda_H * w_H * L_H = alpha_L * w * L;

  [name='19. M Labour Demand']
  lambda_M * w_M * L_M = (1 - alpha_L) * w * L;

  // ---------- Production / pricing ----------
  [name='20. Aggregate Production']
  Y * DELTA = Z * ((K(-1))^alppha) * (L^ (1-alppha));
  
  [name='21. Marginal Cost']
  mc = 1/Z * (( w / (1-alppha) )^(1-alppha)) * ((r/alppha)^alppha);
  
  [name='22. Optimal Input Ratio']
  r / w = ( alppha / (1-alppha) ) * ( L / K(-1) );
  
  [name='23. Auxiliary Equation 1']
  X_1 = (C_S^(-sigma)) * Y * mc + theta * betta_S * ( ((1+pi_var(+1))^epsilon_y) * X_1(+1) ) ;
  
  [name='24. Auxiliary Equation 2']
  X_2 = (C_S^(-sigma)) * Y + theta * betta_S * ( ((1+pi_var(+1))^(epsilon_y-1)) * X_2(+1) ) ;
  
  [name='25. Optimal Pricing Rule']
  p_tilde = ( epsilon_y / (epsilon_y - 1) ) * ( X_1 / X_2 );
  
  [name='26. Aggregate Price Evolution']
  p_tilde = ( ( 1 - theta*((1+pi_var)^(epsilon_y-1)) ) / ( 1 - theta ) )^( 1 / (1-epsilon_y) );
  
  [name='27. Price Dispersion Evolution']
  DELTA = (1-theta) * ( (p_tilde)^(-epsilon_y) ) + theta * ( (1+pi_var)^epsilon_y ) * DELTA(-1);
  
  [name='28. Tobins Q']
  q = 1 + kappa_y*( I/(I(-1)) - 1 )*( I / (I(-1)) ) + (kappa_y/2)*(( I / (I(-1)) - 1 )^2) - 
    betta_S * ( ((C_S(+1))^(-sigma)) / (C_S^(-sigma)) * kappa_y * ( (I(+1))/I - 1 ) * ( (I(+1)) / I )^2);

  [name='29. Goods Producer Profits']
  d_i = Y - w*L - r*K(-1);

  [name='30. Capital Producer Profits']
  d_k = q*I - I*( 1 + (kappa_y/2) * (( I/(I(-1)) - 1 )^2) );
  
  // ---------- Banking ----------
  [name='31. Banks Balance Sheet']
  m_cB + n = f + m + b;

  [name='32. Banks Reserve Requirement']
  m_cB = omega*m ;

  [name='33. Banks Profit']  
  d_b = ((i_m(-1)-i_f(-1))/(1+pi_var))*n(-1) - ((i_d(-1)-omega*i(-1)-(1-omega)*i_f(-1))/(1+pi_var))*m(-1) - ((i(-1)-i_f(-1))/(1+pi_var))*b(-1) 
        - kappa_m/2*(( i_m/(i_m(-1)) -1 )^2)*i_m*n 
        - kappa_d/2*(( i_d/(i_d(-1)) -1 )^2)*i_d*m;
 
  [name='34. Mortgage Rate Setting']
  i_m = epsilon_m/(epsilon_m-1)*i_f - (1+i)*kappa_m/(epsilon_m-1)*
                      ( i_m/(i_m(-1)) -1 )*(i_m^2)/(i_m(-1))
            + (1+i)*(betta_S*(C_S(+1)^(-sigma))/(C_S^(-sigma))*kappa_m/(epsilon_m-1)*
                      ((i_m(+1))/i_m-1)*(i_m(+1)^2)/i_m*n(+1)/n);

  [name='35. Deposit Rate Setting']
  i_d = epsilon_d/(epsilon_d-1)*(omega*i+(1-omega)*i_f) + (1+i)*kappa_d/(epsilon_d-1)*     
                      ( i_d/(i_d(-1)) -1 )*(i_d^2)/(i_d(-1))
           - (1+i)*( betta_S*(C_S(+1)^(-sigma))/(C_S^(-sigma))*kappa_d/(epsilon_d-1)*
                      ((i_d(+1))/i_d-1)*(i_d(+1)^2)/i_d*m(+1)/m);

  [name='36. Total Profits']
  d = d_i + d_k + d_b;

  // ---------- Public Sector ----------
  [name='37. Government Budget Constraint']
  T = 0;

  [name='38. H Transfers'] //check ss command
  //T_H = (s_T / (1 - s_T)) * (w_H*L_H + i_d(-1)/(1+pi_var)*m_H(-1) + i(-1)/(1+pi_var)*m_cH(-1));   
  T_H = (s_T / (1 - s_T)) * (steady_state(w_H)*steady_state(L_H) + steady_state(i_d)*steady_state(m_H) + steady_state(i)*steady_state(m_cH));

  [name='39. M Transfers']
  T_M = 0;

  [name='40. Taylor Rule'] 
  log( (1+i) / (1+i_bar) ) = rho_i*log( (1+i(-1)) / (1+i_bar) ) + (1-rho_i)*phi_pi*log(1+pi_var) + xi; 

  [name='41. Central Bank Lending Rule']
  i_f = i + phi_f*f;

  [name='42. Central Bank Balance Sheet'] 
  f = lambda_H*m_cH + m_cB;

  // ---------- Aggregation / market clearing ----------
  [name='43. Aggregate Consumption']
  C = lambda_H*C_H + lambda_M*C_M + lambda_S*C_S;
  
  [name='44. Aggregate Labour']
  L = ((lambda_H*L_H)^alpha_L) * ((lambda_M*L_M)^(1-alpha_L));

  [name='45. Aggregate Deposits']
  m = lambda_H*m_H;

  [name='46. Aggregate Transfers']
  T = lambda_H*T_H + lambda_M*T_M + lambda_S*T_S;
  
  [name='47. Aggregate Housing']
  H = lambda_M*H_M + lambda_S*H_S;

  [name='48. Aggregate Mortgages']
  n = lambda_M*n_M;

  [name='49. Aggregate Investment']
  I = lambda_S*I_S;

  [name='50. Aggregate Capital']
  K = lambda_S*K_S;

  [name='51. Aggregate Bonds'] 
  b = lambda_S*b_S;

  [name='52. Aggregate Dividends']
  d = lambda_S*d_S;

  [name='53. Housing Market Clearing']
  H = H_bar;

  [name='Goods Market Clearing'] // checking that Walras Law holds
  WR = - Y + C + I + i_f*f - i*(m_cB+lambda_H*m_cH) + (kappa_y/2)*((I/(I(-1))-1)^2)*I
      + (kappa_m/2) * (( i_m/(i_m(-1)) - 1 )^2) * i_m * n 
      + (kappa_d/2) * (( i_d/(i_d(-1)) - 1 )^2) * i_d * m;

  // ---------- Shocks ----------
  [name='54. Technological Process']
  log(Z) = rho_z*log(Z(-1)) + varepsilon_z;
  
  [name='55. Monetary Policy Shock']
  xi = rho_xi*xi(-1) + varepsilon_xi;

  // ---------- Wealth & Income ----------

  [name='Interest Rate Spread']
  spread = i - i_d;

  [name='H Income']
  INC_H = w_H*L_H + i_d(-1)/(1+pi_var)*m_H(-1) + i(-1)/(1+pi_var)*m_cH(-1) + T_H;
  [name='H Net Wealth']
  NW_H = m_H + m_cH;

  [name='M Income']
  INC_M = w_M*L_M + T_M;
  [name='M Net Wealth']
  NW_M = s*H_M - n_M;

  [name='S Income']
  INC_S = i(-1)/(1+pi_var)*b_S(-1) + r*K_S(-1) + d_S + T_S;
  [name='S Net Wealth']
  NW_S = q*K_S + s*H_S + b_S;

  [name='Total Income'] // check if 100 needed
  INC_TOT = 100*(lambda_H*INC_H + lambda_M*INC_M + lambda_S*INC_S);
  [name='Total Net Wealth']
  NW_TOT = 100*(lambda_H*NW_H + lambda_M*NW_M + lambda_S*NW_S);
  [name='Net Wealth Ratio']
  NWR = NW_S*100*lambda_S / NW_TOT; 

  // ---------- Welfare ----------
  
  [name='H Period Utility']
  U_H = (C_H^(1-sigma))/(1-sigma) + PSI*(m_tilde_H^(1-psi))/(1-psi) - chi*(L_H^(1+varphi))/(1+varphi);
  [name='M Period Utility']
  U_M = (C_M^(1-sigma))/(1-sigma) + THETA_M*(H_M^(1-eta))/(1-eta) - chi*(L_M^(1+varphi))/(1+varphi);
  [name='S Period Utility']
  U_S = (C_S^(1-sigma))/(1-sigma) + THETA_S*(H_S^(1-eta))/(1-eta);

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

end;



%--------------------------------------------------------------------------------
% Initial Steady-State
%--------------------------------------------------------------------------------

initval;
  // Frictions and Shocks 
  varpi = 0.9999;
  pi_var = 0;
  pi_w_H = 0;
  pi_w_M = 0;
  p_tilde = 1;
  DELTA = 1;
  q = 1;
  Z = 1;
  xi = 0;

  // Analytically Solvable
  d_k = 0;
  T = 0;
  T_M = 0;
  i = i_bar;
  H = H_bar;
  r = 1/betta_S - 1 + delta;
  mc = (epsilon_y-1)/epsilon_y;
  w = (1-alppha)*( mc*(r/alppha)^(-alppha) )^(1/(1-alppha));

  // Guesses
  L_H = 0.23;
  L_M = 0.35;
  H_S = H; 
  f = 0.02;

  // Rates
  i_f = i + phi_f*f;
  i_d = epsilon_d/(epsilon_d-1)*(omega*i+(1-omega)*i_f);
  i_m = epsilon_m/(epsilon_m-1)*i_f; 
  spread = i - i_d;

  // H 
  L = ((lambda_H*L_H)^alpha_L) * ((lambda_M*L_M)^(1-alpha_L));
  w_H = alpha_L * w * L / (lambda_H * L_H);
  w_M = (1 - alpha_L) * w * L / (lambda_M * L_M);
  C_H = ( (w_H * (epsilon_w-1)/epsilon_w) / (chi * L_H^varphi) )^(1/sigma);
  m_tilde_H = ( varpi * ( PSI / ( (1 - betta_H*(1+i_d))*C_H^(-sigma) ) )^(epsilon_c-1) + (1-varpi) * ( PSI / ( (1 - betta_H*(1+i))*C_H^(-sigma) ) )^(epsilon_c-1) )^(1/(psi*(epsilon_c-1)));
  m_H = m_tilde_H^(1-psi*epsilon_c) * varpi * ( PSI / ( (1 - betta_H*(1+i_d))*C_H^(-sigma) ) )^epsilon_c;
  m_cH = m_tilde_H^(1-psi*epsilon_c) * (1-varpi) * ( PSI / ( (1 - betta_H*(1+i))*C_H^(-sigma) ) )^epsilon_c; 
  m = lambda_H*m_H;
  T_H = (s_T / (1 - s_T)) * (w_H*L_H + i_d*m_H + i*m_cH);
  
  // M
  H_M = (H - lambda_S*H_S)/lambda_M; 
  C_M = ( (w_M * (epsilon_w-1)/epsilon_w) / (chi * L_M^varphi) )^(1/sigma);
  n_M = 1/i_m * (w_M*L_M + T_M - C_M);
  n = lambda_M*n_M;
  s = n_M/(Gamma*H_M) * (1+i_m);
  mu = (1-betta_M*(1+i_m))*(C_M^(-sigma));

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
  T_S = -lambda_H/lambda_S*T_H;
  b_S = 1/(1-i+i_f)*(C_S + I_S - r*K_S - T_S - 1/lambda_S*(d_i + (i_m-i_f)*n - (i_d-omega*i-(1-omega)*i_f)*m));
  b = lambda_S*b_S;
  d_b = (i_m-i_f)*n - (i_d-omega*i-(1-omega)*i_f)*m - (i-i_f)*b;
  d = d_i + d_b;
  d_S = d/lambda_S;

  // CB
  m_cB = omega*m;
 
  // Else
  INC_H = w_H*L_H + i_d*m_H + i*m_cH + T_H;
  NW_H = m_H + m_cH;
  INC_M = w_M*L_M + T_M;
  NW_M = s*H_M - n_M;
  INC_S = i*b_S + r*K_S + d_S + T_S;
  NW_S = q*K_S + s*H_S + b_S;
  INC_TOT = 100*(lambda_H*INC_H + lambda_M*INC_M + lambda_S*INC_S);
  NW_TOT = 100*(lambda_H*NW_H + lambda_M*NW_M + lambda_S*NW_S);
  NWR = NW_S*100*lambda_S / NW_TOT; 
  U_H = (C_H^(1-sigma))/(1-sigma) + PSI*(m_tilde_H^(1-psi))/(1-psi) - chi*(L_H^(1+varphi))/(1+varphi);
  U_M = (C_M^(1-sigma))/(1-sigma) + THETA_M*(H_M^(1-eta))/(1-eta) - chi*(L_M^(1+varphi))/(1+varphi);
  U_S = (C_S^(1-sigma))/(1-sigma) + THETA_S*(H_S^(1-eta))/(1-eta);
  V_H = U_H/(1-betta_H); 
  V_M = U_M/(1-betta_M);
  V_S = U_S/(1-betta_S);
  W_TOT = lambda_H*V_H + lambda_M*V_M + lambda_S*V_S;
  GINI_I = ( lambda_H*lambda_M*(INC_M - INC_H)+lambda_S*lambda_H*(INC_S - INC_H)+lambda_S*lambda_M*(INC_S - INC_M) ) / (lambda_H*INC_H + lambda_M*INC_M + lambda_S*INC_S);
  GINI_W = ( lambda_H*lambda_M*(NW_M - NW_H)+lambda_S*lambda_H*(NW_S - NW_H)+lambda_S*lambda_M*(NW_S - NW_M) ) / (lambda_H*NW_H + lambda_M*NW_M + lambda_S*NW_S);
end;
steady(solve_algo=4);


%--------------------------------------------------------------------------------
% End Steady-State
%--------------------------------------------------------------------------------

endval;
    // Frictions and Shocks 
  varpi = 0.5;
  pi_var = 0;
  pi_w_H = 0;
  pi_w_M = 0;
  p_tilde = 1;
  DELTA = 1;
  q = 1;
  Z = 1;
  xi = 0;

  // Analytically Solvable
  d_k = 0;
  T = 0;
  T_M = 0;
  i = i_bar;
  H = H_bar;
  r = 1/betta_S - 1 + delta;
  mc = (epsilon_y-1)/epsilon_y;
  w = (1-alppha)*( mc*(r/alppha)^(-alppha) )^(1/(1-alppha));

  // Guesses
  L_H = 0.23;
  L_M = 0.35;
  H_S = H; 
  f = 0.02;

  // Rates
  i_f = i + phi_f*f;
  i_d = epsilon_d/(epsilon_d-1)*(omega*i+(1-omega)*i_f);
  i_m = epsilon_m/(epsilon_m-1)*i_f; 
  spread = i - i_d;

  // H 
  L = ((lambda_H*L_H)^alpha_L) * ((lambda_M*L_M)^(1-alpha_L));
  w_H = alpha_L * w * L / (lambda_H * L_H);
  w_M = (1 - alpha_L) * w * L / (lambda_M * L_M);
  C_H = ( (w_H * (epsilon_w-1)/epsilon_w) / (chi * L_H^varphi) )^(1/sigma);
  m_tilde_H = ( varpi * ( PSI / ( (1 - betta_H*(1+i_d))*C_H^(-sigma) ) )^(epsilon_c-1) + (1-varpi) * ( PSI / ( (1 - betta_H*(1+i))*C_H^(-sigma) ) )^(epsilon_c-1) )^(1/(psi*(epsilon_c-1)));
  m_H = m_tilde_H^(1-psi*epsilon_c) * varpi * ( PSI / ( (1 - betta_H*(1+i_d))*C_H^(-sigma) ) )^epsilon_c;
  m_cH = m_tilde_H^(1-psi*epsilon_c) * (1-varpi) * ( PSI / ( (1 - betta_H*(1+i))*C_H^(-sigma) ) )^epsilon_c; 
  m = lambda_H*m_H;
  T_H = (s_T / (1 - s_T)) * (w_H*L_H + i_d*m_H + i*m_cH);
  
  // M
  H_M = (H - lambda_S*H_S)/lambda_M; 
  C_M = ( (w_M * (epsilon_w-1)/epsilon_w) / (chi * L_M^varphi) )^(1/sigma);
  n_M = 1/i_m * (w_M*L_M + T_M - C_M);
  n = lambda_M*n_M;
  s = n_M/(Gamma*H_M) * (1+i_m);
  mu = (1-betta_M*(1+i_m))*(C_M^(-sigma));

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
  T_S = -lambda_H/lambda_S*T_H;
  b_S = 1/(1-i+i_f)*(C_S + I_S - r*K_S - T_S - 1/lambda_S*(d_i + (i_m-i_f)*n - (i_d-omega*i-(1-omega)*i_f)*m));
  b = lambda_S*b_S;
  d_b = (i_m-i_f)*n - (i_d-omega*i-(1-omega)*i_f)*m - (i-i_f)*b;
  d = d_i + d_b;
  d_S = d/lambda_S;

  // CB
  m_cB = omega*m;
 
  // Else
  INC_H = w_H*L_H + i_d*m_H + i*m_cH + T_H;
  NW_H = m_H + m_cH;
  INC_M = w_M*L_M + T_M;
  NW_M = s*H_M - n_M;
  INC_S = i*b_S + r*K_S + d_S + T_S;
  NW_S = q*K_S + s*H_S + b_S;
  INC_TOT = 100*(lambda_H*INC_H + lambda_M*INC_M + lambda_S*INC_S);
  NW_TOT = 100*(lambda_H*NW_H + lambda_M*NW_M + lambda_S*NW_S);
  NWR = NW_S*100*lambda_S / NW_TOT; 
  U_H = (C_H^(1-sigma))/(1-sigma) + PSI*(m_tilde_H^(1-psi))/(1-psi) - chi*(L_H^(1+varphi))/(1+varphi);
  U_M = (C_M^(1-sigma))/(1-sigma) + THETA_M*(H_M^(1-eta))/(1-eta) - chi*(L_M^(1+varphi))/(1+varphi);
  U_S = (C_S^(1-sigma))/(1-sigma) + THETA_S*(H_S^(1-eta))/(1-eta);
  V_H = U_H/(1-betta_H); 
  V_M = U_M/(1-betta_M);
  V_S = U_S/(1-betta_S);
  W_TOT = lambda_H*V_H + lambda_M*V_M + lambda_S*V_S;
  GINI_I = ( lambda_H*lambda_M*(INC_M - INC_H)+lambda_S*lambda_H*(INC_S - INC_H)+lambda_S*lambda_M*(INC_S - INC_M) ) / (lambda_H*INC_H + lambda_M*INC_M + lambda_S*INC_S);
  GINI_W = ( lambda_H*lambda_M*(NW_M - NW_H)+lambda_S*lambda_H*(NW_S - NW_H)+lambda_S*lambda_M*(NW_S - NW_M) ) / (lambda_H*NW_H + lambda_M*NW_M + lambda_S*NW_S);
end;
steady(solve_algo=4);




%--------------------------------------------------------------------------------
% Checks
%--------------------------------------------------------------------------------
check;
model_diagnostics;
model_info;
resid;
write_latex_original_model;
write_latex_dynamic_model;
write_latex_parameter_table;
write_latex_definitions;



%--------------------------------------------------------------------------------
% Perfect Foresight Simulation 
%--------------------------------------------------------------------------------

perfect_foresight_setup(periods=100);
perfect_foresight_solver(maxit=15);

// check: add lmmcp if want to use the mcp constraint for the borrowing constraint





