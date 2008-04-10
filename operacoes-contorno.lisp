(in-package #:goiaba)

;; funções relacionadas a pares

(defmethod menor-altura ((objeto contorno-com-duracao))
  "Retorna a menor altura de um contorno em codificação com duração."
  (first (sort (mapcar #'second (args objeto)) #'<)))

(defmethod menor-altura ((objeto contorno-simples))
  "Retorna a menor altura de um contorno em codificação simples."
  (first (sort (args objeto) #'<)))

(defmethod maior-altura ((objeto contorno-com-duracao))
  "Retorna a maior altura de um contorno em codificação com duração."
  (first (sort (mapcar #'second (args objeto)) #'>)))

(defmethod maior-altura ((objeto contorno-simples))
  "Retorna a maior altura de um contorno em codificação simples."
  (first (sort (args objeto) #'>)))

(defun ponto-medio-duracao (contorno-com-duracao)
  "Retorna o ponto médio de um contorno em relação à duração."
  (let ((maior (first (sort (mapcar #'first contorno-com-duracao) #'>)))
        (menor (first (sort (mapcar #'first contorno-com-duracao) #'<))))
    (/ (+ maior menor) 2)))

(defun ponto-medio-altura (contorno-com-duracao)
    "Retorna o ponto médio de um contorno em relação à altura."
  (let ((maior (first (sort (mapcar #'second contorno-com-duracao) #'>)))
        (menor (first (sort (mapcar #'second contorno-com-duracao) #'<))))
    (/ (+ maior menor) 2)))

(defun transpor-ponto (ponto fator)
  "Transpõe um ponto de um contorno a partir de um dado fator."
  (let ((x (first ponto))
        (y (second ponto)))
    (list x (+ y fator))))

(defun %inverter-ponto (ponto eixo)
  "Inverte um ponto de um contorno em relação à altura a partir
de um dado eixo."
  (let ((x (first ponto))
        (y (second ponto)))
    (list x (- (* 2 eixo) y))))

(defun %retrogradar-ponto (ponto eixo)
  "Inverte um ponto de um contorno em relação à duração a partir
de um dado eixo. Esta função é útil para retrogradar um contorno."
  (let ((x (first ponto))
        (y (second ponto)))
    (list (- (* 2 eixo) x) y)))

(defun aumentar-altura-ponto (ponto fator)
  "Multiplica a altura de um ponto por um dado fator."
  (let ((x (first ponto))
        (y (second ponto)))
    (list x (* y fator))))

(defun aumentar-duracao-ponto (ponto fator)
  "Multiplica a duração de um ponto por um dado fator."
  (let ((x (first ponto))
        (y (second ponto)))
    (list (* x fator) y)))

;; funções relacionadas a contornos

(defun aumentar-altura (contorno-com-duracao fator)
  "Multiplica a altura de todos os pares de um contorno por um
dado fator."
  (mapcar #'(lambda (ponto)
              (aumentar-altura-ponto ponto fator))
          contorno-com-duracao))

;; FIXME: a abstracao da aumentacao de duracao esta errada
(defun aumentar-duracao (contorno-com-duracao fator)
  "Multiplica a duração de um contorno por um dado fator."
  (mapcar #'(lambda (ponto) (aumentar-duracao-ponto ponto fator)) contorno-com-duracao))

(defun rotar-contorno (contorno-com-duracao &optional (fator 1))
  "Rotaciona um contorno a partir de um dado fator."
  (let* ((x-contorno (mapcar #'first contorno-com-duracao))
         (y-contorno (mapcar #'second contorno-com-duracao))
         (y-rotado (append (subseq y-contorno fator) (subseq y-contorno 0 fator))))
    (mapcar #'list x-contorno y-rotado)))

(defun ordena-crescente-duracao (contorno-com-duracao)
  "Ordena os pontos de um contorno de forma crescente a partir dos
valores de duração."
  (sort contorno-com-duracao #'< :key #'first))

(defun insere-ponto (contorno ponto)
  "Insere um ponto em um contorno de um único segmento."
  (ordena-crescente-duracao (list (first contorno) ponto (second contorno))))

(defun remover-duplicatas (contorno-com-duracao)
  "Remove duplicatas de uma lista de pares e coloca em ordem
crescente a partir de x."
  (remove-duplicates contorno-com-duracao :key #'first :from-end t))

(defun remover-alturas-repetidas (contorno-com-duracao)
  "Remove os pontos de um contorno que têm alturas repetidas, mantendo
o primeiro ponto em ordem de aparição."
  (remove-duplicates contorno-com-duracao :key #'second :from-end t))

(defun contorno-com-duracao->contorno-simples (contorno-com-duracao)
  "Retorna um contorno representado por uma lista de alturas a partir
de um contorno representado por pares coordenados."
  (mapcar #'second contorno-com-duracao))

(defun contorno-simples->contorno-com-duracao (lista-de-alturas)
  "Retorna um contorno representado por pares coordenados a partir de
uma lista de alturas (contorno simples)."
  (loop
     for elemento in lista-de-alturas
     for n from 0 to (length lista-de-alturas)
     collect (list n elemento)))

;;; métodos

(defmethod transpor ((objeto ponto) fator)
  "Transpõe um ponto de um contorno a partir de um dado fator."
  (let ((x (first (args objeto)))
        (y (second (args objeto))))
    (list x (+ y fator))))

(defmethod transpor ((objeto contorno-simples) fator)
  "Transpõe um contorno em codificação simples a partir de um dado
fator."
  (mapcar #'(lambda (ponto) (+ ponto fator)) (args objeto)))

(defmethod transpor ((objeto contorno-com-duracao) fator)
  "Transpõe um contorno em codificação com duração a partir de um dado
fator."
  (mapcar #'(lambda (ponto) (transpor (make-ponto ponto) fator)) (args objeto)))

(defmethod inverter ((objeto contorno-simples) &optional eixo)
  "Inverte um contorno em codificação simples em relação à altura a
partir de um dado eixo."
  (let* ((eixo (or eixo (ponto-medio-altura (contorno-simples->contorno-com-duracao (args objeto))))))
    (mapcar #'(lambda (altura) (- (* 2 eixo) altura)) (args objeto))))

(defmethod inverter ((objeto contorno-com-duracao) &optional eixo)
  "Inverte um contorno em codificação com duração em relação à altura
a partir de um dado eixo."
  (let* ((eixo (or eixo (ponto-medio-altura (args objeto)))))
    (mapcar #'(lambda (ponto) (%inverter-ponto ponto eixo)) (args objeto))))

(defmethod retrogradar ((objeto list))
  (if (consp (first objeto))
      (retrogradar (make-contorno-com-duracao objeto))
      (retrogradar (make-contorno-simples objeto))))

(defmethod retrogradar ((objeto contorno-simples))
  "Retrograda um contorno em codificação simples."
  (reverse (args objeto)))

(defmethod retrogradar ((objeto contorno-com-duracao))
  "Retrograda um contorno em codificação com duração."
  (reverse
   (mapcar #'(lambda (ponto)
               (%retrogradar-ponto ponto
                                  (ponto-medio-duracao
                                   (args objeto))))
           (args objeto))))

(defmethod rotacionar ((objeto contorno-simples) &optional (fator 1))
  "Rotaciona um contorno em codificação simples a partir de um dado
fator."
  (append (subseq (args objeto) fator) (subseq (args objeto) 0 fator)))

(defmethod rotacionar ((objeto contorno-com-duracao) &optional (fator 1))
  "Rotaciona um contorno em codificação com duração a partir de um
dado fator."
  (let* ((x-contorno (mapcar #'first (args objeto)))
         (y-contorno (mapcar #'second (args objeto)))
         (y-rotado (append
                    (subseq y-contorno fator)
                    (subseq y-contorno 0 fator))))
    (mapcar #'list x-contorno y-rotado)))
