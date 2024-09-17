(define-resource dossier ()
  :class (s-prefix "dossier:Dossier")
  :properties `((:name :string ,(s-prefix "dct:title")))
              ;; TODO: add status
              ;; TODO: add start and end date
  ;; TODO: link to municipality and organizer (via project)
  ;; :has-one `((bestuurseenheid :via ,(s-prefix "ext:organizedBy"))
  ;;                             :as "organizedBy")
  :resource-base (s-url "http://data.lblod.info/id/dossiers/")
  :on-path "dossiers")
