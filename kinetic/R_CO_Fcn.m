function R_CO = R_CO_Fcn(C_gas, C_solid, PPT, T, data)
% -------------------------------------------------------------------------
    % R_CO_Fcn is a function that calculates the reaction rate for CO
    % ----------------------------| input |--------------------------------
    % a0 = initial specific surface area of the O2 carrier   [m2/kgCarrier]
    %  X = NiO conversion                                                []
    %  T = temperature of the system                                    [K]
    %  R = Universal Gas Constant                                  [J/molK]

    % ----------------------------| output |-------------------------------
    % R_CO    =  the reaction rate                           [kmol/kgNi s]
% -------------------------------------------------------------------------

    R       = data.R; 
    a0      = data.a0; 
    C_NiO_o = data.C_NiO_o;

    PCH4 = PPT(1);
    PCO2 = PPT(2);
    PCO  = PPT(3);
    PH2  = PPT(4);
    PH2O = PPT(5);

    C_CH4 = C_gas(1);
    C_CO  = C_gas(3);
    C_NiO = C_solid(1);
    C_Ni  = C_solid(2);

% ------------------------------------------------------------------------- 

    k_s3 = 100*(1.097e-4*exp(-26505/(R*T)));
    k_s4 = 100*(4.18e-3*exp (-23666/(R*T)));

% ------------------------------------------------------------------------- 

%   X = conversionFcn(C_NiO, C_NiO_o);
    X = conversionFcn(C_NiO, C_NiO_o, data);

% ------------------------------------------------------------------------- 

    r_rf_H2O = r_rfH2O_Fcn(PCH4, PH2O, PH2, PCO, T, R);
    r_WGS    = r_WGS_Fcn(PCO2, PH2, PCO, PH2O, T, R);
    r_CH4_m  = r_CH4m_Fcn(PCO, PH2, T, R);
    r_rf_CO2 = r_rfCO2_Fcn(PCH4, PCO2, T, R);
    r_g_CO2  = r_gCO2_Fcn(PCO2, PCO, T, R);
    r_g_H2O  = r_gH2O_Fcn(PCH4, PH2O, PCO, PH2, T, R);

% -------------------------------------------------------------------------

    tmp_1 = k_s3*C_CO/C_Ni;
    if C_Ni == 0, tmp_1 = 0; end
    tmp_2 = tmp_1 - k_s4*C_CH4;

    R_CO = (-a0*(1 - X)*tmp_2*C_NiO + r_rf_H2O - r_WGS - r_CH4_m ... 
            + 2*r_rf_CO2 + 2*r_g_CO2 + r_g_H2O)*C_Ni;

% ------------------------------------------------------------------------- 
end

