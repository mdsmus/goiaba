(in-package #:goiaba)

(defun matriz-de-comparacao (classe-de-contorno)
  "Retorna a matriz de comparacao de um contorno a partir de seu
classe-de-contorno."
  (loop
     for y in classe-de-contorno
     collect (loop
                for x in classe-de-contorno
                collect (positivo-ou-negativo (- x y)))))

(defun inverte-matriz-de-comparacao (matriz-de-comparacao)
  "Retorna a inversão da matriz de comparação de um contorno."
  (loop
     for linha in matriz-de-comparacao
     collect (loop
                  for elemento in linha
                  collect (* -1 elemento))))

(defun contour-reduction-algorithm (classe-de-contorno)
  (let ((contorno-com-duracao (contorno-simples->contorno-com-duracao classe-de-contorno)))
    (maior-altura-contorno contorno-com-duracao)))