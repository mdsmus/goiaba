(in-package #:goiaba)

(defmethod transpor ((obj ponto) fator)
  "Transpõe um ponto de um contorno a partir de um dado fator."
  (make-ponto (ponto-x obj)
              (+ (ponto-y obj) fator)))

(defmethod inverter ((obj ponto) &optional (eixo 0))
  "Inverte um ponto de um contorno em relação à altura a partir de um
dado eixo."
  (make-ponto (ponto-x obj)
              (- (* 2 eixo) (ponto-y obj))))

(defmethod retrogradar ((obj ponto))
  (make-ponto (ponto-y obj) (ponto-x obj)))

(defmethod inverter-por-y ((obj ponto) eixo)
  "Inverte um ponto de um contorno em relação à duração a partir
de um dado eixo. Esta função é útil para retrogradar um contorno."
  (make-ponto (- (* 2 eixo) (ponto-x obj))
              (ponto-y obj)))

(defmethod aumentar-altura ((obj ponto) fator)
  "Multiplica a altura de um ponto por um dado fator."
  (make-ponto (ponto-x obj)
              (* (ponto-y obj) fator)))

(defmethod aumentar-duracao ((obj ponto) fator)
  "Multiplica a duração de um ponto por um dado fator."
  (make-ponto (* (ponto-x obj) fator)
              (ponto-y obj)))

