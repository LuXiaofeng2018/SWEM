% Function to generate wave and current influence spectra
function [PSI,K,THETA] = makeSpectrum(Spec,M,N,Lx,Ly,U,fetch,angle,depth,s)


k1 = [0:(M/2)-1 M/2 -(M/2)+1:-1];
k2 = [0:(N/2)-1 N/2 -(N/2)+1:-1];

PSI = zeros(M*N,1);
K = zeros(M*N,1);
THETA = zeros(M*N,1);

rw=0;
for mk=1:length(k1)
    for nk=1:length(k2)
        rw=rw+1;
        
        kx = (2*pi*k1(mk))/Lx;
        ky = (2*pi*k2(nk))/Ly;       
        
        [theta,k] = cart2pol(kx,ky);
        
        if (kx==0 && ky==0)
           psi=0;           
           continue  
        end
        
        if (strcmp(Spec,'EY')==1)           
            [psi] = ey_spectrum_depth(U,fetch,kx,ky,angle,depth);
        elseif (strcmp(Spec,'TMA')==1)
            [psi] = tma_spectrum2(kx,ky,depth,U,angle,s);
        elseif (strcmp(Spec,'NC')==1)
            [psi] = nwogu_current_spec_1(kx,ky,U,angle,depth);
        else
            disp('Error: incorrect spectrum input');
        end

       
        PSI(rw) = psi;    
        K(rw) = k;
        THETA(rw) = theta;
        
    end
end



end

