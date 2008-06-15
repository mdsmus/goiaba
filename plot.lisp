(in-package #:goiaba)

(use-package :pdf)

(defun agrupa-por-3 (lista)
  (loop for x from 0 to (- (length lista) 3) by 3 collect
	(subseq lista x (+ x 3))))

(defun make-lista-cores (lista)
  (loop for (contorno nome cor) in lista collect
	(list nome (get-color cor))))

(defun plot-contorno-full (x y &rest lista-contornos)
  "Plota uma sucessão de contornos no formato <contorno nome cor> no
mesmo grafico. X e y determinam onde o gráfico aparece na página."
  (let ((lista (agrupa-por-3 lista-contornos)))
    (pdf:draw-object
     (make-instance 'pdf:plot-xy :x x :y y :width 400 :height 300
		    :labels&colors (make-lista-cores lista)
		    :series (mapcar #'contorno->lista (mapcar #'first lista))
		    :y-axis-options '(:min-value 0)
		    :x-axis-options '(:min-value 0)))))

(defun plot-contorno (x y nome contorno)
  "Plota um único contorno"
  (pdf:draw-object
   (make-instance 'pdf:plot-xy :x x :y y :width 250 :height 150
		  :labels&colors (list (list nome (get-color :black)))
		  :series (list (contorno->lista
				 (typecase contorno
				   (contorno-simples (converter contorno))
				   (contorno-duracao contorno)
				   (t (error "tipo de contorno errado")))))
		  :y-axis-options '(:min-value 0)
		  :x-axis-options '(:min-value 0))))

(defun plot-figura (contorno nome arquivo)
  (let ((*default-page-bounds* #(0 650 280 850)))
    (pdf:with-document ()
      (pdf:with-page ()
	(plot-contorno 50 680 nome contorno))
      (pdf:write-document arquivo))))

(defmacro plot-page (file &body body)
  `(pdf:with-document ()
     (pdf:with-page ()
       ,@body)
       (pdf:write-document ,file)))

;; (let ((c1 (make-contorno-duracao-lista '((0 0) (1 5) (2 3) (3 4) (4 1) (5 3) (6 2) (7 1)))))
;;   (with-document ()
;;     (with-page ()
;;       (plot-contorno-full 50 500
;; 			  c1 "original" :red
;; 			  (transpor c1 2) "transposição" :green
;; 			  (retrogradar c1) "retrógrado" :blue
;; 			  (inverter c1) "inversão" :pink
;; 			  (aumentar-altura c1 2) "aumentar-altura" :lightblue
;; 			  (rotacionar c1 1) "rotação" :darkcyan
;; 			  (insere-ponto c1 '(1 3) 2) "insere ponto" :purple)
;;       (plot-contorno 50  300 "original" c1)
;;       (plot-contorno 300 300 "transposição" (transpor c1 2))
;;       )
;;     (write-document "/tmp/foo.pdf")
;;     ))


;; (let ((c1 #d(#p(0 0) #p(1 5) #p(2 3) #p(3 4) #p(4 1) #p(5 3))))
;;   (let ((*default-page-bounds* #(0 380 570 750)))
;;     (plot-page "/tmp/foo.pdf"
;;       (plot-contorno-full 50 420
;; 			  c1 "original" :red
;; 			  (transpor c1 2) "transposição" :green
;; 			  (retrogradar c1) "retrógrado" :blue
;; 			  (inverter c1) "inversão" :pink
;; 			  (aumentar-altura c1 2) "aumentar-altura" :lightblue
;; 			  (rotacionar c1 1) "rotação" :darkcyan
;; 			  (insere-ponto c1 '(1 3) 2) "insere ponto" :purple))))

;; (plot-figura (make-contorno-duracao-lista '((0 0) (1 5) (2 3) (3 4) (4 1) (5 3) (6 2) (7 1)))
;; 	     "original"
;; 	     "/tmp/figura.pdf")
