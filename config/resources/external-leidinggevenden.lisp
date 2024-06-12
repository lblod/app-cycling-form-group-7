;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; LEIDINGGEVENDEN ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; this is a shared domain file, maintained in https://github.com/lblod/domain-files (file master-leidinggevenden-domain)

(define-resource bestuursfunctie ()
  :class (s-prefix "lblodlg:Bestuursfunctie")
  :has-one `((bestuursfunctie-code :via ,(s-prefix "org:role")
                                   :as "rol")
             (contact-punt :via ,(s-prefix "schema:contactPoint")
                           :as "contactinfo"))
  :has-many `((bestuursorgaan :via ,(s-prefix "lblodlg:heeftBestuursfunctie")
                              :inverse t
                              :as "bevat-in"))
  :resource-base (s-url "http://data.lblod.info/id/bestuursfuncties/")
  :features '(include-uri)
  :on-path "bestuursfuncties")
