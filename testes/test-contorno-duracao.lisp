(in-package #:goiaba-testes)

(define-test converter
  (assert-equal #d(#p(0 11) #p(1 3) #p(2 5) #p(3 4))
                (converter #s(11 3 5 4)))
  (assert-equal #d(#p(0 1) #p(1 0) #p(2 1) #p(3 0) #p(4 1))
                (converter #s(1 0 1 0 1))))

(define-test menor-altura
  (assert-equal 1 (menor-altura #d(#p(0 2) #p(1 3) #p(2 1))))
  (assert-equal -4 (menor-altura #d(#p(1 3) #p(0 2) #p(2 -4) #p(3 1)))))

(define-test maior-altura
  (assert-equal 3 (maior-altura #d(#p(0 2) #p(1 3) #p(2 1))))
  (assert-equal 1 (maior-altura #d(#p(2 0) #p(12 1) #p(13 0)))))

;; teste não considera a duração
(define-test retrogradar
  (assert-equal #d(#p(0 3) #p(1 2) #p(2 1))
                (retrogradar #d(#p(0 1) #p(1 2) #p(2 3)))))

(define-test transpor
  (assert-equal #d(#p(0 4) #p(1 5) #p(2 6))
                (transpor #d(#p(0 1) #p(1 2) #p(2 3)) 3)))

(define-test inverter
  (assert-equal #d(#p(0 2) #p(1 3) #p(2 1) #p(3 0))
                (inverter #d(#p(0 1) #p(1 0) #p(2 2) #p(3 3))))
  (assert-equal #d(#p(0 2) #p(1 0) #p(2 6) #p(3 7) #p(4 4))
                (inverter #d(#p(0 7) #p(1 9) #p(2 3) #p(3 2) #p(4 5)))))

(define-test rotacionar
  (assert-equal #d(#p(0 1) #p(1 2) #p(2 3) #p(3 4))
                (rotacionar #d(#p(0 1) #p(1 2) #p(2 3) #p(3 4))))
  (assert-equal #d(#p(0 1) #p(1 2) #p(2 3) #p(3 4))
                (rotacionar #d(#p(0 1) #p(1 2) #p(2 3) #p(3 4)) 1))
  (assert-equal #d(#p(0 1) #p(1 2) #p(2 3) #p(3 4))
                (rotacionar #d(#p(0 1) #p(1 2) #p(2 3) #p(3 4)) 2)))
