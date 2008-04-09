;;; -*- Mode: LISP; Syntax: COMMON-LISP; Package: CL-USER; Base: 10 -*-

(asdf:defsystem :goiaba
  :name "goiaba"
  :version "0.1"
  :author "Marcos di Silva e Pedro Kroger"
  :serial t
  :depends-on (:lisp-unit :cl-ppcre)
  :components (
               (:file "packages")
               (:file "utils")
               (:file "lily")
               (:file "operacoes-contorno")
               (:file "operacoes-lista")
               (:file "plot")
               (:file "adams")
               (:file "friedmann")
               (:file "morris")
               (:file "test-operacoes-contorno")
               (:file "test-operacoes-lista")
               (:file "test-adams")
               (:file "test-friedmann")
               (:file "test-morris")
               ))