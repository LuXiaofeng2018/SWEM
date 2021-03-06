% Function to generate EY spectrum given swell windspeed and fetch
function [Om,PSI_swell,kx,ky,phase] = swellComponent_U(depth,M,N,Lx,Ly,U_swell,fetch_swell,swell_angle)

%% Parameters
g       = 9.81;   % gravity

% Swell
swell_angle = ((2*pi)/360)*swell_angle;


% Generate swell spectrum and get Angular Freqs.
[PSI_swell,~,~] = makeSpectrum('EY',M,N,Lx,Ly,U_swell,fetch_swell,swell_angle,depth,0);
[Om] = getOm(M,N,Lx,Ly,depth); 


phase = rand(M*N,1)*2*pi; % random phases

k1 = [0:(M/2)-1 M/2 -(M/2)+1:-1];
k2 = [0:(N/2)-1 N/2 -(N/2)+1:-1];
kx = (2*pi*k1)/Lx;
ky = (2*pi*k2)/Ly;

end

