
% Wrapper for calling the ODE function routine
% in a format required by Matlab's ODE integrators

function P = KPP_ROOT_Fun_Chem(T, Y) 
     
  global TIME FIX RCONST C NVAR NFIX NSPEC 
 
  Told = TIME;
  TIME = T;
  KPP_ROOT_Update_SUN;
  KPP_ROOT_Update_RCONST;
  
%  This line calls the Matlab ODE function routine  
  P = KPP_ROOT_Fun( Y, FIX, RCONST );
  
%  To call the mex routine instead, comment the line above and uncomment the following line:
%  P = KPP_ROOT_mex_Fun( Y, FIX, RCONST );

%  Lines to update the peroxy radical sum needed by the Master Chemical Mechanism during the integration, OK.
  C(1:KPP_NVAR) = Y(1:KPP_NVAR); 
  C((NVAR+1):NSPEC) = FIX(1:NFIX);

  TIME = Told;

return
