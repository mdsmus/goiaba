(in-package #:goiaba)

(defmethod matriz-de-comparacao ((objeto contorno-simples))
  "Gera a matriz de comparação de um contorno em codificação simples."
  (make-contorno-simples
   (loop for y in (pontos objeto)
      collect (loop for x in (pontos objeto)
                 collect (positivo-ou-negativo (- x y))))))

(defmethod matriz-de-comparacao ((objeto contorno-duracao))
  "Gera a matriz de comparação de um contorno em codificação simples."
  (make-contorno-simples
   (loop for y in (pontos (converter objeto))
      collect (loop for x in (pontos (converter objeto))
                 collect (positivo-ou-negativo (- x y))))))
