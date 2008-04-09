;;; -*- Mode: LISP; Syntax: COMMON-LISP; Package: CL-USER; Base: 10 -*-

(asdf:defsystem :test-goiaba
  :name "test-goiaba"
  :version "0.1"
  :author "Marcos di Silva e Pedro Kroger"
  :serial t
  :depends-on (:lisp-unit :cl-ppcre :goiaba)
  :components ((:file "packages")
               (:file "test-operacoes-contorno")
               (:file "test-operacoes-lista")
               (:file "test-adams")
               (:file "test-friedmann")
               (:file "test-morris")))