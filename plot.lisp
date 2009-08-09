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

(defun plot-contorno (x y nome contorno &key (width 250) (height 250) (line-color :black)
                      (font-size 7.0) (grid-line-width 0.5) (grid-line-color :black)
                      (line-width 1) (legend-font-size 7.0))
  "Plota um único contorno"
  (pdf:draw-object
   (make-instance 'pdf:plot-xy :x x :y y :width width :height height
		  :labels&colors (list (list nome (get-color line-color)))
                  :h-lines-width grid-line-width
                  :h-lines-color (get-color grid-line-color)
                  :line-width line-width
		  :series (list (contorno->lista
				 (typecase contorno
				   (contorno-simples (converter contorno))
				   (contorno-duracao contorno)
				   (t (error "tipo de contorno errado")))))
		  :legend-options `(:label-font-size ,legend-font-size)
		  :y-axis-options `(:min-value 0
				    :label-font-size ,font-size)
		  :x-axis-options `(:min-value 0
				    :label-font-size ,font-size))))

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

(defun plot-contorno-full-to-file (name xdim ydim bounds &rest lista-contornos)
  (let ((*default-page-bounds* bounds))
    (plot-page name
      (apply #'plot-contorno-full xdim ydim lista-contornos))))

(defun simple-plot (&rest contornos)
  (apply #'plot-contorno-full-to-file "/tmp/foo.pdf" 50 50 #(0 0 580 400) contornos))

;; (plot-contorno-full 50 500
;; 		    c1 "original" :red
;; 		    (transpor c1 2) "transposição" :green
;; 		    (retrogradar c1) "retrógrado" :blue
;; 		    (inverter c1) "inversão" :pink
;; 		    (aumentar-altura c1 2) "aumentar-altura" :lightblue
;; 		    (rotacionar c1 1) "rotação" :darkcyan
;; 		    (insere-ponto c1 '(1 3) 2) "insere ponto" :purple)

;; (let ((c1 (make-contorno-duracao-lista '((0 0) (1 5) (2 3) (3 4) (4 1) (5 3) (6 2) (7 1)))))
;;   (with-document ()
;;     (with-page ()
;;       (plot-contorno 50  300 "original" c1 :width 150 :height 150 :font-size 12.0
;;                      :grid-line-width 1 :grid-line-color :red :line-color :green
;;                      :line-width 1.5 :legend-font-size 20.0))
;;     (write-document "/tmp/foo.pdf")))

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
