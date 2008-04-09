(in-package :goiaba)
(use-package :lisp-unit)

(define-test reducao-adams
  (assert-equal '((0 1) (1 0)) (reducao-adams '((0 1) (1 0))))
  (assert-equal '((0 0) (1 1) (2 0)) (reducao-adams '((0 0) (1 1) (2 0))))
  (assert-equal '((0 0) (2 2)) (reducao-adams '((0 0) (1 1) (2 2))))
  (assert-equal '((0 1) (1 0) (2 1)) (reducao-adams '((0 1) (1 0) (2 1))))
  (assert-equal '((0 0) (1 0)) (reducao-adams '((0 0) (1 0))))
  ;; escolher resposta do teste abaixo
  (assert-equal '((0 0) (1 2) (4 0)) (reducao-adams '((0 0) (1 2) (2 1) (3 2) (4 0))))
  (assert-equal '((0 0) (3 2) (4 0)) (reducao-adams '((0 0) (1 2) (2 1) (3 2) (4 0))))
  (assert-equal '((0 0) (1 2) (3 2) (4 0)) (reducao-adams '((0 0) (1 2) (2 1) (3 2) (4 0))))
  ;;
  ;; escolher resposta do teste abaixo
  (assert-equal '((0 2) (1 4) (2 0) (5 2)) (reducao-adams '((0 2) (1 4) (2 0) (3 4) (4 0) (5 2))))
  (assert-equal '((0 2) (2 0) (3 4) (5 2)) (reducao-adams '((0 2) (1 4) (2 0) (3 4) (4 0) (5 2))))
  (assert-equal '((0 2) (3 4) (4 0) (5 2)) (reducao-adams '((0 2) (1 4) (2 0) (3 4) (4 0) (5 2))))
  ;;
  )

(define-test inclinacoes-contorno
  (assert-equal '(0) (inclinacoes-contorno '((0 0) (1 0))))
  (assert-equal '(1) (inclinacoes-contorno '((0 0) (1 1))))
  (assert-equal '(1 -2) (inclinacoes-contorno '((0 4) (1 5) (2 3))))
  (assert-equal '(1 -2 -2 3 5 -6 -1) (inclinacoes-contorno '((0 4) (1 5) (2 3) (3 1) (4 4) (5 9) (6 3) (7 2))))
  )

(define-test inclinacoes-contorno-positivo-negativo
  (assert-equal '(0) (inclinacoes-contorno-positivo-negativo '((0 0) (1 0))))
  (assert-equal '(1) (inclinacoes-contorno-positivo-negativo '((0 0) (1 1))))
  (assert-equal '(1 -1) (inclinacoes-contorno-positivo-negativo '((0 4) (1 5) (2 3))))
  (assert-equal '(1 -1 -1 1 1 -1 -1)
                (inclinacoes-contorno-positivo-negativo
                 '((0 4) (1 5) (2 3) (3 1) (4 4) (5 9) (6 3) (7 2))))
  )