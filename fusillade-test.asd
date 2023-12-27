(asdf:defsystem "fusillade-test"
  :author "garlic0x1"
  :description "A synchronous API to concurrently manipulate sequences"
  :depends-on (:fiveam :fusillade)
  :components ((:module "t"
                :components ((:file "fusillade-test")))))
