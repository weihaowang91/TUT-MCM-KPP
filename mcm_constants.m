
%***************************************************************************

function mcm_constants(temp, m, h2o)

persistent b c d dy i jl lat2 lk n theta time2 tmp tmp2 x y ; 

% calculates rate constants from arrhenius informtion
if isempty(theta), theta=0; end;
if isempty(time2), time2=0; end;
if isempty(lat2), lat2=0; end;
if isempty(y), y=0; end;
if isempty(dy), dy=0; end;
if isempty(x), x=0; end;
if isempty(tmp), tmp=zeros(1,19); end;
if isempty(tmp2), tmp2=zeros(1,19); end;
if isempty(b), b=zeros(1,19); end;
if isempty(c), c=zeros(1,19); end;
if isempty(d), d=zeros(1,19); end;
if isempty(i), i=0; end;
if isempty(n), n=0; end;
if isempty(jl), jl=0; end;
if isempty(lk), lk=0; end;


% ************************************************************************
% define generic reaction rates.
% ************************************************************************

% constants used in calculation of reaction rates
%M  = 2.55E+19;
global N2 O2
N2 = 0.79*m;
O2 = 0.2095*m;

%Figure out what these do
%kp_rooh = dep_rooh;
%kp_ho2  = dep_ho2;
%kp_n2o5 = dep_n2o5;
%kp_no3  = dep_no3;
%kp_all  = dep_all;

global KRO2NO KRO2HO2 KAPHO2 KAPNO KRO2NO3 KNO3AL KDEC KCH3O2 K298CH3O2

% kro2no : ro2      + no      = ro      + no2
%        : ro2      + no      = rono2
% mcm v3.2
KRO2NO    = 2.7E-12*exp(360.0/temp);

% kro2ho2: ro2      + ho2     = rooh    + o2
% mcm protocol v3.2
KRO2HO2   = 2.91E-13*exp(1300.0/temp);

% kapho2 : rcoo2    + ho2     = products
% mcm protocol v3.2
KAPHO2    = 5.20E-13*exp(980.0/temp);

% kapno  : rcoo2    + no      = products
% mcm v3.2
KAPNO = 7.50E-12*exp(290.0/temp);

% kro2no3: ro2      + no3     = products
% mcm protocol v3.2
KRO2NO3   = 2.30E-12;

% kno3al : no3      + rcho    = rcoo2   + hno3
% mcm protocol v3.2
KNO3AL    = 1.4E-12*exp(-1860.0/temp);

% kdec   : ro                 = products
% mcm protocol v3.2
KDEC      = 1.00E+06;

%kalkoxy=6.00E-14.*exp(-550.0./temp).*O2;
%kalkpxy=1.50E-14.*exp(-200.0./temp).*O2;

KCH3O2 = 1.03E-13*exp(365.0/temp);
K298CH3O2 = 3.5E-13;

% -------------------------------------------------------------------
% complex reactions
% -------------------------------------------------------------------

% kfpan kbpan
% formation and decomposition of pan
% iupac 2001 (mcmv3.2)

global KMT01 KMT02 KMT03 KMT04 KMT05 KMT06 KMT07 KMT08 KMT09 KMT10 KMT11 KMT12 KMT13 KMT14 KMT15 KMT16 KMT17 KMT18 KFPAN KBPAN KROPRIM KROSEC KPPN0 KPPNI KRPPN FCPPN NCPPN FPPN KBPPN

kc0     = 2.70E-28.*m.*(temp./300.0).^(-7.1);
kci     = 1.21E-11.*(temp./300.0).^(-0.9);
krc     = kc0./kci;
fcc     = 0.30;
nc      = 0.75-(1.27.*log10(fcc));
fc      = 10.^(log10(fcc)./(1+((log10(krc))./nc).^2));
KFPAN   =(kc0.*kci).*fc./(kc0+kci);

kd0     = 4.90E-03.*m.*exp(-12100.0./temp);
kdi     = 5.40E+16.*exp(-13830.0./temp);
krd     = kd0./kdi;
fcd     = 0.30;
ncd     = 0.75-(1.27.*log10(fcd));
fd      = 10.^(log10(fcd)./(1+((log10(krd))./ncd).^2));
KBPAN   =(kd0.*kdi).*fd./(kd0+kdi);

% KMT01  : o        + no      = no2
% iupac 2001 (mcmv3.2)
k10     = 1.00E-31.*m.*(temp./300.0).^(-1.6);

k1i     = 3.00E-11.*(temp./300.0).^(0.3);
kr1     = k10./k1i;
fc1     = 0.85;
nc1     = 0.75-(1.27.*log10(fc1));
f1      = 10.^(log10(fc1)./(1+((log10(kr1)./nc1)).^2));
KMT01   =(k10.*k1i).*f1./(k10+k1i);

% KMT02  : o        + no2     = no3
% iupac 2001 (mcmv3.2)
k20     = 1.30E-31.*m.*(temp./300.0).^(-1.5);
k2i     = 2.30E-11.*(temp./300.0).^(0.24);
kr2     = k20./k2i;
fc2     = 0.6;
nc2     = 0.75-(1.27.*log10(fc2));
f2      = 10.^(log10(fc2)./(1+((log10(kr2)./nc2)).^2));
KMT02   =(k20.*k2i).*f2./(k20+k2i);

% KMT03  : no2      + no3     = n2o5
% iupac 2006, mcmv3.2
k30     = 3.60E-30.*m.*(temp./300.0).^(-4.1);
k3i     = 1.90E-12.*(temp./300.0).^(0.2);
kr3     = k30./k3i;
fc3     = 0.35;
nc3     = 0.75-(1.27.*log10(fc3));
f3      = 10.^(log10(fc3)./(1+((log10(kr3)./nc3)).^2));
KMT03   =(k30.*k3i).*f3./(k30+k3i);

% KMT04  : n2o5               = no2     + no3
% iupac 2006, mcmv3.2
k40     = 1.30E-03.*m.*(temp./300.0).^(-3.5).*exp(-11000.0./temp);
k4i     = 9.70E+14.*(temp./300.0).^(0.1).*exp(-11080.0./temp);
kr4     = k40./k4i;
fc4     = 0.35;
nc4     = 0.75-(1.27.*log10(fc4));
f4      = 10.^(log10(fc4)./(1+((log10(kr4)./nc4)).^2));
KMT04   =(k40.*k4i).*f4./(k40+k4i);

% KMT05  : oh       + co(+o2) = ho2     + co2
% iupac 2006
KMT05  =(1 +(m./4.2E19));

% KMT06  : ho2      + ho2     = h2o2    + o2
% water enhancement factor
% iupac 1992

KMT06  = 1 +(1.40E-21.*exp(2200.0./temp).*h2o);

% KMT06  = 1 + (2.00E-25*EXP(4670.0/temp)*h2o)
% S+R 2005 values

% KMT07  : oh       + no      = hono

% iupac 2006, mcmv3.2
k70     = 7.40E-31.*m.*(temp./300.0).^(-2.4);
k7i     = 3.30E-11.*(temp./300.0).^(-0.3);
kr7     = k70./k7i;
fc7     = exp(-temp./1420.0);
nc7     = 0.75-(1.27.*log10(fc7));
f7      = 10.^(log10(fc7)./(1+((log10(kr7)./nc7)).^2));
KMT07   =(k70.*k7i).*f7./(k70+k7i);

% KMT08  : oh       + no2     = hno3

% iupac 2006, mcmv3.2
k80     = 3.30E-30.*m.*(temp./300.0).^(-3.0);
k8i     = 4.10E-11;
kr8     = k80./k8i;
fc8     = 0.4;
nc8     = 0.75-(1.27.*log10(fc8));
f8      = 10.^(log10(fc8)./(1+((log10(kr8)./nc8)).^2));
KMT08   =(k80.*k8i).*f8./(k80+k8i);

% KMT09  : ho2      + no2     = ho2no2
% iupac 1997, mcmv3.2

k90     = 1.80E-31.*m.*(temp./300.0).^(-3.2);
k9i     = 4.70E-12;
kr9     = k90./k9i;
fc9     = 0.6;
nc9     = 0.75-(1.27.*log10(fc9));
f9      = 10.^(log10(fc9)./(1+((log10(kr9)./nc9)).^2));
KMT09   =(k90.*k9i).*f9./(k90+k9i);

% KMT10  : ho2no2             = ho2     + no2
% iupac 1997, mcmv3.2

k100     = 4.10E-05.*m.*exp(-10650.0./temp);
k10i     = 4.80E+15.*exp(-11170.0./temp);
kr10     = k100./k10i;
fc10     = 0.6;
nc10     = 0.75-(1.27.*log10(fc10));
f10      = 10.^(log10(fc10)./(1+((log10(kr10)./nc10)).^2));
KMT10    =(k100.*k10i).*f10./(k100+k10i);

% KMT11  : oh       + hno3    = h2o     + no3
% iupac 2006, mcmv3.2

k1     = 2.40E-14.*exp(460.0./temp);
k3     = 6.50E-34.*exp(1335.0./temp);
k4     = 2.70E-17.*exp(2199.0./temp);
k2     =(k3.*m)./(1+(k3.*m./k4));
KMT11  = k1 + k2;

% KMT12 iupac 2006, mcmv3.2

k120 = 4.50E-31.*((temp./300.0).^(-3.9)).*m;
k12i = 1.30E-12.*((temp./300.0).^(-0.7));
kr12 = k120./k12i;
fc12 = 0.525;
nc12 = 0.75-(1.27.*log10(fc12));
f12  = 10.^(log10(fc12)./(1.+((log10(kr12)./nc12)).^2));
KMT12    =(k120.*k12i).*f12./(k120+k12i);

% KMT13  : ch3o2    + no2     = ch3o2no2
% iupac 2006

k130     = 2.50E-30.*((temp./300.0).^(-5.5)).*m;
k13i     = 1.80E-11;
kr13     = k130./k13i;
fc13     = 0.36;
nc13     = 0.75-(1.27.*log10(fc13));
f13      = 10.^(log10(fc13)./(1+((log10(kr13)./nc13)).^2));
KMT13    =(k130.*k13i).*f13./(k130+k13i);

% KMT14  : ch3o2no2           = ch3o2   + no2
% iupac 2006, mcmv3.2

k140     = 9.00E-05.*exp(-9690.0./temp).*m;
k14i     = 1.10E+16.*exp(-10560.0./temp);
kr14     = k140./k14i;
fc14     = 0.4;
nc14     = 0.75-(1.27.*log10(fc14));
f14      = 10.^(log10(fc14)./(1+((log10(kr14)./nc14)).^2));
KMT14    =(k140.*k14i).*f14./(k140+k14i);

% KMT15 iupac 2006, mcmv3.2

k150 = 8.60E-29.*((temp./300.0).^(-3.1)).*m;
k15i = 9.00E-12.*((temp./300.0).^(-0.85));
kr15 = k150./k15i;
fc15 = 0.48;
nc15 = 0.75-(1.27.*log10(fc15));
f15  = 10.^(log10(fc15)./(1+((log10(kr15)./nc15)).^2));
KMT15 =(k150.*k15i).*f15./(k150+k15i);

% KMT16  :  oh  +  c3h6
% iupac 2006

k160     = 8.00E-27.*((temp./300.0).^(-3.5)).*m;
k16i     = 3.00E-11.*((temp./300.0).^(-1.0));
kr16     = k160./k16i;
fc16     = 0.5;
nc16     = 0.75-(1.27.*log10(fc16));
f16      = 10.^(log10(fc16)./(1+((log10(kr16)./nc16)).^2));
KMT16    =(k160.*k16i).*f16./(k160+k16i);

% KMT17 iupac 2006

k170 = 5.00E-30.*((temp./300.0).^(-1.5)).*m;
k17i = 1.00E-12;
kr17 = k170./k17i;
fc17 =(0.17.*exp(-51../temp))+exp(-temp./204.);
nc17 = 0.75-(1.27.*log10(fc17));
f17  = 10.^(log10(fc17)./(1+((log10(kr17)./nc17)).^2));
KMT17 =(k170.*k17i).*f17./(k170+k17i);

% KMT18 2011 oh + dms

KMT18=(9.5E-39*O2*exp(5270./temp))/(1+7.5E-29*O2*exp(5610./temp));

%       mcm v3.2

KROPRIM  = 2.50E-14*exp(-300.0/temp);
KROSEC   = 2.50E-14*exp(-300.0/temp);

KPPN0 = 1.7E-03*exp(-11280/temp)*m;
KPPNI = 8.3E+16*exp(-13940/temp);
KRPPN = KPPN0/KPPNI;
FCPPN = 0.36;
NCPPN = 0.75-1.27*(log10(FCPPN));
FPPN = 10^(log10(FCPPN)/(1+(log10(KRPPN)/NCPPN)^2));
KBPPN = (KPPN0*KPPNI)*FCPPN/(KPPN0+KPPNI);

return %subroutine mcm_constants

%***************************************************************************






%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% extra functions as needed by the translation %%%%%%%%%%%

