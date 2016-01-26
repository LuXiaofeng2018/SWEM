% Function to find wave number k, given omega, g and depth
% using dispersion relation

function [k] = findk(om,g,H)

om_H = om*sqrt(H/g);


R = 1;

error = 100;

while error>0.001
    
   f_R = R*tanh(om_H^2*R)-1;  
   df_R = tanh(om_H^2*R) + R*(om_H^2*(1-(tanh(om_H^2*R))^2)); 
   
   R_new = R -f_R/df_R;
   
   error = abs(R_new-R);
   
   R = R_new;    
    
end


k = (om^2/g)*R;


end

