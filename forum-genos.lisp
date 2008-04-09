(in-package #:goiaba)

(let* ((contorno-1 '((0 0) (1 5) (2 3) (3 4) (4 1) (5 3) (6 2) (7 1))))
  (ponto-medio-duracao contorno-1))

(let* ((contorno-1 '((0 0) (1 5) (2 3) (3 4) (4 1) (5 3) (6 2) (7 1))))
  (plot-contorno contorno-1 "titulo: contorno-1" "contorno-1")
  (plot-contorno (retrogradar-contorno contorno-1) "titulo: retrogrado" "retrogrado")
  (plot-contorno (transpor-contorno contorno-1 5) "titulo: transposto" "transposto")
  (plot-contorno (transpor-contorno (inverter-contorno contorno-1 0) 5) "titulo: invertido e transposto" "invertido")
  (plot-contorno (aumentar-altura contorno-1 2) "titulo: altura aumentada" "altura-aum")
  (plot-contorno (rotar-contorno contorno-1 1) "titulo: rotado" "rotado")
  (plot-contorno (insere-ponto contorno-1 '(8 9)) "titulo: inserido" "inserido")
  )

;; (ver "contorno-1")

(preview "contorno-1" "retrogrado" "transposto" "invertido" "altura-aum" "rotado" "inserido")