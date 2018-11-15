################################################################################

#Variables 

global A = [3,1;2,4];

################################################################################
#GUI
#Bienvenido
function SIEL
  global h = figure("name", "Sistema de Ecuaciones Lineales", "position", [330,140,720,440], "graphicssmoothing", "on", "menubar", "none");
  box on;
  axis off; 
  integrantes = "- Cabaña Damian  1433581 \n- Leandro Laiño  1375260 \n- \n- \n- ";
  
  uicontrol("style", "text", "string", "Bienvenido a", "fontsize", 26, "position",[130 330 230 50], "backgroundcolor", "white");
  uicontrol("style", "text", "string", "SIEL", "fontsize", 26, "foregroundcolor", "red", "position",[350 330 100 50], "backgroundcolor", "white");
  uicontrol("style", "text", "string", "Integrantes, Grupo :", "fontsize", 14, "foregroundcolor", "blue", "position",[150 264 260 50], "backgroundcolor", "white");
  uicontrol("style", "text", "string", integrantes, "fontsize", 12, "foregroundcolor", "blue", "fontangle", "italic", "position",[175 156 200 110], "backgroundcolor", "white");
  uicontrol("string", "Ingresar", "position",[210 52 150 36], "callback", "primerIngreso");
endfunction

#Primer ingreso de datos
function primerIngreso
  global h;
  close(h);
  global A;
  
  A =[];
  ingresaMatriz;
  principal;
endfunction

#Ingreso de Matriz
function ingresaMatriz
  global A;

  #solo se encarga del ingreso de una matriz
  #deberemos ingresarla de la forma [fila1;fila2;....;filan] cada fila tiene
  #la forma elemento1,elemento2,...,elementon
  prompt = {'Ingrese la matriz:'};
  title = 'Matriz';
  rows = [1,20];
  defaults = {"3","2"};
  answer = inputdlg(prompt,title,rows,defaults);
  A = answer;

endfunction

#Principal 
function principal 
global h;

h = figure("name", "SIEL", "position", [330,95,780,500], "graphicssmoothing", "on");

btn_ingresar = uimenu("label", "Ingresar");
  btn_matriz = uimenu(btn_ingresar,"label","Ingresar Matriz","callback","ingresaMatriz");

btn_diagonales = uimenu("label", "Diagonales");
  btn_dominante = uimenu(btn_diagonales,"label", "Dominante","callback","diagonalDominante");
  btn_dominanteestricto = uimenu(btn_diagonales,"label", "Dominante Estricto","callback","diagonalEstrictamenteDominante");

btn_normas = uimenu("label", "Normas");
  btn_norma1 = uimenu(btn_normas,"label", "Norma 1","callback","norma1");
  btn_norma2 = uimenu(btn_normas,"label", "Norma 2","callback","norma2");
  btn_normainf = uimenu(btn_normas,"label", "Norma Infinito","callback","normaInfinito");

btn_metodos = uimenu("label", "Metodos");
  btn_jacobi = uimenu(btn_metodos,"label", "Jacobi", "callback", "jacobi");
  btn_gauss = uimenu(btn_metodos,"label", "Gauss Seidel", "callback", "gaussseidel");
  
btn_salir = uimenu("label", "Salir","callback","salirPrograma");

endfunction


function salirPrograma
  global h;
  close(h);
endfunction

################################################################################

################################################################################

#Funciones

#obetenemos la respuesta del input
#A=answer{1};

#aca se pisa el valor para probar las funciones
#si se quiere probar las funciones a partir del
#GUI hay que comentar esta linea

function diagonalDominante(A)
  [filas,columnas]=size(A);
   noDiagDom = 0;
      for f=1:1:filas
          sumaFila = 0;
          for c=1:1:columnas
             sumaFila = sumaFila + abs(A(f,c))
          end
          if (abs(A(f,f)) < (sumaFila-abs(A(f,f))))
               noDiagDom = 1
          end
       end
       if (noDiagDom ==1)
          mensaje = "La matriz no es Diagonal Dominamte"
       else
          mensaje = "La matriz es Diagonal Dominante"
       end
endfunction   

function diagonalEstrictamenteDominante(A)
  [filas,columnas]=size(A);
   noDiagDom = 0;
      for f=1:1:filas
          sumaFila = 0;
          for c=1:1:columnas
              sumaFila = sumaFila + abs(A(f,c))
          end
          if (abs(A(f,f)) <= (sumaFila- abs(A(f,f))))
               noDiagDom = 1
          end
       end
       if (noDiagDom ==1)
          mensaje = "La matriz no es Diagonal Estrictamente Dominamte"
       else
          mensaje = "La matriz es Diagonal Estrictamente Dominante"
       end
endfunction 

function maxSumaColumnas = norma1(A)
  [filas,columnas]=size(A);
  maxSumaColumnas = 0;
  for c=1:1:columnas
    sumaColumna = 0;
    for f=1:1:filas
      sumaColumna = sumaColumna + abs(A(f,c))
    end
    if(sumaColumna > maxSumaColumnas)
      maxSumaColumnas = sumaColumna;
     end
  end
  return;      
endfunction

function retnorm = norma2(A)
  #Traspuesta
  AT = A';
  #Producto de la matriz por su traspuesta
  AAT = AT*A;
  #Obtenemos los Autovalores
  [P,D]=eig(AAT);
  [filas,columnas] = size(D);
  retnorm = 0
  maxAutov = 0;
  val = 0;
  #Busco el maximo autovalor de AAT
  for f=1:1:filas
    val = abs(D(f,f));
    if(val > maxAutov)
      maxAutov = val;
    end
  end
  retnorm = sqrt(maxAutov);
  return;
endfunction

function maxSumaFilas = normaInfinito(A)
  [filas,columnas]=size(A);
  maxSumaFilas = 0;
  for f=1:1:filas
    sumaFila = 0;
    for c=1:1:columnas
      sumaFila = sumaFila + abs(A(f,c))
    end
    if(sumaFila > maxSumaFilas)
      maxSumaFilas = sumaFila;
    end
  end
  return; 
endfunction
