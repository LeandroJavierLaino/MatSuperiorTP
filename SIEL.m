#GUI
#solo se encarga del ingreso de una matriz
#deberemos ingresarla de la forma [fila1;fila2;....;filan] cada fila tiene
#la forma elemento1,elemento2,...,elementon
#prompt = {'Ingrese la matriz:'};
#title = 'SIEL';
#answer = inputdlg(prompt,title);

msg ={'Ingrese matirz:'};
titulo = 'Normas';
btn = questdlg (msg, title, "Norma 1", "Norma 2", "Norma Infinito", "Norma 1");
if (strcmp (btn,"Norma 1"))
#solo se encarga del ingreso de una matriz
#deberemos ingresarla de la forma [fila1;fila2;....;filan] cada fila tiene
#la forma elemento1,elemento2,...,elementon
prompt = {'Ingrese la matriz:'};
title = 'SIEL';
answer = inputdlg(prompt,title);
h=warndlg(num2str( norma1(A)),"Norma 1");
endif
if (strcmp (btn,"Norma 2"))

endif
if (strcmp (btn,"Norma Infinito"))

endif
  
#Funciones
#obetenemos la respuesta del input
A=answer{1};

#aca se pisa el valor para probar las funciones
#si se quiere probar las funciones a partir del
#GUI hay que comentar esta linea
#A=[3,1;2,4];

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
