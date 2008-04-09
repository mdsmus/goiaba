(defun transpor-contorno (contorno-com-duracao fator)
  "Transpõe todos os pontos de um contorno a partir de um dado fator."
  (mapcar #'(lambda (ponto) (transpor-ponto ponto fator)) contorno-com-duracao))

(defun inverter-contorno (contorno-com-duracao eixo)
  "Inverte todos os pontos de um contorno em relação à altura a
partir de um dado eixo."
  (mapcar #'(lambda (ponto) (%inverter-ponto ponto eixo)) contorno-com-duracao))

(defun retrogradar-contorno (contorno-com-duracao)
  "Retrograda um contorno. É o mesmo que inverter o contorno em
relação à duração a partir do seu ponto médio."
  (reverse
   (mapcar #'(lambda (ponto)
               (%retrogradar-ponto ponto
                                   (ponto-medio-duracao
                                   contorno-com-duracao)))
           contorno-com-duracao)))

