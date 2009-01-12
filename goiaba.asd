;;; -*- Mode: LISP; Syntax: COMMON-LISP; Package: CL-USER; Base: 10 -*-

(asdf:defsystem :goiaba
  :name "goiaba"
  :version "0.4"
  :author "Marcos di Silva e Pedro Kroger"
  :serial t
  :depends-on (:cl-ppcre :arnesi :cl-pdf :cl-utils)
  :components ((:file "packages")
               (:file "classes")
               (:file "ponto")
               (:file "contorno-duracao")
               (:file "contorno-simples")
               (:file "utils")
               (:file "cores")
               (:file "plot")
               (:module literatura
                        :components ((:file "morris")))
               ;; (:module testes
               ;;          :components ((:file "test-adams")
               ;;                       (:file "test-contorno-duracao")
               ;;                       (:file "test-contorno-simples")
               ;;                       (:file "test-friedmann")
               ;;                       (:file "test-operacoes-contorno")
               ;;                       (:file "test-ponto")
               ;;                       (:file "test-utils")))
               ))

