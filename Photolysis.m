%Function from calculating the photolysis rates used in MCM
function J = Photolysis(date, TIME, lambda, phi)

%global J

%Calculating the solar zenit angle (Seinfeld & Pandis)
GMT = TIME/3600;
d = daysact(strcat('01-jan-',date(8:11)),date);
B = (360/365)*(d-81);
EoT = (9.87*sind(2*B)-7.53*cosd(B)-1.5*sind(B))/60;
TST = GMT + (4*lambda/60) + EoT;
H = 15*(12-TST);

delta=-0.4*cos(2*pi*((d+10)/365));

theta = acosd(sind(phi)*sin(delta)+cosd(phi)*cos(delta)*cosd(H));
if (theta > 90) || (theta < -90)
    theta = 89.999;
end

l = [6.073E-05 4.775E-04 1.041E-05 1.165E-02 2.485E-02 1.747E-01 2.644E-03...
    9.312E-07 0 0 4.642E-05 6.853E-05 7.344E-06 2.879E-05 2.792E-05 1.675E-05...
    7.914E-05 1.482E-06 1.482E-06 7.600E-04 7.992E-07 5.804E-06 2.4246E-06...
    2.424E-06 0 0 0 0 0 0 6.845E-05 1.032E-05 3.802E-05 1.537E-04 3.326E-04... 
    0 0 0 0 0 7.649E-06 0 0 0 0 0 0 0 0 0 1.588E-06 1.907E-06 2.485E-06...
    4.095E-06 1.135E-05 4.365E-05 0 0 0 0 7.537E-04];

m = [1.743 0.298 0.723 0.244 0.168 0.155 0.261 1.230 0 0 0.762 0.477 1.202 ...
    1.067 0.805 0.805 0.764 0.396 0.396 0.396 1.578 1.092 0.395 0.395 0 0 ...
    0 0 0 0 0.130 0.130 0.644 0.170 0.148 0 0 0 0 0 0.682 0 0 0 0 0 0 0 0 0 ...
    1.154 1.244 1.196 1.111 0.974 1.089 0 0 0 0 0.499];

n = [0.474 0.080 0.279 0.267 0.108 0.125 0.288 0.307 0 0 0.353 0.323 0.417...
    0.358 0.338 0.338 0.364 0.298 0.298 0.298 0.271 0.377 0.296 0.296 0 0 ...
    0 0 0 0 0.201 0.201 0.312 0.208 0.215 0 0 0 0 0 0.279 0 0 0 0 0 0 0 0 ...
    0 0.318 0.335 0.328 0.316 0.309 0.323 0 0 0 0 0.266];

abstheta = abs(theta);
J = l.*(cosd(abstheta).^m).*exp(-n.*secd(abstheta));
return


%J1 = l(1).*(cosd(chi).^m(1)).*exp(-n(1).*sec(chi));
%J2 = l(2).*(cosd(chi).^m(2)).*exp(-n(2).*sec(chi));
%J3 = l(3).*(cosd(chi).^m(3)).*exp(-n(3).*sec(chi));
% J4 = l(4).*(cosd(chi).^m(4)).*exp(-n(4).*sec(chi));
% J5 = l(5).*(cosd(chi).^m(5)).*exp(-n(5).*sec(chi));
% J6 = l(6).*(cosd(chi).^m(6)).*exp(-n(6).*sec(chi));
% J7 = l(7).*(cosd(chi).^m(7)).*exp(-n(7).*sec(chi));
% J8 = l(8).*(cosd(chi).^m(8)).*exp(-n(8).*sec(chi));
% J11 = l(9).*(cosd(chi).^m(9)).*exp(-n(9).*sec(chi));
% J12 = l(10).*(cosd(chi).^m(10)).*exp(-n(10).*sec(chi));
% J13 = l(11).*(cosd(chi).^m(11)).*exp(-n(11).*sec(chi));
% J14 = l(12).*(cosd(chi).^m(12)).*exp(-n(12).*sec(chi));
% J15 = l(13).*(cosd(chi).^m(13)).*exp(-n(13).*sec(chi));
% J16 = l(14).*(cosd(chi).^m(14)).*exp(-n(14).*sec(chi));
% J17 = l(15).*(cosd(chi).^m(15)).*exp(-n(15).*sec(chi));
% J18 = l(16).*(cosd(chi).^m(16)).*exp(-n(16).*sec(chi));
% J19 = l(17).*(cosd(chi).^m(17)).*exp(-n(17).*sec(chi));
% J20 = l(18).*(cosd(chi).^m(18)).*exp(-n(18).*sec(chi));
% J21 = l(19).*(cosd(chi).^m(19)).*exp(-n(19).*sec(chi));
% J22 = l(20).*(cosd(chi).^m(20)).*exp(-n(20).*sec(chi));
% J23 = l(21).*(cosd(chi).^m(21)).*exp(-n(21).*sec(chi));
% J24 = l(22).*(cosd(chi).^m(22)).*exp(-n(22).*sec(chi));
% J31 = l(23).*(cosd(chi).^m(23)).*exp(-n(23).*sec(chi));
% J32 = l(24).*(cosd(chi).^m(24)).*exp(-n(24).*sec(chi));
% J33 = l(25).*(cosd(chi).^m(25)).*exp(-n(25).*sec(chi));
% J34 = l(26).*(cosd(chi).^m(26)).*exp(-n(26).*sec(chi));
% J35 = l(27).*(cosd(chi).^m(27)).*exp(-n(27).*sec(chi));
% J41 = l(28).*(cosd(chi).^m(28)).*exp(-n(28).*sec(chi));
% J51 = l(29).*(cosd(chi).^m(29)).*exp(-n(29).*sec(chi));
% J52 = l(30).*(cosd(chi).^m(30)).*exp(-n(30).*sec(chi));
% J53 = l(31).*(cosd(chi).^m(31)).*exp(-n(31).*sec(chi));
% J54 = l(32).*(cosd(chi).^m(32)).*exp(-n(32).*sec(chi));
% J55 = l(33).*(cosd(chi).^m(33)).*exp(-n(33).*sec(chi));
% J56 = l(34).*(cosd(chi).^m(34)).*exp(-n(34).*sec(chi));
% J61 = l(35).*(cosd(chi).^m(35)).*exp(-n(35).*sec(chi));
