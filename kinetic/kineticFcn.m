function kinetic = kineticFcn(C_gas, C_solid, T, Global, id)
% -------------------------------------------------------------------------
    % CineticaFcn function 
    % ----------------------------| input |--------------------------------
    %        Cgas = concentration vector of each species          [mol/cm3]
    %      Global = constant values structure 
    %         Tbe = phase temperature                                   [K]
    %   caracter2 = species|reaction identifier
    % ----------------------------| output |-------------------------------
    %   cinetica = reaction rate of each species               [mol/gcat s]                       
% -------------------------------------------------------------------------
    zg      = Global.zg;
    index1  = length(zg);
    kinetic = zeros(index1,1);
    data    = Global.kinetic;
% -------------------------------------------------------------------------
    for  i = 1:index1 

        C_gas_z   = C_gas(i,:);
        C_solid_z = C_solid(i,:); 
        PPT       = partialPressureFcn(C_gas_z);
        T_z       = T(i);
% -------------------------------------------------------------------------
        if     strcmp(id,'CH4')
                kinetic(i,1) = R_CH4_Fcn(C_solid_z, PPT, T_z, data);
        elseif strcmp(id,'CO2')
                kinetic(i,1) = R_CO2_Fcn(C_gas_z,C_solid_z,PPT,T_z, data);
        elseif strcmp(id,'CO')
                kinetic(i,1) = R_CO_Fcn(C_gas_z,C_solid_z,PPT,T_z,data);
        elseif strcmp(id,'H2')
                kinetic(i,1) = R_H2_Fcn(C_gas_z,C_solid_z,PPT,T_z,data);
        elseif strcmp(id,'H2O')
                kinetic(i,1) = R_H2O_Fcn(C_gas_z,C_solid_z,PPT,T_z,data);
        elseif strcmp(id,'NiO')
                kinetic(i,1) = R_NiO_Fcn(C_gas_z, C_solid_z, T_z, data);
        elseif strcmp(id,'Ni')
                kinetic(i,1) = R_Ni_Fcn(C_gas_z, C_solid_z, T_z, data);
        elseif strcmp(id,'C')
                kinetic(i,1) = R_C_Fcn(C_solid_z, PPT, T_z, data);
        elseif strcmp(id,'N2')
                kinetic(i,1) = 0.0;
        else
            disp('CineticaFcn.m error')
        end 
% -------------------------------------------------------------------------
    end
% ------------------------------------------------------------------------- 
end
