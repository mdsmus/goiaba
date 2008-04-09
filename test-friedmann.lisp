(in-package :goiaba)
(use-package :lisp-unit)

(define-test inverter-cas
  (assert-equal '(-1) (inverter-cas '(1)))
  (assert-equal '(-1 1) (inverter-cas '(1 -1)))
  (assert-equal '(-1 1 -1) (inverter-cas '(1 -1 1)))
  (assert-equal '(1 -1 1) (inverter-cas '(-1 1 -1)))
  )

(define-test inverter-cc
  (assert-equal '(0) (inverter-cc '(0)))
  (assert-equal '(1 0) (inverter-cc '(0 1)))
  (assert-equal '(2 1 0) (inverter-cc '(0 1 2)))
  (assert-equal '(2 0 1) (inverter-cc '(0 2 1)))
  (assert-equal '(3 1 2 0) (inverter-cc '(0 2 1 3)))
  (assert-equal '(4 2 1 3 0) (inverter-cc '(0 2 3 1 4)))
  (assert-equal '(3 0 2 4 1) (inverter-cc '(1 4 2 0 3)))
  )

(define-test %cia
  (assert-equal '(2 1 -1)(%cia '(0 2 1)))
  )

(define-test %ccv
  (assert-equal '(2 1 -1)(%cia '(0 2 1)))
  )

(define-test cas
  (assert-equal '(-1) (cas '((0 1) (1 0))))
  (assert-equal '(1) (cas '((0 0) (1 1))))
  (assert-equal '(-1 1) (cas '((0 1) (1 0) (2 3))))
  (assert-equal '(1 1) (cas '((0 0) (1 1) (2 2))))
  (assert-equal '(-1 -1) (cas '((0 2) (1 1) (2 0))))
  (assert-equal '(1 1 -1 -1) (cas '((0 0) (1 3) (2 4) (3 2) (4 0))))
  (assert-equal '(1 -1 -1) (cas '((0 0) (1 3) (2 3) (3 2) (4 0))))
  )

(define-test casv
  (assert-equal '(1 0) (casv '(1)))
  (assert-equal '(0 1) (casv '(-1)))
  (assert-equal '(1 1) (casv '(-1 1)))
  (assert-equal '(2 0) (casv '(1 1)))
  (assert-equal '(0 2) (casv '(-1 -1)))
  (assert-equal '(2 2) (casv '(1  1 -1 -1)))
  )

(define-test cc
  (assert-equal '(1 0) (cc (make-contorno-com-duracao '((0 1) (1 0)))))
  (assert-equal '(0 1) (cc (make-contorno-com-duracao '((0 0) (1 1)))))
  (assert-equal '(1 0 2) (cc (make-contorno-com-duracao '((0 1) (1 0) (2 3)))))
  (assert-equal '(0 1 2) (cc (make-contorno-com-duracao '((0 0) (1 1) (2 2)))))
  (assert-equal '(2 1 0) (cc (make-contorno-com-duracao '((0 2) (1 1) (2 0)))))
  (assert-equal '(0 2 3 1) (cc (make-contorno-com-duracao '((0 0) (1 3) (2 4) (3 2) (4 0)))))
  (assert-equal '(0 2 1) (cc (make-contorno-com-duracao '((0 0) (1 3) (2 3) (3 2) (4 0)))))
  (assert-equal '(0 3 1 2) (cc (make-contorno-simples '(2 9 4 8))))
  (assert-equal '(0 1) (cc (make-contorno-simples '(4 12))))
  )

(define-test cas
  (assert-equal '(1 1 -1 1 -1) (cas (make-contorno-simples '(0 2 4 3 5 4))))
  (assert-equal '(1 -1 1) (cas (make-contorno-com-duracao '((1 3)(2 5)(4 1)(6 2))))))

(define-test casv
  (assert-equal '(3 2) (casv (make-contorno-simples '(0 2 4 3 5 4))))
  (assert-equal '(2 1) (casv (make-contorno-com-duracao '((1 3)(2 5)(4 1)(6 2)))))
  )

(define-test contour-interval-succession
  (assert-equal '(3 -2 0 5) (contour-interval-succession '(make-contorno-simples '(2 5 3 3 8))))
  (assert-equal '(1 5) (contour-interval-succession '(make-contorno-com-duracao '((1 2)(3 3)(4 8)))))
  (assert-equal '(-2 1 -2) (contour-interval-succession '(make-classe-de-contorno '(3 1 2 0))))
  )

(define-test cia
  (assert-equal '((3 3 2 1)(1 0 0 0)) (cia (make-contorno-simples '(0 2 4 3 5 4))))
  (assert-equal '((2 0 0)(1 2 1)) (cia (make-contorno-com-duracao '((1 3)(2 5)(4 1)(6 2)))))
  (assert-equal '((1 0 0)(2 2 1)) (cia (make-classe-de-contorno '(3 1 2 0))))
  )

(define-test ccvii
  (assert-equal '(9 1) (ccvii (make-contorno-simples '(0 2 4 3 5 4))))
  (assert-equal '(2 4) (ccvii (make-contorno-com-duracao '((1 3)(2 5)(4 1)(6 2)))))
  (assert-equal '(1 5) (ccvii (make-classe-de-contorno '(3 1 2 0))))
  )

(define-test ccvi
  (assert-equal '(3 1) (ccvi (make-contorno-simples '(0 2 4 3 5 4))))
  (assert-equal '(2 4) (ccvi (make-contorno-com-duracao '((1 3)(2 5)(4 1)(6 2)))))
  (assert-equal '(1 9) (ccvi (make-classe-de-contorno '(3 1 2 0))))
  )

(define-test %cia
  (assert-equal '(-1 -3 -2 -2 -1 1) (%cia '(3 2 0 1)))
  )

(define-test %ccv
  (assert-equal '(3 2) (%ccv '((1 2)(2 0))))
  )
