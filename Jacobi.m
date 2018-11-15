vectorInicial = [0;0;0;0]

function metodoJacobi(vectorInicial,corte,decimales,matrizT,matrizC)
  matrizIncognita = vectorInicial;
  flagInicial = 1;
  [fila,columna] = size(matrizT);
  matrizResultado = [];
  error = 0;
  
   while (error > corte | flagInicial)
     for h=1:1:10 
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
      end  
   endwhile
endfunction

prueba = 1
while(prueba)
  matrizT = [0,1/10,-1/5,0;1/11,0,1/11,-3/11;-1/5,1/10,0,1/10;0,-3/8,1/8,0]
  matrizC = [6/10;25/11;-11/10;15/8]
  corte = 0.001
  decimales = 4
  metodoJacobi(vectorInicial,corte,decimales,matrizT,matrizC);
  prueba = 0
endwhile