;; Official model from https://data.vlaanderen.be/doc/applicatieprofiel/besluit-subsidie/#Participatie

(define-resource subsidiemaatregel-consumptie ()
  :class (s-prefix "subsidie:SubsidiemaatregelConsumptie")
  :has-one `((aanvraag :via ,(s-prefix "prov:wasGeneratedBy")
                       :as "aanvraag")
             (subsidiemaatregel-aanbod :via ,(s-prefix "transactie:isInstantieVan")
                                       :as "subsidiemaatregel-aanbod"))
  :resource-base (s-url "http://data.lblod.info/subsidiemaatregel-consumpties/")
  :features '(include-uri)
  :on-path "subsidiemaatregel-consumpties")

(define-resource aanvraag ()
  :class (s-prefix "subsidie:Aanvraag")
  :properties `((:aanvraagdatum :date ,(s-prefix "subsidie:aanvraagdatum")))
  :has-one `((aangevraagd-bedrag :via ,(s-prefix "subsidie:aangevraagdBedrag")
                                 :as "aangevraagd-bedrag")
             (application-form :via ,(s-prefix "prov:used")
                               :as "application-form"))
  :resource-base (s-url "http://data.lblod.info/aanvraagen/")
  :features '(include-uri)
  :on-path "aanvraagen")

(define-resource aangevraagd-bedrag ()
  :class (s-prefix "schema:MonetaryAmount")
  :properties `((:value :number ,(s-prefix "subsidie:aanvraagdatum"))
                (:currency :string ,(s-prefix "subsidie:aanvraagdatum")))
  :resource-base (s-url "http://data.lblod.info/aangevraagd-bedragen/")
  :features '(include-uri)
  :on-path "aangevraagd-bedragen")

(define-resource subsidiemaatregel-aanbod () ;; subclass of skos:Concept
  :class (s-prefix "subsidie:SubsidiemaatregelAanbod")
  :properties `((:naam :string ,(s-prefix "dct:title")) ;; needed for aanbod
                (:label :string ,(s-prefix "skos:prefLabel"))) ;; needed for concept
  :has-one `((criterium :via ,(s-prefix "m8g:hasCriterion")
                        :as "criterium")
             (subsidieprocedurestap :via ,(s-prefix "cpsv:follows")
                                    :as "subsidieprocedurestap")
             (concept-scheme :via ,(s-prefix "skos:inScheme")
                             :as "concept-scheme"))
  :resource-base (s-url "http://lblod.data.gift/concepts/")
  :features '(include-uri)
  :on-path "subsidiemaatregel-aandbiedingen")

(define-resource subsidieprocedurestap ()
  :class (s-prefix "subsidie:Subsidieprocedurestap")
  :properties `((:beschrijving :string ,(s-prefix "dct:description"))
                (:type :uri-set ,(s-prefix "subsidie:Subsidieprocedurestap.type")))
  :has-one `((periode :via ,(s-prefix "mobiliteit:periode")
                      :as "periode"))
  :resource-base (s-url "http://data.lblod.info/subsidieprocedurestappen/")
  :features '(include-uri)
  :on-path "subsidieprocedurestappen")

(define-resource periode ()
  :class (s-prefix "m8g:PeriodOfTime")
  :properties `((:begin :datetime ,(s-prefix "m8g:startTime"))
                (:einde :datetime ,(s-prefix "m8g:endTime")))
  :resource-base (s-url "http://data.lblod.info/perioden/")
  :features '(include-uri)
  :on-path "perioden")

(define-resource criterium ()
  :class (s-prefix "m8g:Criterion")
  :properties `((:naam :datetime ,(s-prefix "dct:title"))
                (:type :uri-set ,(s-prefix "m8g:criterionType")))
  :has-one `((vereistengroep :via ,(s-prefix "m8g:fulfilledByRequirementGroup")
                             :as "vereistengroep")
             (subsidieprocedurestap :via ,(s-prefix "dct:isPartOf")
                                    :as "subsidieprocedurestap"))
  :resource-base (s-url "http://data.lblod.info/criteriums/")
  :features '(include-uri)
  :on-path "criteriums")

(define-resource vereistengroep ()
  :class (s-prefix "m8g:RequirementGroup")
  :has-one `((vereistengroep :via ,(s-prefix "m8g:hasCriterionRequirement")
                             :as "vereistengroep"))
  :resource-base (s-url "http://data.lblod.info/vereistengroepen/")
  :features '(include-uri)
  :on-path "vereistengroepen")

(define-resource criteriumvereiste ()
  :class (s-prefix "m8g:CriterionRequirement")
  :has-one `((periode :via ,(s-prefix "m8g:applicableInPeriodOfTime")
                      :as "periode"))
  :resource-base (s-url "http://data.lblod.info/criteriumvereisten/")
  :features '(include-uri)
  :on-path "criteriumvereisten")


;; Dirty space

(define-resource application-form ()
  :class (s-prefix "lblodSubsidie:ApplicationForm")
  :properties `((:aanvraagdatum :date ,(s-prefix "subsidie:aanvraagdatum"))
                (:created :datetime ,(s-prefix "dct:created"))
                (:modified :datetime ,(s-prefix "dct:modified")))
  :has-one `((bestuurseenheid :via ,(s-prefix "pav:createdBy")
                              :as "organization")
             (contact-punt :via ,(s-prefix "schema:contactPoint")
                           :as "contactinfo")
             (bank-account :via ,(s-prefix "schema:bankAccount")
                           :as "bank-account")
             (time-block :via ,(s-prefix "lblodSubsidie:timeBlock")
                         :as "time-block")
             (subsidiemaatregel-aanbod :via ,(s-prefix "lblodSubsidie:subsidyMeasure")
                                       :as "subsidy-measure")
             (application-form-table :via ,(s-prefix "lblodSubsidie:applicationFormTable")
                                     :as "application-form-table")
             (gebruiker :via ,(s-prefix "ext:lastModifiedBy")
                        :as "last-modifier")
             (gebruiker :via ,(s-prefix "dct:creator")
                        :as "creator")
             (submission-document-status :via ,(s-prefix "adms:status")
                                         :as "status"))
  :resource-base (s-url "http://data.lblod.info/application-forms/")
  :features '(include-uri)
  :on-path "application-forms")

(define-resource bank-account ()
  :class (s-prefix "schema:BankAccount")
  :properties `((:bank-account-number :string ,(s-prefix "schema:identifier")))
  :has-one `((file :via ,(s-prefix "dct:hasPart")
                   :as "confirmation-letter"))
  :resource-base (s-url "http://data.lblod.info/bank-accounts/")
  :features '(include-uri)
  :on-path "bank-accounts")

(define-resource time-block () ;; subclass of skos:Concept
  :class (s-prefix "gleif:Period")
  :properties `((:label :string ,(s-prefix "skos:prefLabel"))
                (:start :date ,(s-prefix "gleif:hasStart"))
                (:end :date ,(s-prefix "gleif:hasEnd")))
  :has-one `((time-block :via ,(s-prefix "ext:submissionPeriod")
                         :as "submission-period")
             (concept-scheme :via ,(s-prefix "skos:inScheme")
                             :as "concept-scheme"))
  :resource-base (s-url "http://lblod.data.gift/concepts/")
  :features '(include-uri)
  :on-path "time-blocks")

(define-resource application-form-table ()
  :class (s-prefix "lblodSubsidie:ApplicationFormTable")
  :has-many `((application-form-entry :via ,(s-prefix "ext:applicationFormEntry")
                                      :as "application-form-entries"))
  :resource-base (s-url "http://data.lblod.info/application-form-tables/")
  :features '(include-uri)
  :on-path "application-form-tables")

(define-resource application-form-entry ()
  :class (s-prefix "ext:ApplicationFormEntry")
  :properties `((:actor-name :string ,(s-prefix "ext:actorName"))
                (:number-children-for-full-day :number ,(s-prefix "ext:numberChildrenForFullDay"))
                (:number-children-for-half-day :number ,(s-prefix "ext:numberChildrenForHalfDay"))
                (:number-children-per-infrastructure :number ,(s-prefix "ext:numberChildrenPerInfrastructure"))
                (:created :datetime ,(s-prefix "dct:created")))
  :resource-base (s-url "http://data.lblod.info/application-form-entries/")
  :features '(include-uri)
  :on-path "application-form-entries")
