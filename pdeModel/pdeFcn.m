function ut = pdeFcn(t,u,Global)
% -------------------------------------------------------------------------
      % pdeFcn function define the EDOs for the numerical solution with 
      % the method of lines
      % ----------------------------| input |----------------------------------
      %       t = interval of integration, specified as a vector
      %       u = time-dependent terms, specified as a vector
      %  Global = constant values structure 
      % ----------------------------| output |---------------------------------
      %      ut =  time-dependent terms variation, specified as a vector
    % -------------------------------------------------------------------------
% --------------------| constants values |---------------------------------

    ncall = Global.iterations;


    zg      = Global.zg;
    CH4in   = Global.CH4in;
    CO2in   = Global.CO2in;
    N2in    = Global.N2in;
    Num_esp = Global.Num_esp;

    index1  = length(zg);
    id_g_b = 'gas_bubble'; id_g_e = 'gas_emulsion';
    id_s_w = 'solid_wake'; id_s_e = 'solid_emulsion';
% --------------------| Variables Initial Configuration |------------------
% ---------- non-negative values check ------------------------------------
    u(u < 0) = 0;
% ---------- gas - bubble & wake phases------------------------------------
    [u1b, u2b, u3b, u4b, u5b, u6b] = assignValuesFcn(u, Global, id_g_b);
% ---------- gas - emulsion phase -----------------------------------------
    [u1e, u2e, u3e, u4e, u5e, u6e] = assignValuesFcn(u, Global, id_g_e);
% ---------- solid - wake phase -------------------------------------------
                   [u7w, u8w, u9w] = assignValuesFcn(u, Global, id_s_w);
% ---------- solid - emulsion phase ---------------------------------------
                   [u7e, u8e, u9e] = assignValuesFcn(u, Global, id_s_e);
% ---------- assigning values to each variable |---------------------------
% --------------------| Boundary Conditions 1 |----------------------------
% ---------- z = 0 gas - bubble & wake phase ------------------------------
    u1b(1) = CH4in; u2b(1) = CO2in; u3b(1) = 0.000; 
    u4b(1) = 0.000; u5b(1) = 0.000; u6b(1) = N2in;
% ---------- z = 0 gas - emulsion phase -----------------------------------
    u1e(1) = CH4in; u2e(1) = CO2in; u3e(1) = 0.000;
    u4e(1) = 0.000; u5e(1) = 0.000; u6e(1) = N2in;
% ---------- z = 0 solid - wake & emulsion phases -------------------------
    u7w(1) = u7e(1); u8w(1) = u8e(1); u9w(1) = u9e(1);
% ---------- z = Zg solid - wake & emulsion phases ------------------------
    u7e(index1) = u7w(index1); u8e(index1) = u8w(index1);
    u9e(index1) = u9w(index1);
% --------------------| Fluidized Bed |------------------------------------   
% ---------- bubble - ubFcn.m ---------------------------------------------
    [ub,db,us,ue,alpha] = ubFcn(Global);    
% ---------- concentrations' vector ---------------------------------------
    C_gs.C_g_b = [u1b,u2b,u3b,u4b,u5b,u6b];
    C_gs.C_g_e = [u1e,u2e,u3e,u4e,u5e,u6e];
    C_gs.C_s_w = [u7w,u8w,u9w]; C_gs.C_s_e = [u7e,u8e,u9e];
% --------------------| Mass Balance - Gas - Bubble & Wake Phase | --------
    id_1 = 'FGBurbuja'; id_2 = 'FGas';
    u1bt = massBalanceFcn(u1b,u1e,C_gs,alpha,ub,db,Global,id_1,id_2,'CH4');
    u2bt = massBalanceFcn(u2b,u2e,C_gs,alpha,ub,db,Global,id_1,id_2,'CO2');
    u3bt = massBalanceFcn(u3b,u3e,C_gs,alpha,ub,db,Global,id_1,id_2,'CO' );
    u4bt = massBalanceFcn(u4b,u4e,C_gs,alpha,ub,db,Global,id_1,id_2,'H2' );
    u5bt = massBalanceFcn(u5b,u5e,C_gs,alpha,ub,db,Global,id_1,id_2,'H2O');
    u6bt = massBalanceFcn(u6b,u6e,C_gs,alpha,ub,db,Global,id_1,id_2,'N2' );
% --------------------| Mass Balance - Gas - Emulsion Phase |--------------
    id_1 = 'FGEmulsion'; 
    u1et = massBalanceFcn(u1b,u1e,C_gs,alpha,[ub,ue],db,Global,id_1,id_2,'CH4');
    u2et = massBalanceFcn(u2b,u2e,C_gs,alpha,[ub,ue],db,Global,id_1,id_2,'CO2');
    u3et = massBalanceFcn(u3b,u3e,C_gs,alpha,[ub,ue],db,Global,id_1,id_2,'CO' );
    u4et = massBalanceFcn(u4b,u4e,C_gs,alpha,[ub,ue],db,Global,id_1,id_2,'H2' );
    u5et = massBalanceFcn(u5b,u5e,C_gs,alpha,[ub,ue],db,Global,id_1,id_2,'H2O');
    u6et = massBalanceFcn(u6b,u6e,C_gs,alpha,[ub,ue],db,Global,id_1,id_2,'N2' );
% --------------------| Mass Balance - Solid - Wake Phase |----------------
    id_1 = 'FSEstela'; id_2 = 'FSolido';
    u7wt = massBalanceFcn(u7w,u7e,C_gs,alpha,ub,db,Global,id_1,id_2,'NiO');
    u8wt = massBalanceFcn(u8w,u8e,C_gs,alpha,ub,db,Global,id_1,id_2,'Ni' );
    u9wt = massBalanceFcn(u9w,u9e,C_gs,alpha,ub,db,Global,id_1,id_2,'C'  );
% --------------------| Mass Balance - Solid - Emulsion Phase |------------
    id_1 = 'FSEmulsion'; 
    u7et = massBalanceFcn(u7w,u7e,C_gs,alpha,[ub,us],db,Global,id_1,id_2,'NiO');
    u8et = massBalanceFcn(u8w,u8e,C_gs,alpha,[ub,us],db,Global,id_1,id_2,'Ni' );
    u9et = massBalanceFcn(u9w,u9e,C_gs,alpha,[ub,us],db,Global,id_1,id_2,'C'  );
% --------------------| Boundary Conditions 2 |----------------------------
% ---------- z = 0 gas - bubble & wake phase ------------------------------
    u1bt(1) = 0; u2bt(1) = 0; u3bt(1) = 0; 
    u4bt(1) = 0; u5bt(1) = 0; u6bt(1) = 0;
% ---------- z = 0 gas - emulsion phase -----------------------------------
    u1et(1) = 0; u2et(1) = 0; u3et(1) = 0; 
    u4et(1) = 0; u5et(1) = 0; u6et(1) = 0;
% ---------- z = 0 solid - wake & emulsion phases -------------------------
    u7wt(1) = u7et(1); u8wt(1) = u8et(1); u9wt(1) = u9et(1);
% ---------- z = Zg solid - wake & emulsion phase -------------------------
    u7et(index1) = u7wt(index1); u8et(index1) = u8wt(index1);
    u9et(index1) = u9wt(index1);
% --------------------| Temporal Variation Vector dudt |-------------------
    ut    = zeros((Num_esp*index1),1);

    ut1 = [u1bt; u2bt; u3bt; u4bt; u5bt; u6bt; ...
           u1et; u2et; u3et; u4et; u5et; u6et; 
           u7wt; u8wt; u9wt; u7et; u8et; u9et];
        for i = 1:index1, ut(i+(0*index1))  = u1bt(i); end
        for i = 1:index1, ut(i+(1*index1))  = u2bt(i); end
        for i = 1:index1, ut(i+(2*index1))  = u3bt(i); end
        for i = 1:index1, ut(i+(3*index1))  = u4bt(i); end
        for i = 1:index1, ut(i+(4*index1))  = u5bt(i); end
        for i = 1:index1, ut(i+(5*index1))  = u6bt(i); end
        for i = 1:index1, ut(i+(6*index1))  = u1et(i); end
        for i = 1:index1, ut(i+(7*index1))  = u2et(i); end
        for i = 1:index1, ut(i+(8*index1))  = u3et(i); end
        for i = 1:index1, ut(i+(9*index1))  = u4et(i); end
        for i = 1:index1, ut(i+(10*index1)) = u5et(i); end
        for i = 1:index1, ut(i+(11*index1)) = u6et(i); end
        for i = 1:index1, ut(i+(12*index1)) = u7wt(i); end
        for i = 1:index1, ut(i+(13*index1)) = u8wt(i); end
        for i = 1:index1, ut(i+(14*index1)) = u9wt(i); end
        for i = 1:index1, ut(i+(15*index1)) = u7et(i); end
        for i = 1:index1, ut(i+(16*index1)) = u8et(i); end
        for i = 1:index1, ut(i+(17*index1)) = u9et(i); end
% --------------------| Number Calls To pdeFcn |---------------------------
    ncall.incrementNcall();
    ncall.dispNcall();
% --------------------| pdeFcn - End |-------------------------------------
    end 