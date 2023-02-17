function Global = globalDataFcn()
    % -------------------------------------------------------------------------
    % globalData-function return a structure 'Global' with data constants
    % -------------------------------------------------------------------------
    % -------------------- | General Data |------------------------------------
          Global.R = 8.314472e-3;         % Universal Gas Constant    [kJ/molK]    
          Global.P = 1.01325;             % Pressure                      [bar]   
          Global.Tbed    = 800;           % Temperature                     [K]
          Global.g       = 981.0;         % Gravity                     [cm/s2]
          Global.Num_esp = 18;            % number of species               [#]
          Global.gen     = 6;             % gas species number              [#]
          Global.sen     = 3;             % solid species number            [#]
          Global.iterations = Iterations.getInstance();% number of iterations
          Global.n       = 30;            % mesh points number              [#] 
    % ----------| Flow rate and concentration of species |---------------------
    % ----- total feed flow in the reactor's bottom ---------------------------
          Global.QT_in = 247.5;           %                        [STP ml/min]
    % ----- flow feed ratio for each specie -----------------------------------
          CH4in_rat = 40.0;               % CH4                             [%]
          CO2in_rat = 40.0;               % CO2                             [%]
          N2in_rat  = 20.0;               % N2                              [%]
          COin_rat  = 0.00;               % CO                              [%]
          H2in_rat  = 0.00;               % H2                              [%]
          H2Oin_rat = 0.00;               % H2O                             [%]
          O2in_rat  = 0.00;               % O2                              [%]
    % ----- flow feed for each specie -----------------------------------------
          FCH4in = (CH4in_rat/100)*Global.QT_in/(22.4*1000*60); %       [mol/s]
          FCO2in = (CO2in_rat/100)*Global.QT_in/(22.4*1000*60); %       [mol/s]
          FN2in  = ( N2in_rat/100)*Global.QT_in/(22.4*1000*60); %       [mol/s]
          FCOin  = ( COin_rat/100)*Global.QT_in/(22.4*1000*60); %       [mol/s]
          FH2in  = ( H2in_rat/100)*Global.QT_in/(22.4*1000*60); %       [mol/s]
          FH2Oin = (H2Oin_rat/100)*Global.QT_in/(22.4*1000*60); %       [mol/s]
          FO2in  = ( O2in_rat/100)*Global.QT_in/(22.4*1000*60); %       [mol/s]
    % ----- feed concentration for each specie --------------------------------
          Global.CH4in = (FCH4in*60/Global.QT_in); %                  [mol/cm3]
          Global.CO2in = (FCO2in*60/Global.QT_in); %                  [mol/cm3]
          Global.COin  = ( FCOin*60/Global.QT_in); %                  [mol/cm3]
          Global.H2in  = ( FH2in*60/Global.QT_in); %                  [mol/cm3]
          Global.H2Oin = (FH2Oin*60/Global.QT_in); %                  [mol/cm3]
          Global.N2in  = ( FN2in*60/Global.QT_in); %                  [mol/cm3]
          Global.O2in  = ( FO2in*60/Global.QT_in); %                  [mol/cm3]
    
          if (Global.QT_in == 0) 
              Global.CH4in = 0; 
              Global.CO2in = 0; 
              Global.COin = 0; 
              Global.H2in = 0;
              Global.H2Oin = 0;  
              Global.N2in = 0;  
              Global.O2in = 0; 
          end
    % -------------------------------------------------------------------------
    % ---------- constant data from spatial mesh (z) --------------------------
    %     Global.n  = 30;       % mesh points number                        [#]  
    % ---------- reactor constant data  ---------------------------------------
          Global.Di = 2.7;     % the internal diameter of the reactor      [cm]
          Global.zl = 6.0;     % reaction zone height                      [cm]
          Global.zg = linspace(0, ...
                      Global.zl,  ...
                      Global.n)';  % height for each mesh point            [cm]
          Global.A  = pi*(Global.Di/2)^2; % cross-sectional area          [cm2]
    % ---------- catalyst constant data ---------------------------------------
          Global.W     = 30.000;   % catalyst weight                        [g]
          Global.WIn   = 67.500;   % inert weight                           [g]
          Global.Dcat  = 0.8730;   % catalyst density                   [g/cm3]
          Global.DIn   = 0.7300;   % inert density                      [g/cm3]
          Global.CcMax = 0.3051;   % max coke concentration      [g.coke/g.cat]
          Global.cAl2O3  = 0.85;   % alumina concentration      [g.Al2O3/g.cat]
          Global.cNickel = 0.05;   % nickel concentration          [g.Ni/g.cat]
          Global.cCeria  = 0.10;   % ceria concentration           [g.Ce/g.cat]
          Global.dparticle = 0.0143;  % particle diameter                  [cm]
    % ---------- fluidized bed constant data ----------------------------------
          Global.umf = (16.093/60.0); % minimum fluidization velocity    [cm/s] 
          Global.fw  = 0.15;          % fraction of wake in bubbles         [ ]
          Global.Emf = 0.45;          % minimum fluidization porosity       [ ]
    % ---------- fluid constant data ------------------------------------------
          Global.usg0 = ...
                      Global.QT_in./(Global.A*60.0);% Initial Flow Rate  [cm/s]
    % -------------------------------------------------------------------------
    % ---------- Chemical Looping Combustion ----------------------------------
          Global.kinetic.R       = 8.314472; % Universal Gas Constant  [J/molK] 
          Global.kinetic.Tbed    = 800;      % Temperature                  [K]
    % ---------- molar mass for each specie -----------------------------------
          Global.MMASS(1) = 16.0426;      % - CH4                       [g/mol]
          Global.MMASS(2) = 44.0090;      % - CO2                       [g/mol]
          Global.MMASS(3) = 28.0100;      % - CO                        [g/mol]
          Global.MMASS(4) = 2.01580;      % - H2                        [g/mol]
          Global.MMASS(5) = 18.0148;      % - H2O                       [g/mol]
          Global.MMASS(6) = 28.0140;      % - N2                        [g/mol] 
          Global.MMASS(7) = 12.0110;      % - C(s)                      [g/mol]
    % ---------- molar mass for each solid specie -----------------------------
          Global.mMolarAl2O3  = 101.960;  %                             [g/mol]
          Global.mMolarCeria  = 140.120;  %                             [g/mol]
          Global.mMolarNickel = 58.6934;  %                             [g/mol]
    % ---------- Potentials for each compound - LENNARD-JONES -----------------
          Global.SIGMA(1) = 3.758;        % - CH4                           [A]
          Global.SIGMA(2) = 3.941;        % - CO2                           [A]
          Global.SIGMA(3) = 3.690;        % - CO                            [A]
          Global.SIGMA(4) = 2.827;        % - H2                            [A]
          Global.SIGMA(5) = 2.641;        % - H2O                           [A]
          Global.SIGMA(6) = 3.798;        % - N2                            [A]
          Global.EK(1)    = 148.6;        % - CH4                           [K]
          Global.EK(2)    = 195.2;        % - CO2                           [K]
          Global.EK(3)    = 91.70;        % - CO                            [K]
          Global.EK(4)    = 59.70;        % - H2                            [K]
          Global.EK(5)    = 809.1;        % - H2O                           [K]
          Global.EK(6)    = 71.40;        % - N2                            [K]
    end