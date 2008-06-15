(in-package #:goiaba)

;;; pontos
(defclass ponto ()
  ((x :accessor ponto-x :initarg :x)
   (y :accessor ponto-y :initarg :y)))

(defmethod print-object ((obj ponto) stream)
  (format stream "#p(~d ~d)" (ponto-x obj) (ponto-y obj)))

(defun make-ponto (x y)
  (make-instance 'ponto :x x :y y))

(defun make-ponto-lista (lista)
  (destructuring-bind (x y) lista
    (make-ponto x y)))

(defun %make-ponto (stream subchar arg)
  (declare (ignore subchar arg))
  (destructuring-bind (x y) (read stream t nil t)
    (make-instance 'ponto :x x :y y)))

(set-dispatch-macro-character #\# #\P #'%make-ponto)

;;; contorno com duração
(defclass contorno-duracao ()
  ;; guarda os pontos em uma lista
  ((pontos :accessor pontos :initarg :pontos)))

(defmethod print-object ((obj contorno-duracao) stream)
  (format stream "#D(~{~a~^ ~})" (pontos obj)))

(defun %make-contorno-duracao (stream subchar arg)
  (declare (ignore subchar arg))
  (make-instance 'contorno-duracao :pontos (read stream t nil t)))

(set-dispatch-macro-character #\# #\D #'%make-contorno-duracao)

(defun make-contorno-duracao (lista-de-pontos)
  (make-instance 'contorno-duracao :pontos lista-de-pontos))

(defun map-contorno-duracao (fn lista)
  (make-contorno-duracao (mapcar fn lista)))

(defun make-contorno-duracao-lista (lista)
  "Cria contorno a partiro de uma lista de pares. Cada lista de pares
é convertida para o tipo ponto."
  (map-contorno-duracao #'make-ponto-lista lista))

;;; contorno simples
(defclass contorno-simples ()
  ((pontos :accessor pontos :initarg :pontos)))

(defmethod print-object ((obj contorno-simples) stream)
  (format stream "#S(~{~a~^ ~})" (pontos obj)))

(defun %make-contorno-simples (stream subchar arg)
  (declare (ignore subchar arg))
  (make-instance 'contorno-simples :pontos (read stream t nil t)))

(set-dispatch-macro-character #\# #\S #'%make-contorno-simples)

(defun make-contorno-simples (lista)
  (make-instance 'contorno-simples :pontos lista))

(defun map-contorno-simples (fn lista)
  (make-contorno-simples (mapcar fn lista)))

;; (defclass classe-de-contorno (contorno-simples)
;;   ((valor :accessor valor :initarg :valor)))

;; (defclass contour-adjacency-series ()
;;   ((valor :accessor valor :initarg :valo)))

(defgeneric aumentar-altura (objeto fator))
(defgeneric aumentar-duracao (objeto fator))
(defgeneric converter (objeto))
(defgeneric inverter (objeto &optional eixo))
(defgeneric maior-altura (objeto))
(defgeneric maior-duracao (objeto))
(defgeneric menor-altura (objeto))
(defgeneric menor-duracao (objeto))
(defgeneric ordena-duracao-crescente (objeto))
(defgeneric ponto-medio-altura (objeto))
(defgeneric ponto-medio-duracao (objeto))
(defgeneric remover-alturas-repetidas (objeto))
(defgeneric remover-duplicatas (objeto))
(defgeneric retrogradar (objeto))
(defgeneric retrogradar-inverte (objeto eixo))
(defgeneric rotacionar (objeto &optional fator))
(defgeneric transpor (objeto fator))
