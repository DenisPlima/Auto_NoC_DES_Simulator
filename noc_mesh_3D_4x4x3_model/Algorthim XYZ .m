%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author : Nejib Mediouni
% Date : 25/05/2016
% Description:  Implementation of XYZ's algorithm under Matlab
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%S%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function out_RT  = fcn(DST_X,DST_Y,DST_Z, IME_X, IME_Y,IME_Z)


North = 1;
South = 2;
West = 3;
East = 4;
Up = 5;
Down = 6;
NI = 7;

xi =IME_X;
yi =IME_Y;
zi =IME_Z;


x = DST_X;
y = DST_Y;
z = DST_Z;

if (xi ~= x),
    if (xi < x),
        out_RT = West;
    else
        out_RT = East;
    end
elseif (yi ~= y),
    if (yi < y),
        out_RT = North;
    else
        out_RT = South;
    end
elseif (zi ~= z),
    if (zi < z),
        out_RT = Up;
    else
        out_RT = Down;
    end
else
    out_RT = NI;
end