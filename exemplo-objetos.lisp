(defun ponto-medio-x (pares)
  (let ((maior (first (sort (mapcar #'first pares) #'>)))
        (menor (first (sort (mapcar #'first pares) #'<))))
    (/ (+ maior menor) 2)))

(defun retrogradar-ponto (par eixo)
  (let ((x (first par))
        (y (second par)))
    (list (- (* 2 eixo) x) y)))

(defclass contorno-com-duracao ()
  ((args :accessor args :initarg :args)))

(defclass classe-de-contorno ()
  ((args :accessor args :initarg :args)))

(defmethod retrogradar ((objeto contorno-com-duracao))
  (reverse
   (mapcar #'(lambda (par) (retrogradar-ponto par (ponto-medio-x (args objeto))))
           (args objeto))))

(defmethod retrogradar ((objeto classe-de-contorno))
  (reverse (args objeto)))

(defparameter cont (make-instance 'contorno :args '((0 1) (0 0))))
(defparameter cc (make-instance 'classe-de-contorno :args '(1 0)))

(defun make-contorno-com-duracao (args)
  (make-instance 'contorno-com-duracao :args args))

(defun make-cc (args)
  (make-instance 'classe-de-contorno :args args))

; exemplos
;(retrogradar (make-contorno '((0 2)(1 1))))
;(retrogradar (make-cc '(0 2 1)))