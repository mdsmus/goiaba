(in-package #:goiaba)

(gera-b3 '((0 1) (1 0)))

(gera 'b3 contorno)

(preview "a2" "b2")

(defun symbol->string (sim)
  (string-downcase (symbol-name sim)))

(apply #'preview (mapcar #'symbol->string '(a1 b1 c1 a2 b2 c2 a3 b3 c3 a4 b4 c4 a5 b5 c5)))

;; testes com retrogradacao de contornos de adams

(let ((a1 '((0 1)(1 0)))
      (b1 '((0 0)(1 0)))
      (c1 '((0 0)(1 1)))
      (a2 '((0 1)(1 2)(2 0)))
      (b2 '((0 0)(1 1)(2 0)))
      (c2 '((0 0)(1 2)(2 1)))
      (a3 '((0 2)(1 0)(2 1)))
      (b3 '((0 1)(1 0)(2 1)))
      (c3 '((0 1)(1 0)(2 2)))
      (a4 '((0 2)(1 3)(2 0)(3 1)))
      (b4 '((0 1)(1 2)(2 0)(3 1)))
      (c4 '((0 1)(1 3)(2 0)(3 2)))
      (a5 '((0 2)(1 0)(2 3)(3 1)))
      (b5 '((0 1)(1 0)(2 2)(3 1)))
      (c5 '((0 1)(1 0)(2 3)(3 2))))
  (list
   (retrogradar-contorno a1)
   "a1 + R = c1"
   (retrogradar-contorno a2)
   "a2 + R = c2"
   (retrogradar-contorno a3)
   "a3 + R = c3"
   (retrogradar-contorno a4)
   "a4 + R = c5"
   (retrogradar-contorno a5)
   "a5 + R = c4"
   ))

(let* ((cs '(3 5 2 4))
       (cd (contorno-simples->contorno-com-duracao cs))
       (cc (cc (make-contorno-simples cs)))
       (cas (cas (make-contorno-simples cs)))
       (ret (retrogradar (make-contorno-simples cs)))
       (tra (transpor (make-contorno-simples cs) 1))
       (inv (inverter (make-contorno-simples cs) 2)))
  (print (list ret tra inv cc cas)))