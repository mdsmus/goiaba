(in-package :goiaba)
(use-package :lisp-unit)

(define-test intervalo
  (assert-equal 1 (intervalo 1 2))
  (assert-equal -1 (intervalo 2 1))
  )

(define-test subtrair-elementos
  (assert-equal 1 (subtrair-elementos 2 1))
  (assert-equal -1 (subtrair-elementos 1 2))
  )

(define-test inverter-elemento
  (assert-equal 3 (inverter-elemento 1 2))
  (assert-equal -1 (inverter-elemento 1 0))
  (assert-equal 1 (inverter-elemento 3 2))
  )

;;

(define-test rotate
  (assert-equal '(3 2 4 5 7 1) (rotate '(1 3 2 4 5 7)))
  (assert-equal '(2 4 5 7 1 3) (rotate '(1 3 2 4 5 7) 2))
  (assert-equal '(2 1) (rotate '(1 2)))
  )

(define-test intervalos
  (assert-equal '(2 -1 2 1 2) (intervalos '(1 3 2 4 5 7)))
  (assert-equal '(1) (intervalos '(1 2)))
  )

(define-test subtrair-lista-indice
  (assert-equal '(-1 1 0 2 3 5) (subtrair-lista-indice '(1 3 2 4 5 7) 2))
  (assert-equal '(4 6 5 7 8 10) (subtrair-lista-indice '(1 3 2 4 5 7) -3))
  )

(define-test inverter-lista
  (assert-equal '(3 1 2 0 -1 -3) (inverter-lista '(1 3 2 4 5 7) 2))
  (assert-equal '(-1 -3 -2 -4 -5 -7) (inverter-lista '(1 3 2 4 5 7) 0))
  )

(define-test ponto-medio-lista
  (assert-equal 4 (ponto-medio-lista '(1 3 2 4 5 7)))
  (assert-equal 4 (ponto-medio-lista '(1 7)))
  (assert-equal 4 (ponto-medio-lista '(1 0 8 7)))
  )
