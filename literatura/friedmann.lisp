(in-package #:goiaba)

(defun inverter-cas (cas)
  "Inverte uma Contour Adjacency Series (CAS)."
  (mapcar #'(lambda (x) (* x -1)) cas))

(defun inverter-cc (cc)
  "Inverte uma Contour Class (CC)."
    (inverter-lista cc (ponto-medio-lista cc)))

(defun %cia (cc)
  "Conta os Contour Interval (CI) de uma Contour Class (CC)."
  (if (atom cc)
      cc
      (let ((primeiro (first cc)))
        (append (mapcar (lambda (item) (- item primeiro)) (rest cc))
                (%cia (rest cc))))))

(defun %ccv (par)
  "Retorna a soma de valores de um par de listas."
  (let* ((soma-positivo (apply #'+ (first par)))
         (soma-negativo (apply #'+ (second par))))
    (list soma-positivo soma-negativo)))

(defmethod cc ((objeto contorno-com-duracao))
  "Retorna o valor da classe de contorno (Contour Class) de um
contorno. É o mesmo que normalização de contorno. Morris
\cite{morris93:_new_direc_theor_analy_music_contour} chama de
espaço de contorno (Contour Space ou c-space)."
  (let* ((pontos-do-contorno (sort (remover-alturas-repetidas (args objeto)) #'< :key #'second)))
    (mapcar #'second (sort (loop
         for (x y) in pontos-do-contorno
         for n from 0
         collect (list x n)) #'< :key #'first))))

(defmethod cc ((objeto contorno-simples))
  (make-instance 'contorno-simples :alturas (cc (make-contorno-com-duracao
    (contorno-simples->contorno-com-duracao (alturas objeto))))))

(defmethod cas ((objeto contorno-com-duracao))
  "Retorna a Contour Adjacency Series (CAS) de um
contorno. Diferente da função
inclinacoes-contorno-positivo-negativo, as inclinações nulas são
ignoradas."
  (remove 0
          (inclinacoes-contorno-positivo-negativo
           (args objeto))))

(defmethod cas ((objeto contorno-simples))
  "Retorna a Contour Adjacency Series (CAS) de um
contorno. Diferente da função
inclinacoes-contorno-positivo-negativo, as inclinações nulas são
ignoradas."
  (remove 0
          (inclinacoes-contorno-positivo-negativo
           (contorno-simples->contorno-com-duracao (args objeto)))))

(defmethod contour-interval-succession ((objeto classe-de-contorno))
  "Retorna os Contour Interval (CI) de uma Contour Class (CC)."
  (intervalos (args objeto)))

(defmethod contour-interval-succession ((objeto contorno-simples))
  "Retorna os Contour Interval (CI) de um contorno simples."
  (intervalos (args objeto)))

(defmethod contour-interval-succession ((objeto contorno-com-duracao))
  "Retorna os Contour Interval (CI) de um contorno com duração."
  (intervalos (cc (make-contorno-com-duracao (args objeto)))))

(defmethod casv ((objeto contour-adjacency-series))
  "Retorna o Contour Adjacency Series Vector (CASV) de um contorno com
duração."
  (let* ((positivos (length (remove -1 (args contour-adjacency-series))))
         (negativos (length (remove 1 (args contour-adjacency-series)))))
    (list positivos negativos)))

(defmethod casv ((objeto contorno-com-duracao))
  "Retorna o Contour Adjacency Series Vector (CASV) de um contorno com
duração."
  (let* ((cas (cas (make-contorno-com-duracao (args objeto))))
         (positivos (length (remove -1 cas)))
         (negativos (length (remove 1 cas))))
    (list positivos negativos)))

(defmethod casv ((objeto contorno-simples))
  "Retorna o Contour Adjacency Series Vector (CASV) de um contorno
simples."
  (let* ((cas (cas (make-contorno-simples (args objeto))))
         (positivos (length (remove -1 cas)))
         (negativos (length (remove 1 cas))))
    (list positivos negativos)))

(defmethod cia ((objeto classe-de-contorno))
  "Retorna a Contour Interval Array (CIA) de uma Contour
Class (CC)."
  (let* ((lista (%cia (args objeto)))
         (max (apply #'max (args objeto)))
         (lista-negativa (remove-if #'plusp lista))
         (lista-positiva (remove-if #'minusp lista)))
    (list
     (loop for x from 1 to max
        collect (count x lista-positiva))
     (loop for x from -1 downto (- max)
        collect (count x lista-negativa)))))

(defmethod cia ((objeto contorno-simples))
  "Retorna a Contour Interval Array (CIA) a partir de um contorno
simples."
  (cia (make-classe-de-contorno (cc (make-contorno-simples (args
  objeto))))))

(defmethod cia ((objeto contorno-com-duracao))
  "Retorna a Contour Interval Array (CIA) a partir de um contorno
simples."
  (cia (make-classe-de-contorno (cc (make-contorno-com-duracao (args
  objeto))))))

(defmethod ccvii ((objeto classe-de-contorno))
  "Retorna o Countour Class Vector II (CCVII) de uma Contour
Class (cc)."
  (%ccv (cia (make-classe-de-contorno (args objeto)))))

(defmethod ccvii ((objeto contorno-simples))
  "Retorna o Countour Class Vector II (CCVII) de um contorno simples."
  (%ccv (cia (make-contorno-simples (args objeto)))))

(defmethod ccvii ((objeto contorno-com-duracao))
  "Retorna o Countour Class Vector II (CCVII) de um contorno com
duração."
  (%ccv (cia (make-contorno-com-duracao (args objeto)))))

(defmethod ccvi ((objeto classe-de-contorno))
  "Retorna o Countour Class Vector I (CCVI) de uma Contour
Class (cc)."
  (let* ((cia (cia (make-classe-de-contorno (args objeto))))
         (tamanho (length (first cia)))
         (primeiro (loop for
                      n from 0 to (- tamanho 1)
                      collect (* (1+ n)  (nth n (first cia)))))
         (segundo (loop for
                     n from 0 to (- tamanho 1)
                     collect (* (1+ n)  (nth n (second cia))))))
    (%ccv (list primeiro segundo))))

(defmethod ccvi ((objeto contorno-simples))
  "Retorna o Countour Class Vector I (CCVI) de um contorno simples."
  (let* ((cia (cia (make-contorno-simples (args classe-de-contorno))))
         (tamanho (length (first cia)))
         (primeiro (loop for
                      n from 0 to (- tamanho 1)
                      collect (* (1+ n)  (nth n (first cia)))))
         (segundo (loop for
                     n from 0 to (- tamanho 1)
                     collect (* (1+ n)  (nth n (second cia))))))
    (%ccv (list primeiro segundo))))

(defmethod ccvi ((objeto contorno-com-duracao))
  "Retorna o Countour Class Vector I (CCVI) de um contorno com
duração."
  (let* ((cia (cia (make-contorno-com-duracao (args classe-de-contorno))))
         (tamanho (length (first cia)))
         (primeiro (loop for
                      n from 0 to (- tamanho 1)
                      collect (* (1+ n)  (nth n (first cia)))))
         (segundo (loop for
                     n from 0 to (- tamanho 1)
                     collect (* (1+ n)  (nth n (second cia))))))
    (%ccv (list primeiro segundo))))
