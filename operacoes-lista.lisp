(in-package #:goiaba)

;; funções relacionadas a elemento

(defun intervalo (elemento1 elemento2)
  "Subtrai o primeiro elemento do segundo."
  (- elemento2 elemento1))

(defun subtrair-elementos (a b)
  "Subtrai o segundo elemento do primeiro."
  (- a b))

(defun inverter-elemento (elemento eixo)
  "Faz inversão de um elemento em relação a um eixo dado."
  (- (* 2 eixo) elemento))

;; funções relacionadas a listas

(defun rotate (lista &optional (n 1))
  "Rotaciona uma lista a partir de um de seus elementos."
  (let ((modulo-n (mod n (length lista))))
    (append (subseq lista modulo-n) (subseq lista 0 modulo-n))))

(defun intervalos (lista)
  "Retorna os intervalos entre elementos de uma lista."
  (subseq (mapcar #'intervalo lista (rotate lista)) 0 (- (length lista) 1)))
  
(defun subtrair-lista-indice (lista indice)
  "Subtrai todos os elementos de uma lista de um índice."
  (mapcar #'(lambda (x) (subtrair-elementos x indice)) lista))

(defun inverter-lista (lista eixo)
  "Inverte os elementos de uma lista em torno de um eixo dado."
  (mapcar #'(lambda (elemento) (inverter-elemento elemento eixo)) lista))

(defun ponto-medio-lista (lista)
  "Retorna a média entre o maior e o menor valor de elementos de
uma lista."
  (let ((maior (apply #'max lista))
        (menor (apply #'min lista)))
    (/ (+ maior menor) 2)))

(defun lista-de-alturas->contorno-com-duracao (lista-de-alturas)
  "Retorna um contorno a partir de uma lista de alturas."
  (loop
     for y in lista-de-alturas
     for n from 0
     collect (list n y)))
