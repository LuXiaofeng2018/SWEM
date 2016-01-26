% Function to generate TMA spectrum
function [PSI] = tma_spectrum2(kx,ky,H,U,theta_0,s)

[theta,k] = cart2pol(kx,ky);


fp = 0.15;     % peak freq in Hz (usually 0.1)
sig_a = 0.07;
sig_b = 0.09;

g = 9.81;

%% unidirectional TMA spectrum
om_p = 2*pi*fp;          % peak angular freq
kp = findk(om_p,g,H);    % peak wave number

kapp = (U^2*kp)/g;       % dimensionless peak wavenumber

% empirical contants
alpha = 0.0078*(kapp^(0.49)); 
gamm = 2.47*(kapp^(0.39));


om = sqrt(g*k*tanh(k*H)); % current angular freq

f = om/(2*pi);            % current freq

if (f<=fp)
    sig=sig_a;
else
    sig=sig_b;
end

PM = exp((-5/4)*(f/fp)^(-4));  % Pierson-Moskowitz
J  = exp( (log(gamm)*exp(-(f-fp)^2/(2*sig^2*fp^2))));  % JONSWAP

Ek = (alpha/2)*k^(-3);  % shallow water correction

TMA = Ek*PM*J;


%% L-H angular spreading function
gam1 = gam(s+1);
gam2 = gam((2*s)+1);

D = ((2^((2*s-1)))/(pi))*((gam1^2)/gam2)*((cos((theta-theta_0)/2))^(2*s));

PSI = TMA*D;

end

