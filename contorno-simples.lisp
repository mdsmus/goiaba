(in-package #:goiaba)

(enable-sharp-l-syntax)

(defmethod converter ((objeto contorno-duracao))
  "Retorna um contorno representado por uma lista de alturas a partir
 de um contorno representado por pares coordenados."
  (map-contorno-simples #'ponto-y (pontos objeto)))

(defmethod converter ((objeto contorno-simples))
  "Retorna um contorno representado por pares coordenados a partir de
uma lista de alturas (contorno simples)."
  (make-contorno-duracao
   (loop
         for elemento in (pontos objeto)
         for n from 0 to (length (pontos objeto))
         collect (make-ponto n elemento))))

(defmethod menor-altura ((objeto contorno-simples))
  "Retorna a menor altura de um contorno em codificação simples."
  (first (sort (pontos objeto) #'<)))

(defmethod maior-altura ((objeto contorno-simples))
  "Retorna a maior altura de um contorno em codificação simples."
  (first (sort (pontos objeto) #'>)))

(defmethod transpor ((objeto contorno-simples) fator)
  "Transpõe um contorno em codificação simples a partir de um dado
fator."
  (map-contorno-simples #L(+ !1 fator) (pontos objeto)))

(defmethod inverter ((objeto contorno-simples) &optional eixo)
  "Inverte um contorno em codificação simples em relação à altura a
partir de um dado eixo."
  (let* ((eixo (or eixo (ponto-medio-altura (converter objeto)))))
    (map-contorno-simples #L(- (* 2 eixo) !1) (pontos objeto))))

(defmethod retrogradar ((objeto contorno-simples))
  "Retrograda um contorno em codificação simples."
  (make-contorno-simples (reverse (pontos objeto))))

(defmethod rotacionar ((objeto contorno-simples) &optional (fator 1))
  "Rotaciona um contorno em codificação simples a partir de um dado
fator."
  (make-contorno-simples (append (subseq (pontos objeto) fator)
                                 (subseq (pontos objeto) 0 fator))))
