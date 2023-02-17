function u_t = massBalanceFcn(u_b, u_e, C_gs, alpha,u,db, Global, ...
                              id_1, id_2, id_3)
% -------------------------------------------------------------------------
    % massBalanceFcn 
    % ----------------------------| input |--------------------------------

    % ----------------------------| output |-------------------------------
    %   u_t        [xxxxx]               
% -------------------------------------------------------------------------

    fw   = Global.fw;
    Emf  = Global.Emf;
    Dcat = Global.Dcat;
% -------------------------------------------------------------------------

    if strcmp(id_1,'FGBurbuja')

        FC1 = 1./(alpha + fw*alpha*Emf);
        u_t = -(RH1Fcn(alpha,u,u_b,Global,id_1)).*FC1                  ...
              +(RH2Fcn(alpha,u,u_b,u_e,Global,id_2)).*FC1              ... 
              -(RH3Fcn(alpha,db,u,u_b,u_e,C_gs,Global,id_2,id_3)).*FC1 ...
              +(RH4Fcn(alpha,C_gs,Global,id_1,id_3)).*FC1;
% -------------------------------------------------------------------------
    elseif strcmp(id_1,'FGEmulsion')

        FC2 = 1./((1-alpha-alpha*fw)*Emf);
        u_t = -(RH1Fcn(alpha,u(:,2),u_e,Global,id_1)).*FC2             ...
              -(RH2Fcn(alpha,u(:,1),u_b,u_e,Global,id_2)).*FC2         ...
              +(RH3Fcn(alpha,db,u(:,1),u_b,u_e,C_gs,Global,id_2,id_3)).*FC2 ...
              +(RH4Fcn(alpha,C_gs,Global,id_1,id_3)).*FC2;
% -------------------------------------------------------------------------
    elseif strcmp(id_1,'FSEstela')

        FC3 = 1./((alpha*fw)*(1-Emf)*Dcat);
        u_t = -RH1Fcn(alpha,u,u_b,Global,id_1).*FC3                    ...
              +RH2Fcn(alpha,u,u_b,u_e,Global,id_2).*FC3                ...
              -RH3Fcn(alpha,db,[],u_b,u_e,[],Global,id_2,[]).*FC3      ...
              +RH4Fcn(alpha,C_gs,Global,id_1,id_3).*FC3;
% -------------------------------------------------------------------------
    elseif strcmp(id_1,'FSEmulsion')

        FC4 = 1./((1-alpha-alpha*fw)*(1-Emf)*Dcat);
        u_t = +RH1Fcn(alpha,u(:,2),u_e,Global,id_1).*FC4               ...
              -RH2Fcn(alpha,u(:,1),u_b,u_e,Global,id_2).*FC4           ...
              +RH3Fcn(alpha,db,[],u_b,u_e,[],Global,id_2,[]).*FC4      ...
              +RH4Fcn(alpha,C_gs,Global,id_1,id_3).*FC4;

    end
% -------------------------------------------------------------------------
end