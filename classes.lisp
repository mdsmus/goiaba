(in-package #:goiaba)

;;; pontos
(defclass ponto ()
  ((x :accessor ponto-x :initarg :x)
   (y :accessor ponto-y :initarg :y)))

(defmethod print-object ((obj ponto) stream)
  (format stream "#p{~d ~d}" (ponto-x obj) (ponto-y obj)))

(defun make-ponto (x y)
  (make-instance 'ponto :x x :y y))

(defun %make-ponto (stream subchar arg)
  (declare (ignore subchar arg))
  (destructuring-bind (x y) (read stream t nil t)
    (make-instance 'ponto :x x :y y)))

(set-dispatch-macro-character #\# #\P #'%make-ponto)

;;; contorno com duração
(defclass contorno ()
  ;; guarda os pontos em uma lista
  ((pontos :accessor pontos :initarg :pontos)))

(defmethod print-object ((obj contorno) stream)
  (format stream "#c~a" (pontos obj)))

(defun %make-contorno (stream subchar arg)
  (declare (ignore subchar arg))
  (make-instance 'contorno :pontos (read stream t nil t)))

(set-dispatch-macro-character #\# #\D #'%make-contorno)

(defun make-contorno (lista-de-pontos)
  (make-instance 'contorno :pontos lista-de-pontos))

;; (defclass contorno-simples (contorno)
;;   ((valor :accessor valor :initarg :valor)))

;; (defclass classe-de-contorno (contorno-simples)
;;   ((valor :accessor valor :initarg :valor)))

;; (defclass contour-adjacency-series ()
;;   ((valor :accessor valor :initarg :valo)))

;; (defun make-contorno-simples (stream subchar arg)
;;   (declare (ignore subchar arg))
;;   (make-instance 'contorno-simples :valor (read stream t nil t)))

;; (set-dispatch-macro-character #\# #\S 'make-contorno-simples)

(defgeneric aumentar-altura (objeto fator))
(defgeneric aumentar-duracao (objeto fator))
(defgeneric inverter (objeto &optional eixo))
(defgeneric maior-altura (objeto))
(defgeneric maior-duracao (objeto))
(defgeneric menor-altura (objeto))
(defgeneric menor-duracao (objeto))
(defgeneric ponto-medio-altura (objeto))
(defgeneric ponto-medio-duracao (objeto))
(defgeneric retrogradar (objeto))
(defgeneric retrogradar-inverte (objeto eixo))
(defgeneric rotacionar (objeto &optional fator))
(defgeneric transpor (objeto fator))

