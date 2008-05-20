(in-package #:goiaba)

;; funções relacionadas a pares

(defmethod menor-altura ((objeto contorno-simples))
  "Retorna a menor altura de um contorno em codificação simples."
  (first (sort (args objeto) #'<)))

(defmethod maior-altura ((objeto contorno-simples))
  "Retorna a maior altura de um contorno em codificação simples."
  (first (sort (args objeto) #'>)))



(defun insere-ponto (contorno ponto)
  "Insere um ponto em um contorno de um único segmento."
  (ordena-crescente-duracao (list (first contorno) ponto (second contorno))))


(defun contorno-simples->contorno-com-duracao (lista-de-alturas)
  "Retorna um contorno representado por pares coordenados a partir de
uma lista de alturas (contorno simples)."
  (loop
     for elemento in lista-de-alturas
     for n from 0 to (length lista-de-alturas)
     collect (list n elemento)))

;;; métodos

(defmethod transpor ((objeto contorno-simples) fator)
  "Transpõe um contorno em codificação simples a partir de um dado
fator."
  (mapcar #'(lambda (ponto) (+ ponto fator)) (args objeto)))

(defmethod inverter ((objeto contorno-simples) &optional eixo)
  "Inverte um contorno em codificação simples em relação à altura a
partir de um dado eixo."
  (let* ((eixo (or eixo (ponto-medio-altura (contorno-simples->contorno-com-duracao (args objeto))))))
    (mapcar #'(lambda (altura) (- (* 2 eixo) altura)) (args objeto))))



(defmethod retrogradar ((objeto list))
  (if (consp (first objeto))
      (retrogradar (make-contorno-com-duracao objeto))
      (retrogradar (make-contorno-simples objeto))))

(defmethod retrogradar ((objeto contorno-simples))
  "Retrograda um contorno em codificação simples."
  (reverse (args objeto)))



(defmethod rotacionar ((objeto contorno-simples) &optional (fator 1))
  "Rotaciona um contorno em codificação simples a partir de um dado
fator."
  (append (subseq (args objeto) fator) (subseq (args objeto) 0 fator)))


