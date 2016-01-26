% Function to generate NPD wind gust model
function [Ua,phi,f] = Norso_Gust(U,df,Nf)

z = 10;

ind = 0;

n = 0.468;

for f = df:df:Nf*df
    ind = ind + 1;
    
    x = 172*f*(z/10)^(2/3)*(U/10)^(-3/4);
    
    S(ind) = 320*(((U/10)^2 * (z/10)^0.45)/((1+x^n)^(5/(3*n))));
    
end

Ua = sqrt(2*S*df)';

phi = rand(size(Ua));  

f = (df:df:Nf*df)';


end

