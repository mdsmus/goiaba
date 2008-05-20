(in-package #:goiaba)

(enable-sharp-l-syntax)

(defmethod menor-altura ((objeto contorno-duracao))
  "Retorna a menor altura de um contorno em codificação com duração."
  (first (sort (mapcar #'ponto-y (pontos objeto)) #'<)))

(defmethod maior-altura ((objeto contorno-duracao))
  "Retorna a maior altura de um contorno em codificação com duração."
  (first (sort (mapcar #'ponto-y (pontos objeto)) #'>)))

(defmethod menor-duracao ((objeto contorno-duracao))
  "Retorna a menor duração de um contorno em codificação com duração."
  (first (sort (mapcar #'ponto-x (pontos objeto)) #'<)))

(defmethod maior-duracao ((objeto contorno-duracao))
  "Retorna a maior duração de um contorno em codificação com duração."
  (first (sort (mapcar #'ponto-x (pontos objeto)) #'>)))

(defmethod ponto-medio-duracao ((objeto contorno-duracao))
  "Retorna o ponto médio de um contorno em relação à duração."
  (/ (+ (maior-duracao objeto) (menor-duracao objeto)) 2.0))

(defmethod ponto-medio-altura ((objeto contorno-duracao))
    "Retorna o ponto médio de um contorno em relação à altura."
    (/ (+ (maior-altura objeto) (menor-altura objeto)) 2.0))

(defmethod aumentar-altura ((objeto contorno-duracao) fator)
  "Multiplica a altura de todos os pares de um contorno por um
dado fator."
  (map-contorno-duracao #L(aumentar-altura !1 fator) (pontos objeto)))

;; FIXME: a abstracao da aumentacao de duracao esta errada
(defmethod aumentar-duracao ((objeto contorno-duracao) fator)
  "Multiplica a duração de um contorno por um dado fator."
  (map-contorno-duracao #L(aumentar-duracao !1 fator) (pontos objeto)))

(defmethod insere-ponto ((objeto contorno-duracao) ponto segmento)
  "Insere um ponto em um contorno de um segmento dado."
  (let ((pontos (pontos objeto)))
    (if (> segmento (length pontos))
        (error "Segmento não pode ser maior que tamanho do contorno.")
        (make-contorno-duracao (append (subseq pontos 0 segmento)
                                       (list ponto)
                                       (subseq pontos segmento))))))

(defmethod ordena-duracao-crescente ((objeto contorno-duracao))
  "Ordena os pontos de um contorno de forma crescente a partir dos
valores de duração."
  (make-contorno-duracao (sort (pontos objeto) #'< :key #'ponto-x)))

(defmethod remover-duplicatas ((objeto contorno-duracao))
  "Remove duplicatas de uma lista de pares e coloca em ordem
crescente a partir de x."
  (make-contorno-duracao (remove-duplicates (pontos objeto) :key #'ponto-x :from-end t)))

(defmethod remover-alturas-repetidas ((objeto contorno-duracao))
  "Remove os pontos de um contorno que têm alturas repetidas, mantendo
o primeiro ponto em ordem de aparição."
  (remove-duplicates (pontos objeto) :key #'second :from-end t))

(defmethod transpor ((objeto contorno-duracao) fator)
  "Transpõe um contorno em codificação com duração a partir de um dado
fator."
  (map-contorno-duracao #L(transpor !1 fator) (pontos objeto)))

(defmethod inverter ((objeto contorno-duracao) &optional eixo)
  "Inverte um contorno em codificação com duração em relação à altura
a partir de um dado eixo."
  (let ((eixo (or eixo (ponto-medio-altura (pontos objeto)))))
    (map-contorno-duracao #L(inverter !1 eixo) (pontos objeto))))

(defmethod retrogradar ((objeto contorno-duracao))
  "Retrograda um contorno em codificação com duração."
  (let ((ponto-medio (ponto-medio-duracao (pontos objeto))))
    (reverse (map-contorno-duracao #L(inverter-por-y !1 ponto-medio) (pontos objeto)))))

(defmethod rotacionar ((objeto contorno-duracao) &optional (fator 1))
  "Rotaciona um contorno em codificação com duração a partir de um
dado fator."
  (if (> fator (length (pontos objeto)))
      (error "Fator não pode ser maior que tamanho do contorno.")
      (let ((x (mapcar #'ponto-x (pontos objeto)))
            (y (mapcar #'ponto-y (pontos objeto))))
        (mapcar #'list x (append (subseq y fator) (subseq y 0 fator))))))