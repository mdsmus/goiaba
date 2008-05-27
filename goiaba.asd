;;; -*- Mode: LISP; Syntax: COMMON-LISP; Package: CL-USER; Base: 10 -*-

(asdf:defsystem :goiaba
  :name "goiaba"
  :version "0.4"
  :author "Marcos di Silva e Pedro Kroger"
  :serial t
  :depends-on (:cl-ppcre :arnesi :cl-pdf)
  :components ((:file "packages")
               (:file "classes")
               (:file "ponto")
               (:file "contorno-duracao")
               (:file "contorno-simples")
               (:file "utils")
;;               (:file "lily")
;;               (:file "plot")
	       (:file "pdf")
	       (:file "plot")
;;;                (:module literatura
;;;                         :components ((:file "adams")
;;;                                      (:file "friedmann")
;;;                                      (:file "morris")))
               ))
