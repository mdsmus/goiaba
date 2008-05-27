(in-package #:goiaba)

(defun %plot-contorno (x y lista-contornos nome-e-cores)
  (pdf:draw-object
   (make-instance 'pdf:plot-xy :x x :y y :width 400 :height 300
		  :labels&colors nome-e-cores
		  :series (mapcar #'contorno->lista lista-contornos)
		  :y-axis-options '(:min-value 0)
		  :x-axis-options '(:min-value 0))))

(let ((c1 (make-contorno-duracao-lista '((0 0) (1 5) (2 3) (3 4) (4 1) (5 3) (6 2) (7 1)))))
  ;;(plot-contorno (insere-ponto contorno-1 '(8 9))
  (pdf:with-document ()
    (pdf:with-page ()
      (%plot-contorno 50 500 (list c1
				   (transpor c1 2)
				   (retrogradar c1)
				   (inverter c1)
				   (aumentar-altura c1 2)
				   (rotacionar c1 1)
				   (insere-ponto c1 '(1 3) 2)
				 )
		      '(("original" (1.0 0.0 0.0))
			("transposição" (0.0 1.0 0.0))
			("retrógrado" (0.0 0.0 1.0))
			("inversão" (1.0 0.0 1.0))
			("aumentar-altura" (0.0 1.0 1.0))
			("rotação" (1.0 1.0 0.0))
			("insere ponto" (0.0 1.0 0.0))
			)
		      ))
    (pdf:write-document "/tmp/foo.pdf")
    ))
