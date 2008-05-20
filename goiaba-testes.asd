;;; -*- Mode: LISP; Syntax: COMMON-LISP; Package: CL-USER; Base: 10 -*-

(asdf:defsystem :goiaba-testes
  :serial t
  :depends-on (:lisp-unit :goiaba)
  :components ((:module testes
                        :components ((:file "packages")
                                     (:file "test-adams")
                                     (:file "test-friedmann")
                                     (:file "test-operacoes-contorno")
                                     (:file "test-utils")))))

