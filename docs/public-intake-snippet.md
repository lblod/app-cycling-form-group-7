# Datamodel besluit inname openbaar domein

Gebaseerd op besluit van stad Gent:
https://lokaalbeslist.vlaanderen.be/agendapunten/c7f88aa0-cfc7-11ee-b9a9-5b96371453ef

Beslist het volgende:
Artikel 1:
Aan RIA vzw, Harensesteenweg 28, 1800 Vilvoorde, het gebruik van het Citadelpark en omgeving in Gent voor de organisatie van de wielerwedstrijd Omloop Het Nieuwsblad elite mannen en elite vrouwen toe te staan op 24/02/2024 - met start opbouw op 19/02/2024 en einde afbouw op 26/02/2024 - zoals opgenomen in bijgevoegd plan en mits naleving van de voorwaarden geformuleerd in het bij dit besluit gevoegde document.

### Tekst

### RDFa

```html
<div property="prov:generated" resource="http://data.lblod.info/id/besluiten/\${generateUuid()}"
  typeof="besluit:Besluit ext:BesluitNieuweStijl">
  <p>Openbare titel besluit:</p>
  <h4 class="h4" property="eli:title" datatype="xsd:string"><span class="mark-highlight-manual">Geef titel besluit
      op</span></h4>
  <span style="display: none;" property="eli:language"
    resource="http://publications.europa.eu/resource/authority/language/NLD" typeof="skos:Concept">&nbsp;</span> <br />
  <p>Korte openbare beschrijving:</p>
  <p property="eli:description" datatype="xsd:string"><span class="mark-highlight-manual">Geef korte beschrijving
      op</span></p>
  <br />
  <div property="besluit:motivering" lang="nl">
    <p><span class="mark-highlight-manual">geef bestuursorgaan op</span>,</p>
    <br />
    <h5>Bevoegdheid</h5>
    <ul class="bullet-list">
      <li><span class="mark-highlight-manual">Rechtsgrond die bepaalt dat dit orgaan bevoegd is.</span></li>
    </ul>
    <br />
    <h5>Juridische context</h5>
    <ul class="bullet-list">
      <li><span class="mark-highlight-manual">Voeg juridische context in</span></li>
    </ul>
    <br />
    <h5>Feitelijke context en argumentatie</h5>
    <ul class="bullet-list">
      <li><span class="mark-highlight-manual">Voeg context en argumentatie in</span></li>
    </ul>
  </div>
  <br />
  <br />
  <h5>Beslissing</h5>
  <div property="prov:value" datatype="xsd:string">
    <div property="eli:has_part" resource="http://data.lblod.info/artikels/\${generateUuid()}" typeof="besluit:Artikel">
      <div>Artikel <span property="eli:number" datatype="xsd:string">1</span></div>
      <span style="display: none;" property="eli:language"
        resource="http://publications.europa.eu/resource/authority/language/NLD" typeof="skos:Concept">&nbsp;</span>
      <div property="prov:value" datatype="xsd:string">
        <span class="mark-highlight-manual">

            <div rev="eli:realizes" resource="http://data.lblod.info/recht/\${generateUuid()}" typeof="https://data.vlaanderen.be/ns/omgevingsvergunning#Recht">
                <span rev="https://data.vlaanderen.be/ns/omgevingsvergunning#inhoud" resource="http://data.lblod.info/aanvragen/\${generateUuid()}" typeof="https://data.vlaanderen.be/ns/omgevingsvergunning#Aanvraag"></span>
                <div property="https://data.vlaanderen.be/ns/omgevingsvergunning#voorwerp" resource="http://data.lblod.info/innames/\${generateUuid()}"
                typeof="https://data.vlaanderen.be/ns/omgevingsvergunning#Activiteit">
                            
                    Aan <div property="https://data.vlaanderen.be/ns/omgevingsvergunning#betrokkene"
                    resource="http://data.lblod.info/organisaties/\${generateUuid()}">RIA vzw</div>, Harensesteenweg 28, 1800
                    Vilvoorde, het gebruik van <div property="https://data.vlaanderen.be/ns/omgevingsvergunning#locatie"
                    resource="http://data.lblod.info/zones/\${generateUuid()}"><span property="rdfs:label">het
                        Citadelpark</span></div> en <div property="https://data.vlaanderen.be/ns/omgevingsvergunning#locatie"
                    resource="http://data.lblod.info/zones/\${generateUuid()}"><span property="rdfs:label">omgeving in
                        Gent</span></div> voor de organisatie van <span
                    property="https://data.vlaanderen.be/ns/omgevingsvergunning#beschrijving" language="nl"> de
                    wielerwedstrijd Omloop Het Nieuwsblad elite mannen en elite vrouwen</span> toe te staan op <div
                    property="https://data.vlaanderen.be/ns/omgevingsvergunning#Activiteit.tijdsbestek"
                    typeof="time:Interval">24/02/2024 - met start opbouw op <div property="time:hasBeginning"
                        typeof="time:Instant"><span property="time:inXSDDateTime">19/02/2024</span></div> en einde afbouw op
                    <div property="time:hasEnd" typeof="time:Instant"><span property="time:inXSDDateTime">26/02/2024</span>
                    </div> - zoals opgenomen in bijgevoegd plan en mits naleving van de voorwaarden geformuleerd in het bij
                    dit besluit gevoegde document.
                    </div>

                    <div resource="http://data.lblod.info/zones/\${generateUuid()}" typeof="geosparql:Feature">
                    <span property="geosparql:hasGeometry"
                        content="POLYGON((3.7168937735259537 51.03662243938447,3.718567304313183 51.037647059502746,3.7197848595678806 51.03666133741382,3.7188588269054894 51.035874515640955,3.7168937735259537 51.03662243938447))"
                        datatype="geosparql:asWKT"></span>
                    </div>

                    <div resource="http://data.lblod.info/zones/\${generateUuid()}" typeof="geosparql:Feature">
                    <span property="geosparql:hasGeometry"
                        content="LINESTRING(3.7244438210622612 51.03874007628664,3.7204485534162512 51.034672704529555,3.719244678836533 51.029355633627205,3.7121200278422886 51.026144539610016,3.7091498567154004 51.021152279963815)"
                        datatype="geosparql:asWKT"></span>
                    </div>
                </div>
            </div>
        </span>
      </div>

    </div>
  </div>
</div>
```