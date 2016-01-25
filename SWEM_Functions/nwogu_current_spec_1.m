function [NC] = nwogu_current_spec_1(kx,ky,U,current_angle,depth)

g = 9.81;


[theta_0,k0] = cart2pol(kx,ky);    
om = sqrt(g*k0*tanh(k0*depth)); 

theta_0 = theta_0-current_angle;


k0 = findk(om,g,depth);

Delta_om = om-U*k0*cos(theta_0);

k = findk(Delta_om,g,depth);

if (theta_0<0)
 theta = -acos(complex((k0*cos(theta_0))/k));
else
 theta = acos(complex((k0*cos(theta_0))/k));
end

if (imag(theta)~=0)
    theta = theta_0;
end

Cg0 = groupvel(k0,depth);
Cg  = groupvel(k,depth);

tmp = ((k*Cg0)/(k0*(Cg+U*cos(theta))))*(1 - (U*k*cos(theta))/om);

if (Cg <= -U*cos(theta))  % set "breaking waves" to zero magnitude
    NC = 0;
else
    NC = abs(tmp);
end

if (k0>1)  %% Reduce magnitude of high frequency waves
    NC = NC/(k0^5);
end