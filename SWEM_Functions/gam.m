% Gamma function
function [GAM] = gam(s)

GAM=1;

s = s-1;
for ind = 1:s
    
    
    GAM = GAM*(s-ind+1);


end

