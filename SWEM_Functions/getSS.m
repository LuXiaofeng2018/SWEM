function [SeaState ] = getSS(Hs)

if (Hs>0 && Hs<=0.1)
    SeaState = 1;
elseif (Hs>0.1 && Hs<=0.5)
    SeaState = 2;
elseif (Hs>0.5 && Hs<=1.25)
    SeaState = 3;
elseif (Hs>1.25 && Hs<=2.5)
    SeaState = 4;
elseif (Hs>2.5 && Hs<=4)
    SeaState = 5;
else
    SeaState = 6;
end


end

