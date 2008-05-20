(in-package #:goiaba)

(enable-sharp-l-syntax)

;; FIXME: inserir recorrencia
(defmethod reducao-adams ((objeto contorno-duracao))
  "Faz redução de contorno sugerida por Adams
\cite{adams1976mct}. Reduz um contorno a quatro pontos: ponto inicial,
final, mais alto e mais baixo."
  (let* ((primeiro (first (pontos objeto)))
         (ultimo (last1 (pontos objeto)))
         (mais-agudo (first (sort (pontos objeto) #'> :key #'ponto-y)))
         (mais-grave (first (sort (pontos objeto) #'< :key #'ponto-y))))
    (remover-duplicatas
     (make-contorno-duracao (sort (list primeiro mais-agudo mais-grave ultimo) #'< :key #'ponto-x)))))

(defmethod inclinacoes-contorno ((objeto contorno-duracao))
  "Retorna as diferenças de altura entre os pontos de um
contorno, ou seja, as inclinações entre os pontos de um contorno
em valores absolutos."
  (let* ((tamanho (length (pontos objeto)))
         (lista (mapcar #'ponto-y (pontos objeto))))
    (subseq (mapcar #L(- !1 !2) (rotate lista) lista) 0 (1- tamanho))))

(defun inclinacoes-contorno-positivo-negativo (contorno-com-duracao)
  "Retorna valores 1, 0 e -1 para inclinação positiva, nula e
negativa entre pontos de um contorno. É semelhante à função
definida por Friedmann \cite{friedmann85:_method_discus_contour}
como Contour Adjacency Series (CAS)."
  (mapcar #'(lambda (inclinacao) (if (zerop inclinacao)
                                0
                                (/ inclinacao (abs inclinacao))))
          (inclinacoes-contorno contorno-com-duracao)))
