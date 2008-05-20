(in-package #:goiaba)

(enable-sharp-l-syntax)

(defmethod menor-altura ((objeto contorno))
  "Retorna a menor altura de um contorno em codificação com duração."
  (first (sort (mapcar #'ponto-y (pontos objeto)) #'<)))

(defmethod maior-altura ((objeto contorno))
  "Retorna a maior altura de um contorno em codificação com duração."
  (first (sort (mapcar #'ponto-y (pontos objeto)) #'>)))

(defmethod menor-duracao ((objeto contorno))
  "Retorna a menor duração de um contorno em codificação com duração."
  (first (sort (mapcar #'ponto-x (pontos objeto)) #'<)))

(defmethod maior-duracao ((objeto contorno))
  "Retorna a maior duração de um contorno em codificação com duração."
  (first (sort (mapcar #'ponto-x (pontos objeto)) #'>)))

(defmethod ponto-medio-duracao ((objeto contorno))
  "Retorna o ponto médio de um contorno em relação à duração."
  (/ (+ (maior-duracao objeto) (menor-duracao objeto)) 2.0))

(defmethod ponto-medio-altura ((objeto contorno))
    "Retorna o ponto médio de um contorno em relação à altura."
    (/ (+ (maior-altura objeto) (menor-altura objeto)) 2.0))

(defun map-contorno (fn lista)
  (make-contorno (mapcar fn lista)))
  
(defmethod aumentar-altura ((objeto contorno) fator)
  "Multiplica a altura de todos os pares de um contorno por um
dado fator."
  (map-contorno #L(aumentar-altura !1 fator) (pontos objeto)))

;; FIXME: a abstracao da aumentacao de duracao esta errada
(defmethod aumentar-duracao ((objeto contorno) fator)
  "Multiplica a duração de um contorno por um dado fator."
  (map-contorno #L(aumentar-duracao !1 fator) (pontos objeto)))

(defmethod ordena-crescente-duracao ((objeto contorno))
  "Ordena os pontos de um contorno de forma crescente a partir dos
valores de duração."
  (make-contorno (sort (pontos objeto) #'< :key #'ponto-x)))

(defmethod remover-duplicatas ((objeto contorno))
  "Remove duplicatas de uma lista de pares e coloca em ordem
crescente a partir de x."
  (make-contorno (remove-duplicates (pontos objeto) :key #'ponto-x :from-end t)))

(defmethod remover-alturas-repetidas ((objeto contorno))
  "Remove os pontos de um contorno que têm alturas repetidas, mantendo
o primeiro ponto em ordem de aparição."
  (remove-duplicates contorno :key #'second :from-end t))

(defun contorno->contorno-simples (contorno)
  "Retorna um contorno representado por uma lista de alturas a partir
de um contorno representado por pares coordenados."
  (mapcar #'second contorno))


(defmethod transpor ((objeto contorno) fator)
  "Transpõe um contorno em codificação com duração a partir de um dado
fator."
  (mapcar #'(lambda (ponto) (transpor (make-ponto ponto) fator)) (args objeto)))

(defmethod inverter ((objeto contorno) &optional eixo)
  "Inverte um contorno em codificação com duração em relação à altura
a partir de um dado eixo."
  (let* ((eixo (or eixo (ponto-medio-altura (args objeto)))))
    (mapcar #'(lambda (ponto) (%inverter-ponto ponto eixo)) (args objeto))))

(defmethod retrogradar ((objeto contorno))
  "Retrograda um contorno em codificação com duração."
  (reverse
   (mapcar #'(lambda (ponto)
               (%retrogradar-ponto ponto
                                  (ponto-medio-duracao
                                   (args objeto))))
           (args objeto))))

(defmethod rotacionar ((objeto contorno) &optional (fator 1))
  "Rotaciona um contorno em codificação com duração a partir de um
dado fator."
  (let* ((x-contorno (mapcar #'first (args objeto)))
         (y-contorno (mapcar #'second (args objeto)))
         (y-rotado (append
                    (subseq y-contorno fator)
                    (subseq y-contorno 0 fator))))
    (mapcar #'list x-contorno y-rotado)))