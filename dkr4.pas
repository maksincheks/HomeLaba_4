uses CRT,GraphABC;
var i,c,a,b,n,scale,y,x : integer;  integralsum : real;


function F(x: Real): Real; 
begin 
  Result := 2*x*x*x+(-1)*x*x+(-4)*x+8; 
end; 


function integral(g : real) : real;
begin
  Result := (g*g*g*g)/2 - (g*g*g)/3 + 2*g
end;


procedure draw_plane(scale, a, b:integer); 
var 
i, x, y: integer; 
begin 
x := 30; 
y := 770; 
SetWindowSize((b+1)*20*scale + 80, 800); 
SetPenColor(clBlack); 
Line(30, 770, (b+1)*20*scale+30, 770); // Ось X 
Line(30, 30, 30, 770); // Ось Y 
line((b+1)*20*scale + 25, y-5, (b+1)*20*scale + 30, y); 
line((b+1)*20*scale + 25, y+5, (b+1)*20*scale + 30, y); 
line(25, 35, 30, 30); 
line(35, 35, 30, 30); 
TextOut(15, 25, 'Y'); 
TextOut((b+1)*20*scale + 25, 780, 'X'); 
TextOut(20, 775, '0'); 
for i:= 1 to b do 
begin 
line(x+(20*scale*i), y+5, x+(20*scale*i), y-5); 
TextOut(x+(20*i*scale-4), y+10, i); 
end; 
for i:= 1 to 36 do 
begin 
line(25, y-(20*i*scale), 35, y-(20*scale*i)); 
TextOut(13, y-(20*i*scale)-7, i); 
end; 
end; 


function graph(a, b, n, x, y, scale:integer):boolean; 
var 
i: integer; 
h: Real; 
begin 
h := (b - a) / n; 
for i:= 0 to n-1 do 
begin 
SetPenColor(clBlack); 
line(trunc(x+a*20*scale+h*i*20*scale), y-trunc(F(a+i*h))*20*scale, trunc(x+a*20*scale+h*i*20*scale+h*20*scale), y-trunc(F(a+i*h+h))*20*scale); 
end; 
end;


function rects(a, b, n, x, y, scale:integer):boolean; 
var 
i: integer; 
h: Real; 
begin 
h := (b - a) / n; 
for i:=0 to n-1 do 
begin 
SetBrushColor(clPink); 
rectangle(trunc(x+a*20*scale+h*i*20*scale), y, trunc(x+a*20*scale+h*i*20*scale+h*20*scale), y-trunc(F(a+i*h+h-h/2))*20*scale); 
end; 
end; 


function square : real;
begin
  Result := integral(b) - integral(a);
end;


function LeftRect(a, b: Real; n: Integer): Real; 
var 
h, x, sum: Real; 
i: Integer; 
begin 
h := (b - a) / n; 
sum := 0; 
for i := 0 to n - 1 do 
begin 
x := a + h * i; // Using the left endpoint of each subinterval
sum := sum + F(x); 
end; 
LeftRect := h * sum; 
end;


procedure pogreshnost;
begin
  Writeln('Погрешность равна ',abs(square - LeftRect(a,b,n)));
  readln();
end;


procedure new_predel;
begin
  ClrScr;
  writeln('Введите новые пределы и количество прямоугольников: ');
  readln(a,b,n);
end;


begin
  x := 30; 
  y := 770; 
  scale := 1;
  SetConsoleIO; 
  repeat
  ClrScr;
  writeln('Найти погрешность - 1');
  writeln('Найти площадь с помощью левых прямоугольников - 2');
  writeln('Найти площадь - 3');
  writeln('Ввести пределы и количество прямоугольников- 4');
  writeln('Вывести график - 5');
  writeln('Ввести 0 для выхода из программы');
  readln(c);
  case c of
    1 : pogreshnost;
    2 : begin print(LeftRect(a,b,n)); var ch : char; repeat readln(ch) until ch = #13; end;
    3 : begin write('Площадь равна '); writeln(square); readln(); end;
    4 : new_predel;
    5 : 
    begin
      draw_plane(scale, a, b); 
      rects(a, b, n, x, y, scale); 
      graph(a, b, n, x, y, scale);  
    end;
  end;
  until c = 0;
end.  