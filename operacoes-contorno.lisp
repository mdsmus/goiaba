(in-package #:goiaba)

;; funções relacionadas a pares




(defun insere-ponto (contorno ponto)
  "Insere um ponto em um contorno de um único segmento."
  (ordena-crescente-duracao (list (first contorno) ponto (second contorno))))




(defmethod retrogradar ((objeto list))
  (if (consp (first objeto))
      (retrogradar (make-contorno-com-duracao objeto))
      (retrogradar (make-contorno-simples objeto))))


