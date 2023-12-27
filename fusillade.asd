(asdf:defsystem "fusillade"
  :author "garlic0x1"
  :description "A synchronous API to concurrently manipulate sequences"
  :depends-on (:queues.simple-cqueue :bordeaux-threads)
  :components ((:module "src"
                :components ((:file "util")
                             (:file "core")))))
