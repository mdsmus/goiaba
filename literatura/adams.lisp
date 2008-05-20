(in-package #:goiaba)

;; FIXME: inserir recorrencia
(defun reducao-adams (contorno-com-duracao)
  "Faz redução de contorno sugerida por Adams
\cite{adams1976mct}. Reduz um contorno a quatro pontos: ponto inicial,
final, mais alto e mais baixo."
  (let* ((primeiro (first contorno-com-duracao))
         (ultimo (first (reverse contorno-com-duracao)))
         (mais-agudo (first (sort contorno-com-duracao #'> :key #'second)))
         (mais-grave (first (sort contorno-com-duracao #'< :key #'second))))
    (remover-duplicatas
     (sort (list primeiro mais-agudo mais-grave ultimo) #'< :key
     #'first))))

(defun inclinacoes-contorno (contorno-com-duracao)
  "Retorna as diferenças de altura entre os pontos de um
contorno, ou seja, as inclinações entre os pontos de um contorno
em valores absolutos."
  (let* ((tamanho (length contorno-com-duracao))
         (lista (mapcar #'second contorno-com-duracao)))
    (subseq
     (mapcar #'(lambda (a b) (- a b)) (rotate lista) lista)
     0 (- tamanho 1))))

(defun inclinacoes-contorno-positivo-negativo (contorno-com-duracao)
  "Retorna valores 1, 0 e -1 para inclinação positiva, nula e
negativa entre pontos de um contorno. É semelhante à função
definida por Friedmann \cite{friedmann85:_method_discus_contour}
como Contour Adjacency Series (CAS)."
  (mapcar #'(lambda (inclinacao) (if (zerop inclinacao)
                                0
                                (/ inclinacao (abs inclinacao))))
          (inclinacoes-contorno contorno-com-duracao)))
