(defpackage :fusillade-test
  (:use :cl :fiveam :fusillade))
(in-package :fusillade-test)

;; ----------------------------------------------------------------------------
(def-suite :fusillade
  :description "Tests for Fusillade")
(in-suite :fusillade)

;; ----------------------------------------------------------------------------
(defparameter 1-9 '(1 2 3 4 5 6 7 8 9))
(defparameter 1-9-evens '(2 4 6 8))
(defparameter 2-10 '(2 3 4 5 6 7 8 9 10))
(defparameter 2-10-evens '(2 4 6 8 10))

;; ----------------------------------------------------------------------------
(test :map
  (is (equal 1-9 (wmap 1 #'1- 2-10)))
  (is (equal 1-9 (wmap 16 #'1- 2-10)))
  (is (equal 2-10 (wmap 16 #'1+ 1-9))))


;; ----------------------------------------------------------------------------
(test :filter
  (is (equal 1-9-evens (wfilter 1 #'evenp 1-9)))
  (is (equal 2-10-evens (wfilter 16 #'evenp 2-10))))

;; ----------------------------------------------------------------------------
(test :foreach
  (let ((counter 0))
    (wforeach 16 (lambda (it) (incf counter)) 1-9)
    (is (= counter 9))))
