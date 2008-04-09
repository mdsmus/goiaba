(define-test ponto-medio-duracao
  (assert-equal 1 (ponto-medio-duracao '((0 1) (2 4))))
  (assert-equal 2 (ponto-medio-duracao '((0 1) (1 2) (2 4) (3 8) (4 12))))
  )

(define-test ponto-medio-altura
  (assert-equal 3 (ponto-medio-altura '((0 1) (2 5))))
  (assert-equal 6 (ponto-medio-altura '((0 0) (1 2) (2 4) (3 8) (4 12))))
  )

(define-test transpor
  (assert-equal '((0 2)(1 4)) (transpor (make-contorno-com-duracao '((0 1)(1 3))) 1))
  (assert-equal '(6 9 7 5) (transpor (make-contorno-simples '(1 4 2 0)) 5))
  )

(define-test %inverter-ponto
  (assert-equal '(0 -2) (%inverter-ponto '(0 2) 0))
  (assert-equal '(1 7) (%inverter-ponto '(1 9) 8))
  )

(define-test inverter
  (assert-equal '(4 -1 1) (inverter (make-contorno-simples '(0 5 3)) 2))
  (assert-equal '((1 7)(2 13)(4 10)) (inverter (make-contorno-com-duracao '((1 9)(2 3)(4 6))) 8))
  (assert-equal '(4 2 3) (inverter (make-classe-de-contorno '(0 2 1)) 2))
  )

(define-test retrogradar-ponto
  (assert-equal '(-1 2) (retrogradar-ponto '(1 2) 0))
  (assert-equal '(14 9) (retrogradar-ponto '(2 9) 8))
  )

(define-test retrogradar
  (assert-equal '(3 5 0) (retrogradar (make-contorno-simples '(0 5 3))))
  (assert-equal '((1 6)(3 3)(4 9)) (retrogradar (make-contorno-com-duracao '((1 9)(2 3)(4 6)))))
  (assert-equal '(1 2 0) (retrogradar (make-classe-de-contorno '(0 2 1))))
  )

(define-test rotacionar
  (assert-equal '(5 3 0) (rotacionar (make-contorno-simples '(0 5 3))))
  (assert-equal '(3 0 5) (rotacionar (make-contorno-simples '(0 5 3)) 2))
  (assert-equal '((1 3)(2 6)(4 9)) (rotacionar (make-contorno-com-duracao '((1 9)(2 3)(4 6)))))
  (assert-equal '((1 6)(2 9)(4 3)) (rotacionar (make-contorno-com-duracao '((1 9)(2 3)(4 6))) 2))
  (assert-equal '(3 2 0) (rotacionar (make-classe-de-contorno '(0 3 2 1))))
  (assert-equal '(3 2 0) (rotacionar (make-classe-de-contorno '(0 3 2 1)) 2))
  )

(define-test aumentar-altura-ponto
  (assert-equal '(1 4) (aumentar-altura-ponto '(1 2) 2))
  (assert-equal '(2 72) (aumentar-altura-ponto '(2 9) 8))
  )

(define-test aumentar-duracao-ponto
  (assert-equal '(2 2) (aumentar-duracao-ponto '(1 2) 2))
  (assert-equal '(16 9) (aumentar-duracao-ponto '(2 9) 8))
  )

;;

(define-test transpor-contorno
  (assert-equal '((0 3) (1 6) (2 2) (3 8)) (transpor-contorno '((0 1) (1 4) (2 0) (3 6)) 2))
  (assert-equal '((0 5) (1 4)) (transpor-contorno '((0 1) (1 0)) 4))
  )


(define-test inverter-contorno
  (assert-equal '((0 3) (1 0) (2 4) (3 -2)) (inverter-contorno '((0 1) (1 4) (2 0) (3 6)) 2))
  (assert-equal '((0 7) (1 8)) (inverter-contorno '((0 1) (1 0)) 4))
  )

(define-test retrogradar-contorno
  (assert-equal '((0 5) (1 6) (2 0) (3 4) (4 1)) (retrogradar-contorno '((0 1) (1 4) (2 0) (3 6) (4 5))))
  (assert-equal '((0 0) (1 1)) (retrogradar-contorno '((0 1) (1 0))))
  )


(define-test aumentar-altura
  (assert-equal '((0 3) (1 12) (2 0) (3 18) (4 15)) (aumentar-altura '((0 1) (1 4) (2 0) (3 6) (4 5)) 3))
  (assert-equal '((0 2) (1 0)) (aumentar-altura '((0 1) (1 0)) 2))
  )

(define-test aumentar-duracao
  (assert-equal '((0 1) (3 4) (6 0) (9 6) (12 5)) (aumentar-duracao '((0 1) (1 4) (2 0) (3 6) (4 5)) 3))
  (assert-equal '((0 1) (2 0)) (aumentar-duracao '((0 1) (1 0)) 2))
  )

(define-test rotar-contorno
  (assert-equal '((0 6) (1 5) (2 1) (3 4) (4 0)) (rotar-contorno '((0 1) (1 4) (2 0) (3 6) (4 5)) 3))
  (assert-equal '((0 0) (1 2) (2 1)) (rotar-contorno '((0 1) (1 0) (2 2))))
  )

(define-test ordena-crescente-duracao
  (assert-equal '((0 1) (1 2)) (ordena-crescente-duracao '((1 2) (0 1))))
  (assert-equal '((0 1) (1 2) (3 8)) (ordena-crescente-duracao '((1 2) (0 1) (3 8))))
  (assert-equal '((0 1) (1 2) (2 5) (3 8)) (ordena-crescente-duracao '((1 2) (0 1) (3 8) (2 5))))
  )

(define-test insere-ponto
  (assert-equal '((0 1) (1 4) (2 0)) (insere-ponto '((0 1) (2 0)) '(1 4)))
  (assert-equal '((0 1) (2 2) (3 4)) (insere-ponto '((0 1) (2 2)) '(3 4)))
  )

(define-test remover-duplicatas
  (assert-equal '((0 1)) (remover-duplicatas '((0 1) (0 1))))
  (assert-equal '((0 1) (1 3)) (remover-duplicatas '((0 1) (1 3) (0 1))))
  (assert-equal '((0 1) (1 3) (2 4) (3 5) (4 0)) (remover-duplicatas '((0 1) (1 3) (0 1) (2 4) (3 5) (4 0))))
  (assert-equal '((0 1) (1 3) (2 4) (3 5) (4 0)) (remover-duplicatas '((0 1) (1 3) (0 1) (2 4) (3 5) (4 0) (4 0))))
  )

(define-test remover-alturas-repetidas
  (assert-equal '((0 0)) (remover-alturas-repetidas '((0 0) (1 0) (2 0) (3 0))))
  (assert-equal '((0 0) (1 2) (2 1) (5 4)) (remover-alturas-repetidas '((0 0) (1 2) (2 1) (3 0) (4 2) (5 4)))))

(define-test contorno-com-duracao->contorno-simples
  (assert-equal '(1 0) (contorno-com-duracao->contorno-simples '((0 1) (1 0))))
  (assert-equal '(1 0 2) (contorno-com-duracao->contorno-simples '((0 1) (1 0) (2 2)))))

(define-test contorno-simples->contorno-com-duracao
  (assert-equal '((0 1) (1 0)) (contorno-simples->contorno-com-duracao '(1 0)))
  (assert-equal '((0 1) (1 3) (2 2) (3 0)) (contorno-simples->contorno-com-duracao '(1 3 2 0))))
