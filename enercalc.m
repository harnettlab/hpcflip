function U = enercalc(n,tprime,alpha,phi)
    %calculate the total strain energy in a curved beam due to curvature
    %(not compression/tension)
    %all angles should be in radians
    %n is the number of inflection points, typically 1 or 2
    switch n
        case 1 %1 inflection point, 2 segments to integrate
            U=-quadgk( @(theta) enerfunct(theta,tprime,phi), alpha,tprime);
            U=U+quadgk( @(theta) enerfunct(theta,tprime,phi),tprime,0);
        case 2 %2 inflection points, 3 segments to integrate
            U=quadgk( @(theta) enerfunct(theta,tprime,phi), alpha,tprime);
            U=U-quadgk( @(theta) enerfunct(theta,tprime,phi), tprime,2*phi-tprime);
            U=U+quadgk( @(theta) enerfunct(theta,tprime,phi),2*phi-tprime,0);
    end        
