(defpackage :fusillade/util
  (:use :cl)
  (:export #:list->simple-cqueue #:simple-cqueue->list #:join-consumers))
(in-package :fusillade/core)

;; ----------------------------------------------------------------------------
(defun list->simple-cqueue (list)
  (let ((q (queues:make-queue :simple-cqueue)))
    (loop :for it :in list :do (queues:qpush q it))
    q))

;; ----------------------------------------------------------------------------
(defun simple-cqueue->list (q)
  (loop :with it :and ok
        :do (setf (values it ok) (queues:qpop q))
        :while ok :collect it))

;; ----------------------------------------------------------------------------
(defmacro join-workers (workers &body body)
  `(mapcar #'bt:join-thread
    (loop :repeat ,workers
          :collect (bt:make-thread (lambda () ,@body)))))

;; ----------------------------------------------------------------------------
(defmacro queue-consumer (q &body proc)
  `(loop :with it :and ok
         :do (setf (values it ok) (queues:qpop ,q))
         :while ok :do (funcall ,(car proc) it)))

;; ----------------------------------------------------------------------------
(defmacro join-consumers (workers q &body proc)
  `(join-workers ,workers (queue-consumer ,q ,(car proc))))
