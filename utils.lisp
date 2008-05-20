(in-package #:goiaba)

(defun last1 (lista)
  (first (last lista)))

(defun positivo-ou-negativo (numero)
  "Retorna 1 para positivo, -1 para negativo e 0 para 0."
    (if (zerop numero)
        0
        (/ numero (abs numero))))

(defun concat (&rest string)
  "Concatena strings."
  (apply #'concatenate 'string string))

