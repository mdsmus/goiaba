(define-test positivo-ou-negativo
  (assert-equal 1 (positivo-ou-negativo 3))
  (assert-equal -1 (positivo-ou-negativo -20))
  (assert-equal 0 (positivo-ou-negativo 0)))

(define-test concat
  (assert-equal "ab" (concat "a" "b"))
  (assert-equal "c d" (concat "c " "d")))

