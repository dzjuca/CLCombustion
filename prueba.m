% Datos
x = 0:0.1:10;
y1 = sin(x);
y2 = 2*cos(x);

% Gráfico con doble eje 'y'
figure
yyaxis left
plot(x, y1)
ylabel('y1')
yyaxis right
plot(x, y2)
ylabel('y2')
xlabel('x')
