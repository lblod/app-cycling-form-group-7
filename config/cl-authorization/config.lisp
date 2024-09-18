;;;;;;;;;;;;;;;;;;;
;;; delta messenger
(in-package :delta-messenger)

(setf *delta-handlers* nil)
(add-delta-logger)
(add-delta-messenger "http://deltanotifier/")

;;;;;;;;;;;;;;;;;
;;; configuration
(in-package :client)
(setf *log-sparql-query-roundtrip* t)
(setf *backend* "http://virtuoso:8890/sparql"
      ;; (list "http://triplestore:8890/sparql"
      ;;       "http://triplestore1:8890/sparql"
      ;;       "http://triplestore2:8890/sparql"
      ;;       "http://triplestore3:8890/sparql"
      ;;       )
      )

(in-package :server)
(setf *log-incoming-requests-p* t)

;;;;;;;;;;;;;;;;;
;;; access rights

(in-package :acl)

(defparameter *access-specifications* nil
  "All known ACCESS specifications.")

(defparameter *graphs* nil
  "All known GRAPH-SPECIFICATION instances.")

(defparameter *rights* nil
  "All known GRANT instances connecting ACCESS-SPECIFICATION to GRAPH.")

(define-prefixes
  :astreams "http://www.w3.org/ns/activitystreams#"
  :adms "http://www.w3.org/ns/adms#"
  :besluit "http://data.vlaanderen.be/ns/besluit#"
  :contacthub "http://data.lblod.info/vocabularies/contacthub/"
  :dct "http://purl.org/dc/terms/"
  :euvoc "http://publications.europa.eu/ontology/euvoc#"
  :ext "http://mu.semte.ch/vocabularies/ext/"
  :eli "http://data.europa.eu/eli/ontology#"
  :foaf "http://xmlns.com/foaf/0.1/"
  :lblodlg "http://data.lblod.info/vocabularies/leidinggevenden/"
  :locn "http://www.w3.org/ns/locn#"
  :m8g "http://data.europa.eu/m8g/"
  :mandaat "http://data.vlaanderen.be/ns/mandaat#"
  :musession "http://mu.semte.ch/vocabularies/session/"
  :nfo "http://www.semanticdesktop.org/ontologies/2007/03/22/nfo#"
  :org "http://www.w3.org/ns/org#"
  :person "http://www.w3.org/ns/person#"
  :persoon "http://data.vlaanderen.be/ns/persoon#"
  :prov "http://www.w3.org/ns/prov#"
  :schema "http://schema.org/"
  :skos "http://www.w3.org/2004/02/skos/core#"
  :extlmb "http://mu.semte.ch/vocabularies/ext/lmb/"
  :lmb "http://lblod.data.gift/vocabularies/lmb/"
  :dossier "https://data.vlaanderen.be/ns/dossier#"
  :time "http://www.w3.org/2006/time#"
  :geosparql "http://www.opengis.net/ont/geosparql#"
  :omgeving "https://data.vlaanderen.be/ns/omgevingsvergunning#"
)

(define-graph public ("http://mu.semte.ch/graphs/public")
  ("prov:Location" -> _)
  ("besluit:Bestuurseenheid" -> _)
  ("ext:BestuurseenheidClassificatieCode" -> _)
  ("skos:ConceptScheme" -> _)
  ("skos:Concept" -> _)
  ("ext:Form" -> _)
  ("ext:Extension" -> _)
  ("m8g:PeriodOfTime" -> _)
  ("foaf:Document" -> _)
  ("dossier:Dossier" -> _)
  ("dossier:Zaak" -> _)
  ("dossier:Procedurestap" -> _)
  ("omgeving:Aanvraag" -> _)
  ("omgeving:Recht" -> _)
  ("omgeving:Activiteit" -> _)
  ("time:Interval" -> _))

(define-graph sessions ("http://mu.semte.ch/graphs/sessions")
  ("musession:Session" -> _))

(define-graph view-only-modules ("http://mu.semte.ch/graphs/authenticated/public")
  ("besluit:Bestuurseenheid" -> "ext:viewOnlyModules"))

(define-graph organization ("http://mu.semte.ch/graphs/organizations/")
  ("foaf:Person" -> _)
  ("foaf:OnlineAccount" -> _)
  ("adms:Identifier" -> _))

(define-graph organization-mandatendatabank ("http://mu.semte.ch/graphs/organizations/")
  ("person:Person" -> _)
  ("omgeving:Activiteit" -> _)
)

(supply-allowed-group "public")

(grant (read write)
       :to-graph public
       :for-allowed-group "public")

(supply-allowed-group "authenticated"
  :parameters ()
  :query "PREFIX ext: <http://mu.semte.ch/vocabularies/ext/>
          PREFIX mu: <http://mu.semte.ch/vocabularies/core/>
          SELECT DISTINCT ?session_group ?session_role WHERE {
            <SESSION_ID> ext:sessionGroup/mu:uuid ?session_group;
                         ext:sessionRole ?session_role.
          }")


(grant (read)                           ; you already can from "public"
       :to-graph public
       :for-allowed-group "authenticated")

(grant (read)
       :to-graph sessions
       :for-allowed-group "authenticated")

(grant (read)
       :to-graph view-only-modules
       :for-allowed-group "authenticated")

(supply-allowed-group "organization-member"
  :parameters ("session_group")
  :query "PREFIX ext: <http://mu.semte.ch/vocabularies/ext/>
          PREFIX mu: <http://mu.semte.ch/vocabularies/core/>
          SELECT ?session_group ?session_role WHERE {
            <SESSION_ID> ext:sessionGroup/mu:uuid ?session_group.
          }")

(grant (read)
       :to-graph organization
       :for-allowed-group "organization-member")

(supply-allowed-group "mandaat-gebruiker"
  :parameters ("session_group" "session_role")
  :query "PREFIX ext: <http://mu.semte.ch/vocabularies/ext/>
          PREFIX mu: <http://mu.semte.ch/vocabularies/core/>
          SELECT DISTINCT ?session_group ?session_role WHERE {
            <SESSION_ID> ext:sessionGroup/mu:uuid ?session_group;
                         ext:sessionRole ?session_role.
            FILTER( ?session_role = \"LoketLB-mandaatGebruiker\" )
          }")

(supply-allowed-group "organization"
  :parameters ("session_group" "session_role")
  :query "PREFIX ext: <http://mu.semte.ch/vocabularies/ext/>
          PREFIX mu: <http://mu.semte.ch/vocabularies/core/>
          SELECT DISTINCT ?session_group ?session_role WHERE {
            <SESSION_ID> ext:sessionGroup/mu:uuid ?session_group;
                         ext:sessionRole ?session_role.
            FILTER( ?session_role = \"CyclingOrg\" )
          }")

(grant (read write)
       :to-graph organization-mandatendatabank
       :for-allowed-group "mandaat-gebruiker")

(grant (read write)
       :to-graph organization-mandatendatabank
       :for-allowed-group "organization")
