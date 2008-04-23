(defclass ponto ()
    ((args :accessor args :initarg :args)))

(defclass contorno-simples (ponto)
  ((args :accessor args :initarg :args)))

(defclass contorno-com-duracao (contorno-simples)
  ((args :accessor args :initarg :args)))

(defclass classe-de-contorno (contorno-com-duracao)
  ((args :accessor args :initarg :args)))

(defclass contour-adjacency-series ()
  ((args :accessor args :initarg :args)))

(defclass matriz-de-comparacao ()
  ((args :accessor args :initarg :args)))

(defun make-ponto (args)
  (make-instance 'ponto :args args))

(defun make-contorno-com-duracao (args)
  (make-instance 'contorno-com-duracao :args args))

(defun make-contorno-simples (args)
  (make-instance 'contorno-simples :args args))

(defun make-matriz-de-comparacao (args)
  (make-instance 'contorno-simples :args args))

(defun make-classe-de-contorno (args)
  (make-instance 'classe-de-contorno :args args))

(defun make-contour-adjacency-series (args)
  (make-instance 'contour-adjacency-series :args args))
