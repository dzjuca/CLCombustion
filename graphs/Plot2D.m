classdef Plot2D
    properties
        data % Matriz de datos
        x % Vector de coordenadas en x
        y % Vector de coordenadas en y
        xlabel % Etiqueta para el eje x
        ylabel % Etiqueta para el eje y
        title % Título del gráfico
        colormap % Colormap para el gráfico
    end
    
    methods
        function obj = Plot2D(data, x, y, xlabel, ylabel, title, colormap)
            % Constructor de la clase
            obj.data = data;
            obj.x = x;
            obj.y = y;
            obj.xlabel = xlabel;
            obj.ylabel = ylabel;
            obj.title = title;
            obj.colormap = colormap;
        end
        
        function plot(obj)
            % Función para graficar los datos
            imagesc(obj.x, obj.y, obj.data);
            xlabel(obj.xlabel);
            ylabel(obj.ylabel);
            title(obj.title);
            colormap(obj.colormap);
            colorbar;
        end
    end
end
