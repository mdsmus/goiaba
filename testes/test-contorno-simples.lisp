(in-package #:goiaba-testes)

(define-test converter
  (assert-equal #s(3 2 6) (converter #d(#p(0 3) #p(1 2) #p(4 6))))
  (assert-equal #s(3 2 6) (converter #d(#p(1 2) #p(0 3) #p(4 6))))
  (assert-equal #d(#p(0 11) #p(1 3) #p(2 5) #p(3 4)) (converter #s(11 3 5 4)))
  (assert-equal #d(#p(0 1) #p(1 0) #p(2 1) #p(3 0) #p(4 1)) (converter #s(1 0 1 0 1))))

(define-test menor-altura
  (assert-equal 1 (menor-altura #s(2 3 1)))
  (assert-equal -4 (menor-altura #s(2 3 -4 1))))

(define-test maior-altura
  (assert-equal 3 (maior-altura #s(2 3 1)))
  (assert-equal 1 (maior-altura #s(0 1 0))))

(define-test retrogradar
  (assert-equal #s(3 2 1) (retrogradar #s(1 2 3))))

(define-test transpor
  (assert-equal #s(4 5 6) (transpor #s(1 2 3) 3)))

(define-test inverter
  (assert-equal #s(2 3 1 0) (inverter #s(1 0 2 3)))
  (assert-equal #s(2 0 6 7 4) (inverter #s(7 9 3 2 5))))

(define-test rotacionar
  (assert-equal #s(2 3 4 1) (rotacionar #s(1 2 3 4)))
  (assert-equal #s(2 3 4 1) (rotacionar #s(1 2 3 4) 1))
  (assert-equal #s(4 1 2 3) (rotacionar #s(1 2 3 4) 2)))
