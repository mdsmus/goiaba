(in-package #:goiaba)

;; marcos "f e' cis ais, a gis c' cis g,"
;; korsakov "e b, d' c b, c' g, ais fis a f"

(let* ((melodia "e b, d' c b, c' g, ais fis a f")
       (altura "'")
       (coordenadas "0 8 45 75")
       (contorno (simple-lily->contorno-com-duracao melodia))
       (contorno-simples (contorno-com-duracao->contorno-simples contorno))
       (classe (contorno-simples->contorno-com-duracao (cc contorno))))
  (print (contorno-com-duracao->contorno-simples classe))
  (plot-contorno contorno "O" "o")
  (plot-contorno (retrogradar-contorno contorno) "R" "r")
  (plot-contorno (inverter-contorno contorno 58.5) "I" "i" 0 8 53 64)
  (plot-contorno (retrogradar-contorno (inverter-contorno contorno 58.5)) "RI" "ri" 0 8 53 64)
  (plot-contorno (rotar-contorno contorno) "Rot-1" "rot-1" 0 8 53 64)
  (plot-contorno (rotar-contorno contorno 2) "Rot-2" "rot-2" 0 8 53 64)
  (plot-contorno (rotar-contorno contorno 3) "Rot-3" "rot-3" 0 8 53 64)
  (plot-contorno (rotar-contorno contorno 4) "Rot-4" "rot-4" 0 8 53 64)
  (plot-contorno classe "CC-O" "cc-o")
  (plot-contorno (retrogradar-contorno classe) "CC-R" "cc-r" 0 8 0 7)
  (plot-contorno (inverter-contorno classe 3.5) "CC-I" "cc-i" 0 8 0 7)
  (plot-contorno (retrogradar-contorno (inverter-contorno classe 3.5)) "CC-RI" "cc-ri" 0 8 0 7)
  (plot-contorno (rotar-contorno classe) "cc-rot-1" "cc-rot-1" 0 8 0 7)
  (plot-contorno (rotar-contorno classe 2) "cc-rot-2" "cc-rot-2" 0 8 0 7)
  (plot-contorno (rotar-contorno classe 3) "cc-rot-3" "cc-rot-3" 0 8 0 7)
  (plot-contorno (rotar-contorno classe 4) "cc-rot-4" "cc-rot-4" 0 8 0 7)
  (plot-contorno (retrogradar-contorno (inverter-contorno (rotar-contorno classe) 3.5)) "cc-ri-rot-1" "cc-ri-rot-1" 0 8 0 7))


(preview "t0" "t4" "t1" "t5" "t2" "t6" "t3" "t7" "rot-1" "cc-rot-1" "rot-2" "cc-rot-2" "rot-3" "cc-rot-3" "rot-4" "cc-rot-4" "cc-ri-rot-1")

