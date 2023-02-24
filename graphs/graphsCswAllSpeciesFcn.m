function graphsCswAllSpeciesFcn(t,u, Global)
    % -------------------------------------------------------------------------
           % graphs_C_g_b_Fcn function 
           % ----------------------------| input |-----------------------------
           % ----------------------------| output |----------------------------
           %  ebrhs1 = right-hand side term-1                         [J/s cm3]
    % -------------------------------------------------------------------------

        tmin = t/60; 
    
    % -------------------------------------------------------------------------
        zg     = Global.reactor.zg;
        index1 = length(t);    % tiempo
        index2 = Global.n;     % espacio
        m      = length(t);
        n      = Global.n;
    % -------------------------------------------------------------------------
    
        u7w = zeros(index1,index2); 
        u8w = zeros(index1,index2);
        u9w = zeros(index1,index2);
    
    % -------------------------------------------------------------------------
        for j=1:index1 
            for i=1:index2, u7w(j,i)=u(j,i+12*index2);    end
            for i=1:index2, u8w(j,i)=u(j,i+13*index2);    end
            for i=1:index2, u9w(j,i)=u(j,i+14*index2);    end
        end
    % -------------------------------------------------------------------------
        CiSW(:,:,1) = u7w; CiSW(:,:,2) = u8w; CiSW(:,:,3) = u9w;
    % -------------------------------------------------------------------------
        TAG1 = {'$C_{i}\left( \frac{g}{g_{carrier}} \right)$'}; 
        TAG3 = {'C_Time','C_Space'};
        TAG5 = {'graphs/Concentration'};
    % -------------------------------------------------------------------------
    
        FZ1 = 14; MZ1 = 5; XLFZ = 14; YLFZ = 14; LFZ = 5;
    
    % --------------------------| Concentration vs time |----------------------
    
        id = exist('graphs/Concentration','file');
        if id == 7
            dir = strcat(pwd,'/',TAG5{1},'/',TAG3{1},'SolidWake','Total');
        else
            mkdir('graphs/Concentration')
            dir = strcat(pwd,'/',TAG5{1},'/',TAG3{1},'SolidWake','Total');
        end
    
        % ---------------------------------------------------------------------
        fig1 = figure;
        set(fig1,'Units','centimeters',       ...
                'PaperPosition',[0 0 15 15], ...
                'PaperSize', [15,15]);
    
        axes('Parent',fig1,'FontSize',FZ1,'XGrid','off', ...
            'YGrid','off','visible','on','Box', 'on',    ...
            'TickLabelInterpreter','latex');
    
        set(fig1, 'Color', 'w') 
        % ---------------------------------------------------------------------
        hold on
    
            plot(tmin,CiSW(:,n,1)','ko-','MarkerSize',MZ1);
            plot(tmin,CiSW(:,n,2)','ks-','MarkerSize',MZ1);
            plot(tmin,CiSW(:,n,3)','kp-','MarkerSize',MZ1);
    
            ley1 = {'$NiO$','$Ni$','$C$'};
    
            legend(ley1,'Interpreter','Latex','Location','north',   ...
                'Orientation','horizontal','FontSize',LFZ)
    
            xlabel('$time\left( {s} \right)$','FontSize',XLFZ,      ...
                'interpreter','Latex')
    
            ylabel(TAG1{1},'FontSize',YLFZ,'interpreter','Latex')
    
            max1 = max(max(CiSW(:,n,:)));
            max1 = max1 + max1*0.15;
            ylim([0 max1])
    
            max2 = max(tmin); 
            % max2 = max2 + max2*0.05;
            xlim([0 max2])
    
        hold off
        print(fig1,'-dpdf','-r500',dir)
        close all
    % -------------------------------------------------------------------------
    % --------------------------| Concentration vs space |---------------------
        id = exist('graphs/Concentration','file');
        if id == 7
            dir = strcat(pwd,'/',TAG5{1},'/',TAG3{2},'SolidWake','Total');
        else
            mkdir('graphs/Concentration')
            dir = strcat(pwd,'/',TAG5{1},'/',TAG3{2},'SolidWake','Total');
        end
        % ---------------------------------------------------------------------
        fig2 = figure;
    
        set(fig2,'Units','centimeters',                       ...
            'PaperPosition',[0 0 15 15],                      ...
            'PaperSize', [15,15]);
    
        axes('Parent',fig2,'FontSize',FZ1,'XGrid','off',      ...
            'YGrid','off','visible','on','Box', 'on',         ...
            'TickLabelInterpreter','latex');
        set(fig2, 'Color', 'w') 
    
        hold on
    
            plot(zg,CiSW(m,:,1)','ko-','MarkerSize',MZ1);
            plot(zg,CiSW(m,:,2)','ks-','MarkerSize',MZ1);
            plot(zg,CiSW(m,:,3)','kp-','MarkerSize',MZ1);
    
            ley2 = {'$NiO$','$Ni$','$C$'};
    
            legend(ley2,'Interpreter','Latex',               ...
                   'Location','north',                       ...
                   'Orientation','horizontal',               ...
                   'FontSize',LFZ)
    
            xlabel('$z\left( {cm} \right)$',                 ...
                'FontSize',XLFZ,'interpreter','Latex')
    
            ylabel(TAG1{1},'FontSize',YLFZ,'interpreter','Latex') 
    
            max1 = max(max(CiSW(m,:,:)));
            max1 = max1 + max1*0.15;
            ylim([0 max1])
    
            max2 = max(zg); 
            % max2 = max2 + max2*0.05;
            xlim([0 max2])
    
        hold off
    
        print(fig2,'-dpdf','-r500',dir)
    
     close all
    % -------------------------------------------------------------------------
    end