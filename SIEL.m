A=[];
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



