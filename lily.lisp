(in-package #:goiaba)

(defparameter *nome-de-nota* '(c c# d d# e f f# g g# a a# b))

(defun nota->numero (nota)
  (position (intern (string-upcase nota)) *nome-de-nota*))

(defun conta-acidentes (acidentes)
  (let ((s (count #\i acidentes))
        (b (count #\e acidentes)))
    (if (plusp s)
        s
        b)))

(defun oitava-absoluta (oitavas)
  (let ((up (count #\' oitavas))
        (down (count #\, oitavas)))
    (if (plusp up)
        (+ 3 up)
        (- 3 down))))

(defun conta-oitava (oitavas)
  (let ((up (count #\' oitavas))
        (down (count #\, oitavas)))
    (if (plusp up)
        up
        (- down))))

(defun parse-oitava (oitava)
  (* 12 (oitava-absoluta oitava)))

(defun parse-nota (nota)
  (cl-ppcre:register-groups-bind (nome acidente oitava dur)
      ("(c|d|e|f|g|a|b)([es|is]*)(['|,]*)(128|1|2|4|8|16|32|64)?" nota :sharedp t)
    (declare (ignore dur))
    (list (+ (nota->numero nome) (conta-acidentes acidente))
          (conta-oitava oitava))))

(defun aplicar-oitavas (oitava-relativa lista-de-notas)
  (let ((oitava-global (parse-oitava oitava-relativa))
        (oitava-anterior 0))
    (loop for x in lista-de-notas
       for nota-lista = (parse-nota x)
       for nota = (first nota-lista)
       for oitava = (second nota-lista)
       collect (list nota (+ oitava-global (* 12 (+ oitava oitava-anterior))))
       do (unless (zerop oitava)
            (incf oitava-anterior oitava))
       do (print (list nota oitava oitava-anterior)))))

(defun parse-lily (string)
  (cl-ppcre:register-groups-bind (oitava-relativa notas)
      ("relative\\s+c(['|,]*)\\s+{(.*)}" string :sharedp t)
    (aplicar-oitavas oitava-relativa (cl-ppcre:split "(\\s+)" (string-trim " " notas)))))

(defun altura-absoluta (lista-altura-oitava)
  "Retorna o valor absoluto de uma lista de pares com altura relativa
e valor de oitava."
  (mapcar (lambda (x) (reduce #'+ x)) lista-altura-oitava))

(defun altura-relativa (lista-alturas-absolutas)
  "Retorna pares com altura relativa e valor de oitava a partir de uma
lista de alturas absolutas."
  (loop
     for x in lista-alturas-absolutas
     collect (list (remainder x 12)(* 12 (floor x 12)))))

(defun lily->contorno-com-duracao (codigo-lily)
  "Retorna um contorno a partir de uma string em formato do Lilypond."
  (lista-de-alturas->contorno-com-duracao (altura-absoluta (parse-lily codigo-lily))))

(defun plot-lily (codigo-lily &optional (y1 0) (y2 108) (titulo "foo") (arquivo "foo"))
  "Plota um contorno a partir de uma string em formato do Lilypond."
  (let ((contorno-com-duracao (lily->contorno-com-duracao codigo-lily)))
    (plot-contorno contorno-com-duracao titulo arquivo
                   0 (1- (length contorno-com-duracao)) y1 y2)))

(defun simple-lily->contorno-com-duracao (codigo-lily &optional (oitava-lily "'"))
  "Retorna contorno-com-duracao a partir de uma string em formato
  Lilypond em nível mais alto que lily->contorno-com-duracao."
  (lily->contorno-com-duracao
   (concat "\relative c" oitava-lily " {" codigo-lily "}")))

(defun plot-simple-lily (codigo-lily
                         &optional (oitava-lily "'")
                         (y1 0) (y2 108) (titulo "Contorno")
                         (arquivo "foo"))
  "Plota um contorno a partir de uma string em formato Lilypond em
nível mais alto de abstração que plot-lily."
  (plot-lily
   (concat "\relative c" oitava-lily " {" codigo-lily "}")
   y1 y2 titulo arquivo))
