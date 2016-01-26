% Function to find omega using dispersion relation
function [Om] = getOm(M,N,Lx,Ly,depth)

k1 = [0:(M/2)-1 M/2 -(M/2)+1:-1];
k2 = [0:(N/2)-1 N/2 -(N/2)+1:-1];

g = 9.81;

rw=0;
for mk=1:length(k1)
     for nk=1:length(k2)
         rw=rw+1;
        
        kx = (2*pi*k1(mk))/Lx;
        ky = (2*pi*k2(nk))/Ly;       
        k = sqrt(kx^2+ky^2);
                   
        Om(rw) = sqrt(g*k*tanh(k*depth));
     end
    
end




end

