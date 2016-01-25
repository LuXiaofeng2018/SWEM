function [PSI] = ey_spectrum_depth(U,fetch,kx,ky,wind_angle,depth)



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
g = 9.81;                     % gravity

CDN = 1e-3*(0.51*(U^0.46));   % neutral stability drag coeff. - Garratt77
u_star = sqrt(CDN)*U;         % approximate skin-friction velocity


k0 = g/(U^2);

X = k0*fetch;                 % dimensionless fetch
X0 = 2.2e4;
Om = 0.84*(tanh((X/X0)^(0.4))^(-0.75)); % inverse wave age

kp = k0*Om^2;                 % spectral peak wavenumber

Omega_p = sqrt(g*kp*tanh(kp*depth));

%cp = sqrt((g)/kp);              % peak phase speed
cp = Omega_p/kp;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



[theta,k] = cart2pol(kx,ky);

Omega = sqrt(g*k*tanh(k*depth));
%c = sqrt((g)/(k));        % phase speed of kn - assuming deep water
c = Omega/k;

%% Low-frequency range
alpha_p = 6e-3*sqrt(Om);

% Pierson-Moskowitz Spec
LPM = exp(-(5/4)*((kp/k)^2));

% JONSWAP Spec
if (Om<1)
    gamma = 1.7;
else
    gamma = 1.7 + 6*log10(Om);
end

sigma = 0.08*(1 + 4*(Om^(-3)));
R = exp(-(((sqrt(k/kp)-1)^2)/(2*(sigma^2))));

JP = gamma^R;


Fp = LPM*JP*exp(-(Om/sqrt(10))*(sqrt(k/kp)-1));

Bl = (1/2)*alpha_p*(cp/c)*Fp;




% %% High-frequency range
km = 371;
cm = sqrt((2*g)/km);  % <<<<<<<<<
% 
% Omega_m = sqrt(g*km*tanh(km*depth));
% cm = Omega_m/km;
% 
% if (k<kp)
%     Bh = 0;
% else
%     
%     if (u_star<cm)
%         alpha_m = 1e-2*(1+log(u_star/cm));
%     else
%         alpha_m = 1e-2*(1+3*log(u_star/cm));
%     end
%     
%     Fm = exp(-(1/4)*(((k/km)-1)^2));
%     
%     Bh = (1/2)*alpha_m*(cm/c)*Fm;
% end


%% Spreading Function
a0 = (log(2))/4;
ap = 4;
am = 0.13*(u_star/cm);
Delta = tanh(a0 + ap*((c/cp)^2.5) + am*((cm/c)^2.5));

%% Spectrum
PSI = (1/(2*pi))*(k^(-4))*(Bl)*(1+ Delta*cos(2*(theta-wind_angle)))*(cos((theta-wind_angle)/2)^2);
end

