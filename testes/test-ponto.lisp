(in-package #:goiaba)

(define-test converter
  (assert-equal #d(#p(0 11) #p(1 3) #p(2 5) #p(3 4))
                (converter #s(11 3 5 4)))
  (assert-equal #d(#p(0 1) #p(1 0) #p(2 1) #p(3 0) #p(4 1))
                (converter #s(1 0 1 0 1))))

(define-test ponto->lista
  (assert-equal (1 3) (ponto->lista #p(1 3)))
  (assert-equal (0 -1) (ponto->lista #p(0 -1))))

(define-test transpor
  (assert-equal #p(0 3) (transpor #p(0 2) 1))
  (assert-equal #p(0 1) (transpor #p(0 2) -1))
  (assert-equal #p(0 2) (transpor #p(0 2) 0)))
