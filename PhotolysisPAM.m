%Photolysis rates for using MCM with PAM chamber. Absorbtion cross section
%and quantum yield data taken from IUPAC Gas Kinetic Database and NASA JPL
%Evaluation No. 17.

function J = PhotolysisPAM(flux185, flux254, TEMP, O2, H2O, C)

J = zeros(56,1);

%Adjusting the fluxes for water vapor, oxygen and ozone absorption (Brune
%model)
% global ind_O3
% flux185 = flux185*exp(-7*(1.1e-20*O2+6.75e-20*H2O));	
% flux254 = flux254*exp(-7*(1.15e-17*C(ind_O3)));

%Photolysis rates calculated as sigma(lambda,T)*phi(lambda,T)*flux185 + 
%sigma(lambda,T)*phi(lambda,T)*flux254

%O3 -> O(1D) + O2
J(1) = 68.8E-20*0.9*flux185 + 1.13E-17*0.9*flux254;

%O3 -> O(3P) + O2
J(2) = 68.8E-20*0.1*flux185 + 1.13E-17*0.1*flux254;

%H2O2 -> OH + OH 
J(3) = 67.7E-20*0.85*flux185 + 6.7E-20*1*flux254;
%H2O2 -> H + HO2
J(43) = 67.7E-20*0.15*flux185;

%NO2 -> NO + O(3P)
J(4) = 1.09E-20*1*flux254;
%NO2 -> NO + O(1D)?

%NO3 -> NO + O2
J(5) = 0;

%NO3 -> NO2 + O(3P)
J(6) = 0;

%HONO -> NO + OH
J(7) = 9E-20*1*flux185 + 12.4E-20*1*flux254;
%HONO -> H + NO2 negiligible in 254nm range and minor production in 185nm 
%range but no values found. OH quantum yield assumed to be 1 in both cases

%HNO3 -> NO2 + OH
J(8) = 1.36e-17*0.33*flux185 + (1.95E-20 + exp(1.16E-3*(TEMP-298)))*1*flux254;
%HNO3 -> H + NO3 negligible.

%HNO3 -> HONO + O(3P)
J(44) = 1.36e-17*0.39*flux185;
%HNO3 -> HONO + O(1D)
J(45) = 1.28e-17*0.39*flux185;
%IUPAC and JPL mention unresolved conflict in data in oxygen quantum yields.

%HCHO -> H + HCO
J(11) = (0.456E-20 + 1.78E-24*(TEMP-298))*0.32*flux254;

%HCHO -> H2 + CO
J(12) = (0.456E-20 + 1.78E-24*(TEMP-298))*0.48*flux254;

%CH3CHO -> CH3 + HCO
J(13) = 1.524E-20*0.3*flux254;
%CH3CHO -> CH4 + CO
J(25) = 1.524E-20*0.46*flux254;
%CH3CHO -> CH3CO + H
J(26) = 1.524E-20*0.12*flux254;
%Probably minor contribution from 185nm range but no data available

%C2H5CHO -> C2H5 + HCO
J(14) = 1.745E-20*0.85*flux254;
%Values for 280nm. Not the only photolysis reaction for this compound but 
%the most important one. Data for other reactions not available.

%C3H7CHO -> n-C3H7 + HCO
J(15) = 1.45E-20*0.21*flux254;

%C3H7CHO -> C2H4 + CH3CHO
J(16) = 1.45E-20*0.1*flux254;

%IPRCHO -> n-C4H9 + HCO
J(17) = 12.23E-21*0.31*flux254;

%MACR -> CH2=CCH3 + HCO
J(18) = 0.178E-20*1.93E-3*flux254;

%MACR -> CH2=C(CH3)CO + H
J(19) = 0.178E-20*1.93E-3*flux254;

%C5HPALD1 -> CH3C(CHO)=CHCH2O + OH 
J(20) = 1.78E-21*1*flux254;

%CH3COCH3 -> CH3CO + CH3
J(21) = 1.91E-18*0.6*flux185 + ...
    (3.01E-20*(1+5.483E-3*TEMP+(-4.235E-5*TEMP^2)+(8.120E-8*TEMP^3)))*0.55*flux254;

%CH3COCH3 -> 2CH3 + CO
J(27) = 1.91E-18*0.4*flux185 + ...
    (3.01E-20*(1+5.483E-3*TEMP+(-4.235E-5*TEMP^2)+(8.120E-8*TEMP^3)))*0.45*flux254;

%MEK -> CH3CO + C2H5
J(22) = 1.31E-18*0.34*flux185 + 3.09E-20*0.16*flux254;

%MVK -> CH3CH=CH2 + CO
J(23) = 0.241E-20*0.346437*flux254;

%MVK -> CH3CO + CH2=CH
J(24) = 0.241E-20*0.346437*flux254;

%GLYOX -> CO + CO + H2
J(31) = 1.6E-20*0.395*flux254;

%GLYOX -> HCHO + CO
J(32) = 1.6E-20*0.334*flux254;

%GLYOX -> HCO + HCO
J(33) = 1.6E-20*0.271*flux254;

%MGLYOX -> CH3CO + HCO
J(34) = 2.859E-20*1*flux254;

%BIACET -> CH3CO + CH3CO
J(35) = 1.46E-18*0.16*flux185 + 3.73E-20*0.16*flux254;

%CH3OOH ->CH3O + OH
J(41) = 1e-18*1*flux185 + 3.23E-20*1*flux254;

%CH3NO3 ->CH3O + NO2
J(51) = 1.8E-17*0.7*flux185 + (3.3E-20+exp(2.68E-3*(TEMP-298)))*1*flux254;

%CH3NO3 -> CH3ONO + O(3P)
J(28) = 1.8E-17*0.3*flux185;

%C2H5NO3 -> C2H5O + NO2
J(52) = 1.71E-17*0.7*flux185 + (4.1E-20 + exp(2.6E-3*(TEMP-298)))*1*flux254;

%C2H5NO3 -> C2H5ONO + O(3P) 
J(29) = 1.71E-17*0.3*flux185;

%NC3H7NO3 -> n-C3H7O + NO2
J(53) = 1.81E-17*0.7*flux185 + 4.4E-20*1*flux254;

%NC3H7NO3 -> C3H7ONO + O(3P)
J(30) = 1.81E-17*0.7*flux185;

%IC3H7NO3  -> CH3C(O.)CH3 + NO2
J(54) = 1.71E-17*0.7*flux185 + (4.9E-20 + exp(2.5E-3*(TEMP-298)))*1*flux254;

%IC3H7NO3  -> i-C3H7ONO + O 
J(36) = 1.71E-17*0.7*flux185;

%TC4H9NO3  ->  t-C4H9O + NO2
J(55) = 5E-20*1*flux254;

%NOA
J(56) = 1.07E-19*0.9*flux254;

%O2 -> O(3P) + O(3P)
J(9) = 1.1e-20*1*flux185;

%H2O -> H + HO
J(10) = 6.78E-20*1*flux185;

%HO2 -> OH + O(3P)
J(37) = 3.68E-18*0.45*flux185 + 26.3E-20*1*flux254;

%HO2 -> OH + O(1D)
J(38) = 3.68E-18*0.55*flux185;

%HO2NO2 -> HO2 + NO2
J(39) = 1.01E-17*0.7*flux185 + 3.5E-19*0.8*flux254;

%HO2NO2 -> OH + NO3
J(40) = 1.01E-17*0.3*flux185 + 3.5E-19*0.2*flux254;

%N2O -> N2 + O(1D)
J(42) = 1.43E-19*1*flux185;

return