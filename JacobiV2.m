vectorInicial = [0;0;0;0]
vectorInicial = [0;0]


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

prueba = 1
while(prueba)
  matrizCoeficientes = [10,-1,2,0;-1,11,-1,3;2,-1,10,-1;0,3,-1,8]
  matrizCoeficientes =[3,1;2,4]
  matrizIndependientes = [6;25;-11;15]
  matrizIndependientes = [1;2]
  corte = 0.001
  decimales = 4
  metodoJacobi(vectorInicial,corte,decimales,matrizCoeficientes,matrizIndependientes);
  prueba = 0
endwhile