clear
################################################################################
#                                  VARIABLES                                   # 
################################################################################

A = [3,1;2,4];
B = [1;4];
dimension = 2;
incial = [0;0];
decimales = 5;
cotaerror = 0.001;

################################################################################
#                                FUNCIONES                                     #
################################################################################

function noDiagDom = diagonalDominante()
  global A;
  [filas,columnas]=size(A);
   noDiagDom = 0;
      for f=1:1:filas
          sumaFila = 0;
          for c=1:1:columnas
             sumaFila = sumaFila + abs(A(f,c))
          endfor
          if (abs(A(f,f)) < (sumaFila-abs(A(f,f))))
               noDiagDom = 1;
          endif
       endfor
  return;
endfunction   

function noDiagDom = diagonalEstrictamenteDominante()
  global A;
  [filas,columnas]=size(A);
   noDiagDom = 0;
      for f=1:1:filas
          sumaFila = 0;
          for c=1:1:columnas
              sumaFila = sumaFila + abs(A(f,c))
          endfor
          if (abs(A(f,f)) <= (sumaFila- abs(A(f,f))))
               noDiagDom = 1
          endif
       endfor
return;
endfunction 

function maxSumaColumnas = norma1()
  global A;
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

function retnorm = norma2()
  global A;
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

function maxSumaFilas = normaInfinito()
  global A;
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

function maxSumaFilas = normaInfinitoCualquiera(A)
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

################################################################################
#                                   JACOBI
################################################################################
function matrizT = calculoMatrizZ(matrizCoeficientes)
  [fila,columna] = size(matrizCoeficientes);
  diagonal = diag (matrizCoeficientes)
  matrizT = abs(matrizCoeficientes * 0)
  
      for j=1:1:fila
        for h=1:1:columna
          if (j!=h & matrizCoeficientes(j,h)!=0) 
            matrizT(j,h)= ((1/diagonal(j)) * matrizCoeficientes(j,h)) * (-1)
          else 
            matrizT(j,h)= 0
          endif
        end
      end
endfunction      

function matrizC = calculoMatrizC(matrizCoeficientes,matrizIndependientes)
  [fila,columna] = size(matrizIndependientes);
  diagonal = diag (matrizCoeficientes)
  matrizC = abs(matrizIndependientes * 0)
  
      for j=1:1:fila
        for h=1:1:columna
            matrizC(j,h)= ((1/diagonal(j)) * matrizIndependientes(j,h))
        end
      end
endfunction      
          

function metodoJacobi(vectorInicial,corte,decimales,matrizCoeficientes,matrizIndependientes)
  matrizT = calculoMatrizZ(matrizCoeficientes);
  matrizC = calculoMatrizC(matrizCoeficientes,matrizIndependientes);
  matrizIncognita = vectorInicial;
  flagInicial = 1;
  [fila,columna] = size(matrizT);
  matrizResultado = [];
  error = 0;
  output_precision(decimales);
   while (error > corte | flagInicial)
   
        error = 0;
        matrizResultado = matrizT * matrizIncognita + matrizC
        
      for j=1:1:fila
         errorMax = abs(matrizResultado(j) - matrizIncognita(j)) / abs(matrizResultado(j));
         if errorMax > error
            error = errorMax
         endif
      end
      
        matrizIncognita = matrizResultado;
        flagInicial = 0;
       
   endwhile
endfunction
################################################################################
#                                    GAUSS SEIDEL                              #
################################################################################
################################################################################

#GUI
#Bienvenido

function main
  global h = figure("name", "Sistema de Ecuaciones Lineales", "position", [330,140,720,440], "graphicssmoothing", "on", "menubar", "none");
  box on;
  axis off; 
  integrantes = "- Cabaña Damian  1433581 \n- Laiño Leandro 1375260 \n- Pereyra Yohanna - 1224992 \n- Sebastian Zapata - 1166360 \n ";
  
  uicontrol("style", "text", "string", "Bienvenido a", "fontsize", 26, "position",[130 330 230 50], "backgroundcolor", "white");
  uicontrol("style", "text", "string", "SIEL", "fontsize", 26, "foregroundcolor", "red", "position",[350 330 100 50], "backgroundcolor", "white");
  uicontrol("style", "text", "string", "Integrantes, Grupo :", "fontsize", 12, "foregroundcolor", "blue", "position",[150 264 400 50], "backgroundcolor", "white");
  uicontrol("style", "text", "string", integrantes, "fontsize", 12, "foregroundcolor", "blue", "fontangle", "italic", "position",[175 156 200 110], "backgroundcolor", "white");
  uicontrol("string", "Ingresar", "position",[210 52 150 36], "callback", "primerIngreso");
endfunction

#Primer ingreso de datos
function primerIngreso
  global h;
  global A;
  
  close(h);
  
  global A;
  global B;
  global dimension;
  
  A = [3,1;2,4];
  B = [1,4];
  dimension = 2;
  
  ingresaValores;
  principal;
endfunction

#Ingreso de Dimension,Matriz y valores independientes
function ingresaValores
  global A;
  global B;
  global dimension; 
  
  flag = false;
  
  do
    prompt = {'Ingrese la Dimension:'};
    title = 'Dimension';
    answer = inputdlg(prompt,title);
    if(isempty(answer))
      return;
    endif;
    if(str2double(answer)>0)
      dimension = str2double(answer);
      flag = true;
    else
      errordlg("Ingrese un valor mayor a 0");
    endif;
  until(flag);
  
  flag = false;
  
  #solo se encarga del ingreso de una matriz
  #deberemos ingresarla de la forma [fila1;fila2;....;filan] cada fila tiene
  #la forma elemento1,elemento2,...,elementon

  do
    prompt = {'Ingrese un valor: '};
    title = 'Matriz';
    answer = str2num(inputdlg(prompt,title){1});
    if(isempty(answer))
      return;
    endif;
    if (rows(answer) == dimension && columns(answer) == dimension)
      A = answer;
      flag = true;
    else
      errordlg("Las dimensiones no son correctas!");
    endif;
  until(flag);
  
  flag = false;
  
  do
    prompt = {'Ingrese el vector de independientes:'};
    title = 'Independientes';
    answer = str2num(inputdlg(prompt,title){1});
    if(isempty(answer))
      return;
    endif;
    if (rows(answer) == dimension)
      B = answer;
      flag = true;
    else
      errordlg("Las dimensiones no son correctas!");
    endif;
  until(flag);
endfunction

#Ingreso de Independientes
function ingresarIndependientes

  
  prompt = {'Ingrese el vector de independientes:'};
  title = 'Independientes';
  answer = inputdlg(prompt,title);
  B = cell2mat(answer);
  
endfunction  

#Principal 
function principal 
global h;
global A;
global B;

h = figure("name", "SIEL", "position", [330,95,780,500], "graphicssmoothing", "on");

btn_ingresar = uimenu("label", "Ingresar");
  btn_matriz = uimenu(btn_ingresar,"label","Ingresar Valores","callback","ingresaValores");
  
btn_diagonales = uimenu("label", "Diagonales");
  btn_dominante = uimenu(btn_diagonales,"label", "Dominante","callback","esDiagonalDominante");
  btn_dominanteestricto = uimenu(btn_diagonales,"label", "Dominante Estricto","callback","esDiagonalEstrictamenteDominante");

btn_normas = uimenu("label", "Normas");
  btn_norma1 = uimenu(btn_normas,"label", "Norma 1","callback","mostraNorma1");
  btn_norma2 = uimenu(btn_normas,"label", "Norma 2","callback","mostraNorma2");
  btn_normainf = uimenu(btn_normas,"label", "Norma Infinito","callback","mostraNormaInf");

btn_metodos = uimenu("label", "Metodos");
  btn_jacobi = uimenu(btn_metodos,"label", "Jacobi", "callback", "jacobi");
  btn_gauss = uimenu(btn_metodos,"label", "Gauss Seidel", "callback", "gaussseidel");
  
btn_salir = uimenu("label", "Salir","callback","salirPrograma");

panel = uipanel("title", "SIEL", "position", [.15 .20 .7 .65], "backgroundcolor", "white");
  uicontrol("parent", panel, "style", "text", "position", [.0 .0 .7 .5],"string",strcat("El sistema es : ",mat2str(A),"*X",mat2str(B)));
endfunction

function esDiagonalDominante
  global A;

  #panel = uipanel("title", "Es Diagonal Dominante?", "position", [.15 .20 .7 .65]);%, "backgroundcolor", "white");
  noEsDiag = diagonalDominante(A);
  if (noEsDiag == 1)
    #uicontrol("parent", panel, "style", "text", "string","No es diagonal dominante");
    errordlg(strcat(mat2str(A)," No es diagonal dominante!"));
  else
    errordlg(strcat( mat2str(A)," Es diagonal dominante!"));
    #uicontrol("parent", panel, "style", "text", "string","Es diagonal dominante");
  endif;
  
endfunction

function esDiagonalEstrictamenteDominante
  global A;
  
  esEstricto = diagonalEstrictamenteDominante(A)
  
  if (esEstricto == 1)
    #uicontrol("parent", panel, "style", "text", "string","No es diagonal dominante");
    errordlg(strcat(mat2str(A)," No es diagonal dominante estricto!"));
  else
    errordlg(strcat(mat2str(A)," Es diagonal dominante estricto!"));
    #uicontrol("parent", panel, "style", "text", "string","Es diagonal dominante");
  endif;
  
endfunction

function mostraNorma1
  global A;
  
  errordlg(cstrcat("La norma 1 es : ", num2str(norma1(A))));
  
endfunction

function mostraNorma2
  global A;
  
  errordlg(cstrcat("La norma 2 es : ", num2str(norma2(A))));
  
endfunction

function mostraNormaInf
  global A;
  
  errordlg(cstrcat("La norma infinito es : ", num2str(normaInfinito(A))));
  
endfunction

function jacobi
  global inicial;
  global decimales;
  global cotaerror;
  global A;
  global B;
  global dimension;
  
  flag = false;
  
  do
    prompt = {'Ingrese el vector Inicial:'};
    title = 'Inicial';
    answer = str2num(inputdlg(prompt,title){1});
    if(isempty(answer))
      return;
    endif;
    if ( not(isempty(answer))&&rows(answer) == dimension)
      inicial = answer;
      flag = true;
    else
      errordlg("Ingrese un vector inicial!");
    endif;
  until(flag);
  
  flag = false;
  do
    prompt = {'Ingrese la cantidad de decimales que desea : '};
    title = 'Inicial';
    answer = str2num(inputdlg(prompt,title){1});
    if(isempty(answer))
      return;
    endif;
    if (not(isempty(answer)))
      decimales = answer;
      flag = true;
    else
      errordlg("Ingrese la cantidad de decimales que desea!");
    endif;
  until(flag);
  
  flag = false;
  
  do
    prompt = {'Ingrese una cota de error : '};
    title = 'Inicial';
    answer = str2num(inputdlg(prompt,title){1});
    if(isempty(answer))
      return;
    endif;
    if (not(isempty(answer)))
      cotaerror = answer;
      flag = true;
    else
      errordlg("Ingrese una cota de error !");
    endif;
  until(flag);
  
  panel = uipanel("title", "SIEL", "position", [.10 .10 .85 .85], "backgroundcolor", "white");
    
  matrizT = calculoMatrizZ(A);
  matrizC = calculoMatrizC(A,B);
  matrizIncognita = inicial;
  [fila,columna] = size(matrizT);
  matrizResultado = [];
  error = 0;
  i=1;
  errorMax = 0;
  resultados = "";
  resultados = strcat("Paso # 0 : ",mat2str(inicial)," \n",resultados);
  do
    error = 0;
    matrizResultado = matrizT * matrizIncognita + matrizC
        
    for j=1:1:fila
      if normaInfinitoCualquiera(matrizResultado(j))!=0
        errorMax = abs(normaInfinitoCualquiera(matrizResultado(j) - matrizIncognita(j))) / abs(normaInfinitoCualquiera(matrizResultado(j)));
        if errorMax > error
          error = errorMax
        endif
      endif
    end
    output_precision(decimales);
    
    if(error > cotaerror)
      resultados = strcat("Paso # ",num2str(i)," : ",mat2str(matrizResultado)," - Criterio : ",num2str(errorMax),">",num2str(error)," \n",resultados);  
    else
      resultados = strcat("Paso # ",num2str(i)," : ",mat2str(matrizResultado)," - Criterio : ",num2str(errorMax),"<",num2str(error)," \n",resultados);  
    endif;
    
    matrizIncognita = matrizResultado;

    i=i+1; 
   until (error < cotaerror)
   resultados = strcat("Error : ",num2str(errorMax)," \n",resultados)
  uicontrol("parent", panel, "style", "text","position", [60 10 600 600], "string",resultados);   
endfunction
#
#GAUSS SEIDEL GAUSS SEIDEL GAUSS SEIDEL GAUSS SEIDEL GAUSS SEIDEL GAUSS SEIDEL
function gaussseidel
  global inicial;
  global decimales;
  global cotaerror;
  global A;
  global B;
  global dimension;
  
  flag = false;
  
  do
    prompt = {'Ingrese el vector Inicial:'};
    title = 'Inicial';
    answer = str2num(inputdlg(prompt,title){1});
    if(isempty(answer))
      return;
    endif;
    if ( not(isempty(answer)&&rows(answer) == dimension))
      inicial = answer;
      flag = true;
    else
      errordlg("Ingrese un vector inicial!");
    endif;
  until(flag);
  
  flag = false;
  do
    prompt = {'Ingrese la cantidad de decimales que desea : '};
    title = 'Inicial';
    answer = str2num(inputdlg(prompt,title){1});
    if(isempty(answer))
      return;
    endif;
    if (not(isempty(answer)))
      decimales = answer;
      flag = true;
    else
      errordlg("Ingrese la cantidad de decimales que desea!");
    endif;
  until(flag);
  
  flag = false;
  
  do
    prompt = {'Ingrese una cota de error : '};
    title = 'Inicial';
    answer = str2num(inputdlg(prompt,title){1});
    if(isempty(answer))
      return;
    endif;
    if (not(isempty(answer)))
      cotaerror = answer;
      flag = true;
    else
      errordlg("Ingrese una cota de error !");
    endif;
  until(flag);
  
  panel = uipanel("title", "SIEL", "position", [.10 .10 .85 .85], "backgroundcolor", "white");
  
  LD = tril(A);
  G = -LD\triu(A,1);
  c = LD\B;
  x=inicial;
  y=inicial;
  [fila,columna]=size(x);

  error = 0;
  resultados = "";
  resultados = strcat("Paso # 0 : ",mat2str(inicial)," \n",resultados);
  n=1;
  do 
    error = 0;
    x = G*y + c;

	  for i = 1:1:fila
      if(x(i)!= 0)
	      errorMax =abs(x(i)-y(i))/abs(x(i));
	      if errorMax > error 
		      error = errorMax
	      endif
      endif
    end	  
	  if(error > cotaerror)
      resultados = strcat("Paso # ",num2str(n)," : ",mat2str(x)," - Criterio : ",num2str(errorMax),">",num2str(cotaerror)," \n",resultados);  
    else
      resultados = strcat("Paso # ",num2str(n)," : ",mat2str(x)," - Criterio : ",num2str(errorMax),"<",num2str(cotaerror)," \n",resultados);  
    endif;
    
    y=x;
    n=n+1;
  until(error < cotaerror);
  resultados = strcat("Error : ",num2str(errorMax)," \n",resultados)
  uicontrol("parent", panel, "style", "text","position", [60 10 600 600], "string",resultados);

endfunction
#

function salirPrograma
  global h;
  close(h);
endfunction

main;