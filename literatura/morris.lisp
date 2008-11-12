(in-package #:goiaba)

(defun %matriz (list)
  (loop for y in list
        collect (loop for x in list
                      collect (positivo-ou-negativo (- x y)))))

(defmethod matriz-de-comparacao ((objeto contorno-simples))
  "Gera a matriz de comparação de um contorno em codificação simples."
  (make-contorno-simples (%matriz (pontos objeto))))

(defmethod matriz-de-comparacao ((objeto contorno-duracao))
  "Gera a matriz de comparação de um contorno em codificação com duração."
  (make-contorno-simples (%matriz (pontos (converter objeto)))))

(defmethod print-matriz-de-comparacao ((objeto contorno))
    (let ((contorno (pontos objeto))
          (matriz (pontos (matriz-de-comparacao objeto))))
      (format t "     ~{~2d ~}~%" contorno)
      (format t "~a~%" (repeat-string (+ 6 (* 2 (1+ (length contorno)))) "-"))
      (loop for c in contorno
            for m in matriz do
            (format t "~2d | ~{~2d ~}~%" c m))))
