;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Installatievergaderingen ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define-resource installatievergadering ()
  :class (s-prefix "ext:Installatievergadering")
  :has-one `((installatievergadering-status :via ,(s-prefix "ext:hasStatus")
                                            :as "status")
             (bestuursorgaan :via ,(s-prefix "ext:hasBestuursorgaanInDeTijd")
                             :as "bestuursorgaan-in-tijd"))
  :resource-base (s-url "http://data.lblod.info/id/installatievergaderingen/")
  :features '(include-uri)
  :on-path "installatievergaderingen")

(define-resource installatievergadering-status ()
  :class (s-prefix "ext:InstallatievergaderingStatus")
  :properties `((:label :string ,(s-prefix "skos:prefLabel")))
  :resource-base (s-url "http://data.lblod.info/id/concept/InstallatievergaderingStatus/")
  :features '(include-uri)
  :on-path "installatievergadering-statussen")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Verkiezingen ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define-resource rechtstreekse-verkiezing ()
  :class (s-prefix "mandaat:RechtstreekseVerkiezing")
  :properties `((:datum :date ,(s-prefix "mandaat:datum"))
                (:geldigheid :date ,(s-prefix "dct:valid")))
  :has-one `((bestuursorgaan :via ,(s-prefix "mandaat:steltSamen")
                             :as "bestuursorgaan-in-tijd"))
  :has-many `((kandidatenlijst :via ,(s-prefix "mandaat:behoortTot")
                               :inverse t
                               :as "kandidatenlijsten"))
  :resource-base (s-url "http://data.lblod.info/id/rechtstreekse-verkiezingen/")
  :features '(include-uri)
  :on-path "rechtstreekse-verkiezingen")

(define-resource kandidatenlijst ()
  :class (s-prefix "mandaat:Kandidatenlijst")
  :properties `((:lijstnaam :string ,(s-prefix "skos:prefLabel"))
                (:lijstnummer :number ,(s-prefix "mandaat:lijstnummer")))
  :has-one `((lijsttype :via ,(s-prefix "mandaat:lijsttype")
                        :as "lijsttype")
             (rechtstreekse-verkiezing :via ,(s-prefix "mandaat:behoortTot")
                                       :as "verkiezing"))
  :has-many `((persoon :via ,(s-prefix "mandaat:heeftKandidaat")
                       :as "kandidaten")
              (verkiezingsresultaat :via ,(s-prefix "mandaat:isResultaatVoor")
                                    :inverse t
                                    :as "resultaten"))
  :resource-base (s-url "http://data.lblod.info/id/kandidatenlijsten/")
  :features '(include-uri)
  :on-path "kandidatenlijsten")

(define-resource lijsttype ()
  :class (s-prefix "ext:KandidatenlijstLijsttype")
  :properties `((:label :string ,(s-prefix "skos:prefLabel"))
                (:scope-note :string ,(s-prefix "skos:scopeNote")))
  :resource-base (s-url "http://data.vlaanderen.be/id/concept/KandidatenlijstLijsttype/")
  :features '(include-uri)
  :on-path "lijsttypes")

(define-resource verkiezingsresultaat ()
  :class (s-prefix "mandaat:Verkiezingsresultaat")
  :properties `((:aantal-naamstemmen :number ,(s-prefix "mandaat:aantalNaamstemmen"))
                (:plaats-rangorde :number ,(s-prefix "mandaat:plaatsRangorde")))
  :has-one `((persoon :via ,(s-prefix "mandaat:isResultaatVan")
                      :as "persoon")
             (kandidatenlijst :via ,(s-prefix "mandaat:isResultaatVoor")
                              :as "kandidatenlijst")
             (verkiezingsresultaat-gevolg-code :via ,(s-prefix "mandaat:gevolg")
                                               :as "gevolg"))
  :resource-base (s-url "http://data.lblod.info/id/verkiezingsresultaten/")
  :features '(include-uri)
  :on-path "verkiezingsresultaten")

(define-resource verkiezingsresultaat-gevolg-code ()
  :class (s-prefix "ext:VerkiezingsresultaatGevolgCode")
  :properties `((:label :string ,(s-prefix "skos:prefLabel")))
  :resource-base (s-url "http://data.vlaanderen.be/id/concept/VerkiezingsresultaatGevolgCode/")
  :features '(include-uri)
  :on-path "verkiezingsresultaat-gevolg-codes")