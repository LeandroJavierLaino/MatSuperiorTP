format

function verificador = verificadorMatrizCuadrada(A)
  [filas,columnas]=size(A)
  if (filas == columnas)
     verificador = 1
  else 
     verificador = 0
  endif
endfunction

function diagEstrictaDom = diagonalEstrictamenteDominante(A)
  [filas,columnas]=size(A);
  diagEstrictaDom = 0;
  flagControl = 1;
      for f=1:1:filas
          sumaFila = 0;
          for c=1:1:columnas
              sumaFila = sumaFila + abs(A(f,c));
          end
          if ((abs(A(f,f)) > (sumaFila- abs(A(f,f)))) && flagControl)
               diagEstrictaDom = 1;
          else 
               diagEstrictaDom = 0;
               flagControl = 0;
          end
       end
    
endfunction 

function diagDom= diagonalDominante(A)
  [filas,columnas]=size(A);
   diagDom = 0;
   flagControl = 1;
      for f=1:1:filas
          sumaFila = 0;
          for c=1:1:columnas
             sumaFila = sumaFila + abs(A(f,c));
          end
          if ((abs(A(f,f)) >= (sumaFila-abs(A(f,f)))) && flagControl)
               diagDom = 1;
           else 
               diagDom = 0;
               flagControl = 0;
          end
       end
    
endfunction   

function matrizIndependientes = terminosIndependientes()
  mensajesTextBoxIndependientes = {"Ingrese los terminos independientes separados por punto y coma(;)"};
  formatoTextBoxes = [0.5];
  matrizIndependientes = inputdlg(mensajesTextBoxIndependientes, "SIEL - Ingresar terminos independientes", formatoTextBoxes);
endfunction


function matrizCoeficientes = coeficientesDeMatriz()
  mensajesTextBoxCoeficientes = {"Ingrese los coeficientes de la fila separados por coma"};
  formatoTextBoxes = [0.5];
  matrizCoeficientes = inputdlg(mensajesTextBoxCoeficientes, "SIEL - Ingresar coeficientes", formatoTextBoxes);
endfunction



prueba=1
while(prueba)
        coeficiente = coeficientesDeMatriz()
        datoMatriz = str2num (coeficiente{1})
        coeficientesMatriz = [datoMatriz]
        esCuadrada = verificadorMatrizCuadrada (coeficientesMatriz);
        if esCuadrada == 1
          if (isempty(coeficientesMatriz))
             mensaje1= "No ha ingresado una matriz con formato valido"
          else  
             if (diagonalEstrictamenteDominante(coeficientesMatriz))
                mensaje1 = "La matriz es Diagonal Estrictamente Dominante"
                noCondicion = 0;
             elseif (diagonalDominante(coeficientesMatriz))
                mensaje2 = "La matriz es Diagonal Dominante"
                noCondicion = 0;
             else
                mensaje3 = "La matriz no cumple con condicion de diagonal dominante"
                noCondicion = 1;
             endif   
          endif
        else 
             mensaje4 = "La matriz ingresada no cumple con la condicion de ser cuadrada"
             noCondicion = 1; 
        endif  
        if noCondicion == 0
        indep = terminosIndependientes()
        termIndependientes = str2num (indep{1})
        independientesMatriz = [termIndependientes]
        endif
    prueba=0

endwhile

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
  AT = A'
  #Producto de la matriz por su traspuesta
  AAT = AT*A
  #Obtenemos los Autovalores
  [P,D]=eig(AAT)
  [filas,columnas] = size(D)
  retnorm = 0
  maxAutov = 0
  val = 0
  #Busco el maximo autovalor de AAT
  for f=1:1:filas
    val = abs(D(f,f))
    if(val > maxAutov)
      maxAutov = val
    end
  end
  retnorm = sqrt(maxAutov)
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


