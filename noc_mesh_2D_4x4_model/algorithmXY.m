
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Autors : Nejib Mediouni
% Date : 25/05/2016
% Description: Matlab implementation of algorithm XY 
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%S%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function out_RT  = fcn(DST,ME)

yi = floor(ME/4)+1;
xi = mod(ME,4);

if (xi==0),
    xi = 4;
    yi = yi - 1;
end

y = floor(DST/4)+1;
x = mod(DST,4);

if (x==0),
   x = 4;
    y = y - 1;
end

if x~=xi,
    if (x<xi),
        out_RT = 2;
    else 
        out_RT = 3;
    end
elseif y~=yi,
    if (y<yi),
        out_RT = 1;
    else
        out_RT = 4;
    end
else
    out_RT = 5;
end
