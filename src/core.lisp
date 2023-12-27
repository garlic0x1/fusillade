(defpackage :fusillade/core
  (:nicknames :fusillade)
  (:use :cl :fusillade/util)
  (:export #:wmap #:wfilter #:wforeach))
(in-package :fusillade/core)

;; ----------------------------------------------------------------------------
(defgeneric wmap (workers proc in)
  (:documentation "Mapcar a list or cqueue with n workers")

  ;; --------------------------------------------------------------------------
  (:method (workers proc (in list))
    (wmap workers proc (list->simple-cqueue in)))

  ;; --------------------------------------------------------------------------
  (:method (workers proc (in queues:simple-cqueue))
    (let ((out (queues:make-queue :simple-cqueue)))
      (join-consumers workers in (lambda (it) (queues:qpush out (funcall proc it))))
      (simple-cqueue->list out))))

;; ----------------------------------------------------------------------------
(defgeneric wfilter (workers proc in)
  (:documentation "Filter a list or cqueue with n workers")

  ;; --------------------------------------------------------------------------
  (:method (workers proc (in list))
    (wfilter workers proc (list->simple-cqueue in)))

  ;; --------------------------------------------------------------------------
  (:method (workers proc (in queues:simple-cqueue))
    (let ((out (queues:make-queue :simple-cqueue)))
      (join-consumers workers in (lambda (it) (when (funcall proc it) (queues:qpush out it))))
      (simple-cqueue->list out))))

;; ----------------------------------------------------------------------------
(defgeneric wforeach (workers proc in)
  (:documentation "Apply proc to input with n workers")

  ;; --------------------------------------------------------------------------
  (:method (workers proc (in list))
    (wforeach workers proc (list->simple-cqueue in)))

  ;; --------------------------------------------------------------------------
  (:method (workers proc (in queues:simple-cqueue))
    (join-consumers workers in (lambda (it) (funcall proc it)))))
