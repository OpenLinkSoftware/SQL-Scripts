-- Latest Working Edition that replaces HTTP with HTTPS re INSERT statements

LOG_ENABLE(2,1) ;
-- Cleanup
SPARQL
CLEAR GRAPH <urn:mdata:websites:google:seo> ;


-- Sequence following TTL Update on WWW
-- Sites

SPARQL 
ADD  <http://www.openlinksw.com/DAV/data/turtle/openlink.ttl> TO <urn:mdata:websites:google:seo> ;

SPARQL 
ADD  <http://www.openlinksw.com/DAV/virtuoso2.openlinksw.com/data/turtle/about.ttl> TO <urn:mdata:websites:google:seo> ;

SPARQL 
ADD  <http://www.openlinksw.com/DAV/uda2.openlinksw.com/data/turtle/about.ttl> TO <urn:mdata:websites:google:seo> ;

SPARQL 
ADD  <http://www.openlinksw.com/DAV/data/turtle/general/covid19-notes.ttl> TO <urn:mdata:websites:google:seo> ;

SPARQL 
ADD  <http://www.openlinksw.com/DAV/data/turtle/general/uda-page-notes.ttl> TO <urn:mdata:websites:google:seo> ;

SPARQL 
ADD  <http://www.openlinksw.com/DAV/data/turtle/general/linkeddata-notes.ttl> TO <urn:mdata:websites:google:seo> ;

SPARQL 
ADD  <http://www.openlinksw.com/DAV/data/turtle/general/lod-cloud-notes.ttl> TO <urn:mdata:websites:google:seo> ;

SPARQL 
ADD  <http://www.openlinksw.com/DAV/data/turtle/general/odbc-jdbc-notes.ttl> TO <urn:mdata:websites:google:seo> ;

SPARQL 
ADD  <http://www.openlinksw.com/DAV/data/turtle/general/knowledge-GRAPH-notes.ttl> TO <urn:mdata:websites:google:seo> ;

SPARQL 
ADD  <http://www.openlinksw.com/DAV/data/turtle/general/dbms-notes.ttl> TO <urn:mdata:websites:google:seo> ;


SPARQL
ADD  <http://www.openlinksw.com/DAV/data/turtle/general/sponger-notes.ttl> TO <urn:mdata:websites:google:seo> ;

SPARQL
ADD  <http://www.openlinksw.com/DAV/data/turtle/general/virtuoso-offer-faq.ttl> TO <urn:mdata:websites:google:seo> ;

SPARQL
ADD  <http://virtuoso.openlinksw.com/data/turtle/general/virtuoso-faq.ttl> TO <urn:mdata:websites:google:seo> ;

SPARQL
ADD  <http://virtuoso.openlinksw.com/data/turtle/general/virtuoso-homepage-faq.ttl> TO <urn:mdata:websites:google:seo> ;


SPARQL 
ADD <http://virtuoso.openlinksw.com/data/turtle/notes/pages.ttl> TO <urn:mdata:websites:google:seo> ;

SPARQL
ADD <http://www.openlinksw.com/data/turtle/general/about_key_web_site_pages.ttl> TO <urn:mdata:websites:google:seo> ;


SPARQL 
ADD <http://www.openlinksw.com/data/turtle/openlink.ttl> TO <urn:mdata:websites:google:seo> ;

SPARQL
ADD <http://virtuoso.openlinksw.com/data/turtle/notes/about-virtuoso-software-application.ttl> TO <urn:mdata:websites:google:seo> ;



-- Buggy
-- SPARQL
-- add <http://www.openlinksw.com/DAV/uda2.openlinksw.com/data/turtle/multi-tier/2016/UDAMTProducts.ttl> TO <urn:mdata:websites:google:seo>  ;

-- Buggy 
-- SPARQL 
-- add <http://www.openlinksw.com/DAV/uda2.openlinksw.com/data/turtle/single-tier/2016/UDASTProductsReleases.ttl> TO <urn:mdata:websites:google:seo>  ;



-- Additional Site oriented Metadata for Web Pages

-- SPARQL add <http://www.openlinksw.com/DAV/VAD/opl-webseo/data/turtle/webs_mdata.ttl> TO <urn:mdata:websites:google:seo> ;

-- SPARQL add <urn:mdata:websites> TO <urn:mdata:websites:google:seo> ;



-- Offers & Offers Pages

-- SPARQL add <http://www.openlinksw.com/DAV/data/turtle/offers.ttl> TO <urn:mdata:websites:google:seo> ;

-- SPARQL add <http://www.openlinksw.com/DAV/VAD/opl-webseo/data/turtle/offers_mdata.ttl> TO <urn:mdata:websites:google:seo> ;

-- SPARQL add <urn:data:opl:web:seo:mdata:offers> TO <urn:mdata:websites:google:seo> ;
-- COVID19 Notes

SPARQL
INSERT {
         GRAPH <urn:mdata:websites:google:seo> 
            {
                ?s ?p ?o .
           }
       }
WHERE { 
       GRAPH <http://www.openlinksw.com/DAV/data/turtle/general/covid19-notes.ttl>
         {
                ?s ?p ?o . 
                FILTER (contains(str(?p),'schema.org') or ?p = rdf:type) .
         }
} ;

-- ODBC-JDBC Notes 

SPARQL
INSERT {
         GRAPH <urn:mdata:websites:google:seo> 
            {
                ?s ?p ?o .
           }
       }
WHERE { 
       GRAPH <http://www.openlinksw.com/DAV/data/turtle/general/odbc-jdbc-notes.ttl>
         {
                ?s ?p ?o . 
                FILTER (contains(str(?p),'schema.org') or ?p = rdf:type) .
         }
} ;


-- Offers to Offers Page Associations 
	  
SPARQL

PREFIX schema:  <http://schema.org/>
PREFIX opllic:  <http://www.openlinksw.com/ontology/licenses#>
PREFIX oplsoft:  <http://www.openlinksw.com/ontology/software#>
PREFIX oplpro:  <http://www.openlinksw.com/ontology/products#>
PREFIX oplofr:  <http://www.openlinksw.com/ontology/offers#>
PREFIX openlink-page: <http://www.openlinksw.com/> 
PREFIX virtuoso-page: <http://virtuoso.openlinksw.com/>
PREFIX uda: <http://uda.openlinksw.com/#> 


INSERT { GRAPH <urn:mdata:websites:google:seo> 
	     {
                ?ssl a schema:Offer ;
                schema:validFrom ?ValidFromDate ;
                schema:validThrough ?ValidToDate ;
                schema:price ?price ;
                schema:image ?image ;
                schema:category ?category ;
                schema:url ?url_ssl ;
                schema:itemOffered ?item ;
                schema:mainEntityOfPage ?page_ssl ;
                schema:potentialAction ?action_ssl . 
	    }
	   }
WHERE
	  { 
              SELECT ?s (SUBSTR(str(?ValidFrom),0,10) as ?ValidFromDate) (SUBSTR(str(?ValidTo),0,10) as ?ValidToDate)
                     ?price ?image ?category ?url ?item ?page ?action ?dbmsFamily 
              WHERE { 
                      GRAPH <urn:opl:shop:offering:sponging:cache:official> 
                            {
                                   ?s    a schema:Offer ;
                                   schema:validFrom ?ValidFrom ;
                                   schema:validThrough ?ValidTo ;
                                   schema:price ?price ;
                                   schema:image ?image ;
                                   schema:category ?category ;
                                   schema:url ?url ;
                                   schema:itemOffered ?item ;
                                   schema:mainEntityOfPage ?page ;
                                   schema:potentialAction ?action . 
                                   FILTER ( ?ValidFrom <= bif:curutcdatetime() and ?ValidTo >= bif:curutcdatetime()) 
                                   BIND(SUBSTR(str(?ValidFrom),0,10) as ?ValidFromDate)
                                   BIND(SUBSTR(str(?ValidTo),0,10) as ?ValidToDate)

                                   ## For HTTP to HTTPS conversion handling
                                   BIND(IRI(REPLACE(STR(?s),'http:','https:')) AS ?ssl)
                                   BIND(IRI(REPLACE(STR(?page),'http:','https:')) AS ?page_ssl)
                                   BIND(IRI(REPLACE(STR(?action),'http:','https:')) AS ?action_ssl)
                                   BIND(IRI(REPLACE(STR(?url),'http:','https:')) AS ?url_ssl)

                                   ?item oplsoft:hasDatabaseFamily ?dbmsFamily . 
                                   FILTER ( datatype(?ValidFrom) = xsd:dateTime) . 
                                   FILTER ( datatype(?ValidTo) = xsd:dateTime ) . 
                            }
                                          
                     } 
				
	  } ;

-- Page TO DBMS Family Mappings en route TO generating schema:offers relations connecting pages fot offers for SEO GRAPH
-- This is how the live Web Page and Offers association is established via schema:offers relation. 

SPARQL

PREFIX schema:  <http://schema.org/>
PREFIX opllic:  <http://www.openlinksw.com/ontology/licenses#>
PREFIX oplsof:  <http://www.openlinksw.com/ontology/software#>
PREFIX oplpro:  <http://www.openlinksw.com/ontology/products#>
PREFIX oplofr:  <http://www.openlinksw.com/ontology/offers#>
PREFIX openlink-page: <http://www.openlinksw.com/> 
PREFIX virtuoso-page: <http://virtuoso.openlinksw.com/>
PREFIX uda: <http://uda.openlinksw.com/#> 
PREFIX openlink-page-ssl: <https://www.openlinksw.com/> 
PREFIX virtuoso-page-ssl: <https://virtuoso.openlinksw.com/>
PREFIX uda-ssl: <https://uda.openlinksw.com/#> 

INSERT { 
         GRAPH  <urn:mdata:websites:google:seo> 
            {
                ?page_ssl   a schema:WebPage ;
                        schema:name ?page_name ;
                        schema:title ?page_name ;
                        schema:offers ?OfferID ;
                        schema:relatedLink openlink-page-ssl: , virtuoso-page-ssl: ;
                        schema:about  ?SoftwareAppID ;
                        schema:keywords ?keywords . 
                ?SoftwareAppID  a schema:SoftwareApplication ;
                                schema:name ?SoftwareAppName ;
                                schema:title ?SoftwareAppName ;
                                schema:image ?SoftwareImage_ssl ;
                                schema:applicationSuite ?SoftwareAppSuiteName ;
                                schema:applicationCategory ?softwareAppCategory ;
                                schema:applicationSubCategory ?softwareAppSubCategory ;
                                schema:operatingSystem ?softwareAppOS ;
                                schema:softwareVersion ?softwareVersion ;
                                schema:creator <https://www.openlinksw.com/#this> ;
                                schema:copyrightHolder <https://www.openlinksw.com/#this> ;
                                schema:offers ?OfferID . 
                ?OfferID        a schema:Offer ;
                                schema:name ?OfferName ;
                                schema:title ?OfferName ;
                                # schema:image ?image ;
                                schema:validFrom ?ValidFromDate ;
                                # schema:validThrough ?ValidToDate ;
                                schema:priceValidUntil ?ValidToDate ;
                                schema:price ?price ;
                                schema:priceCurrency ?PriceSpecCurrency ;
                                # schema:lowPrice ?price ;
                                # schema:highPrice ?highPrice ;
                                schema:itemOffered ?LicenseID .
                ?LicenseID      a schema:Product ;
                                schema:name ?LicenseName ;
                                schema:title ?LicenseName ;
                                schema:image ?LicenseImage ;
                                schema:description ?LicenseDesc ;
                                # schema:comment ?LicenseComment ;
                                schema:model ?modelName ;
                                schema:brand ?brand ;
                                # schema:price ?price ;
                                schema:offers ?OfferID .
       
          }
	}
WHERE { 
        GRAPH <urn:opl:shop:offering:sponging:cache:official> 
                {
                        ?Offer a ?type ;
                        schema:category ?category ;
                        schema:name ?OfferName ;
                        schema:image ?image ;
                        schema:validFrom ?ValidFrom ;
                        schema:validThrough ?ValidTo .
                        FILTER(?ValidFrom <= bif:curutcdatetime() and ?ValidTo >= bif:curutcdatetime()) .
                        FILTER (CONTAINS(STR(?type),"UDA")) 
                        ?Offer schema:priceSpecification ?pricespec .
                        ?pricespec a schema:UnitPriceSpecification  ;
                                schema:validFrom ?PriceValidFrom ;
                                schema:validThrough ?PriceValidTo ;
                                schema:price ?OfferPrice ;
                                schema:priceCurrency ?PriceSpecCurrency ;
                                oplofr:hasRetailPriceSpecification [schema:price ?OfferRetailPrice] .
                        # FILTER(?PriceValidFrom <= bif:curutcdatetime() and ?PriceValidTo >= bif:curutcdatetime()) . 
                                FILTER(?PriceValidTo >= bif:curutcdatetime()) . 
                        BIND (SUBSTR(str(?ValidFrom),0,10) as ?ValidFromDate)
                        BIND (SUBSTR(str(?ValidTo),0,10) as ?ValidToDate)
                        BIND (IRI(CONCAT(STR(uda-ssl:),MD5(?OfferName))) AS ?OfferID)

                        FILTER (?OfferPrice <= 1500)
                        # OPTIONAL {?pricespec oplofr:hasRetailPriceSpecification [schema:price ?OfferRetailPrice]} .
                        # Set Price values as Strings for Google 
                        BIND (STR(?OfferPrice) as ?price)
                        BIND (STR(?OfferRetailPrice) as ?retailPrice)

                        ?Offer schema:itemOffered ?License .

                        ?License opllic:productLicenseOf ?SoftwareAppRelease ;
                                schema:name ?LicenseName ;
                                schema:image ?LicenseImage ; 
                                schema:description ?LicenseDesc ;
                                schema:comment ?LicenseComment ;
                                schema:model [ schema:name ?modelName ] ;
                                # schema:brand [ schema:name ?brand ] ;
                                # opllic:productLicenseOf ?SoftwareAppRelease ;
                                oplsof:hasOperatingSystemType [ schema:name ?LicenseOSType ] ;
                                oplsoft:hasDatabaseFamily ?dbmsFamily .
                        BIND ("OpenLink Data Access Drivers & Connectors for ODBC, JDBC, and ADO.NET"@en AS ?brand) 
                        BIND (IRI(CONCAT(STR(uda-ssl:),MD5(?LicenseName))) AS ?LicenseID)

                        ?SoftwareAppRelease oplpro:versionText ?softwareVersion ;
                                            schema:image ?SoftwareImage .  
                }
        GRAPH <urn:mdata:websites:google:seo>  
                {
                    ?page a schema:WebPage ;
                            schema:relatedLink ?dbmsFamily ;
                            schema:name ?page_name . 
                } 

        GRAPH ?g { ?dbmsFamily schema:name ?dbmsFamilyName . }


        # To be ultimately enhanced by extractions from ?SoftwareAppRelease Graph

        BIND (IRI(CONCAT(STR(uda-ssl:),MD5(STR(?dbmsFamily)))) AS ?SoftwareAppID)
        BIND (CONCAT('OpenLink ODBC, JDBC, ADO.NET Connector (Driver) for ',REPLACE(?dbmsFamilyName,'Database Family','')) AS ?SoftwareAppName)
        BIND ('Universal Data Access Drivers (UDA) Suite' AS ?SoftwareAppSuiteName)
        BIND ('Middleware' AS ?softwareAppCategory) 
        BIND ('Data Access Drivers / Connectors' AS ?softwareAppSubCategory)
        BIND ('Windows, macOS, Linux, Unix' AS ?softwareAppOS)
        BIND (CONCAT('ODBC, JDBC, ADO.NET, OpenLink, SQL, Data Access, ODBC Driver, JDBC Driver, Connector, Database, Middleware, ', REPLACE(?dbmsFamilyName,'Database Family','')) as ?keywords)  

        ## For HTTP to HTTPS conversion handling
        BIND(IRI(REPLACE(STR(?page),'http:','https:')) AS ?page_ssl)
        BIND(IRI(REPLACE(STR(?SoftwareImage),'http:','https:')) AS ?SoftwareImage_ssl)


    # FILTER (CONTAINS(STR(?page),"Oracle"))
} ;

-- UDA FAQ Pages Description 

SPARQL

PREFIX uda-faq: <http://uda.openlinksw.com/faq#>
PREFIX uda-faq-ssl: <https://uda.openlinksw.com/faq#>
PREFIX schema: <http://schema.org/> 
PREFIX openlink: <http://www.openlinksw.com/#> 
PREFIX openlink-ssl: <https://www.openlinksw.com/#> 
PREFIX openlink-page-ssl: <https://www.openlinksw.com/> 
PREFIX virtuoso-page-ssl: <https://virtuoso.openlinksw.com/>
PREFIX uda-ssl: <https://uda.openlinksw.com/#> 

# SELECT DISTINCT ?page ?question ?questionLabel ?answer ?answerLabel ?audience1 ?keywords ?dateCreated ?dateModified
# FROM <urn:data:opl:web:seo:mdata:webs> 

INSERT {
            GRAPH <urn:mdata:websites:google:seo> 
                  {
                     ?page a schema:WebPage, schema:FAQPage ;
                           schema:name "OpenLink ODBC, JDBC, ADO.NET Drivers and Connectors FAQ Page"@en ;
                           schema:title "OpenLink ODBC, JDBC, ADO.NET Drivers and Connectors FAQ Page"@en ;
                           schema:keywords ?keywords ;
                           schema:dateCreated "2021-05-10"^^xsd:date ;
                           schema:dateModified ?dateModified ;
                           schema:about ?questionID, ?answerID ;
                           schema:publisher openlink-ssl:this .  

                     ?questionID a schema:Question ;
                                schema:name ?questionLabel ; 
                                # schema:dateCreated ?creationDate ;
                                # schema:dateModified ?dateModified ;
                                schema:acceptedAnswer ?answerID. 
                     ?answerID  a schema:Answer ;
                                schema:dateCreated ?creationDate ;
                                schema:dateModified ?dateModified ;
                                schema:name ?answerLabel .
                  }

          }
WHERE {
        GRAPH <urn:data:opl:web:seo:mdata:webs> 
            {
                ?question a schema:Question ;
                        schema:name ?questionLabel ; 
                        schema:dateCreated ?creationDate ;
                        schema:acceptedAnswer ?answer. 
                ?answer schema:name ?answerLabel . 

                FILTER (contains(str(?question),"uda"))
                BIND (<https://uda.openlinksw.com/faq/> as ?page)
                BIND ('ODBC, JDBC, ADO.NET Driver (or Connector) Users' as ?audience1) 
                BIND ('ODBC, JDBC, ADO.NET, OpenLink, FAQ' as ?keywords)  
                # BIND (xsd:date(now()) as ?dateModified)
                BIND (now() as ?dateModified)
                BIND (xsd:date(?creationDate) as ?dateCreated)
                BIND (IRI(CONCAT(STR(uda-faq-ssl:),MD5(?questionLabel))) AS ?questionID)
                BIND (IRI(CONCAT(STR(uda-faq-ssl:),MD5(?answerLabel))) AS ?answerID)
            }
    } ;
		
-- Virtuoso Home Page SEO

SPARQL

PREFIX schema:  <http://schema.org/>
PREFIX opllic:  <http://www.openlinksw.com/ontology/licenses#>
PREFIX oplsof:  <http://www.openlinksw.com/ontology/software#>
PREFIX oplpro:  <http://www.openlinksw.com/ontology/products#>
PREFIX oplofr:  <http://www.openlinksw.com/ontology/offers#>
PREFIX oplfeat: <http://www.openlinksw.com/ontology/features#>
PREFIX uda-page: <http://uda.openlinksw.com/>
PREFIX openlink-page: <http://www.openlinksw.com/> 
PREFIX virtuoso: <http://virtuoso.openlinksw.com/#> 
PREFIX virtuoso-ssl: <https://virtuoso.openlinksw.com/#> 
PREFIX openlink-ssl: <https://www.openlinksw.com/#> 
PREFIX uda-page-ssl: <https://uda.openlinksw.com/>
PREFIX openlink-page-ssl: <https://www.openlinksw.com/> 
PREFIX virtuoso-page-ssl: <https://virtuoso.openlinksw.com/>
PREFIX uda-ssl: <https://uda.openlinksw.com/#> 

#SELECT DISTINCT ?Offer ?SoftwareApp ?Page ?SoftwareAppRelease ?DBMSFamilyName ?DBMSEngineName ?License

INSERT {
            GRAPH <urn:mdata:websites:google:seo> 
			{
                                ?Page_ssl   a schema:WebPage ;
                                            schema:title "Virtuoso Home Page"@en ;
                                            schema:name "Virtuoso Home Page"@en ;
                                            schema:description """High-Performance, Secure, and Scalable Platform that combines Data Acccess,
                                                                  Data Integration, and Multi-Model (SQL & SPARQL) Data Management Services in 
                                                                  a single Cross Platform Solution."""@en ;
                                            schema:keywords """ODBC, JDBC, Database, SQL, SPARQL, RDF, Knowledge Graph, Graph Database, Document Database, 
                                                             XPath, XQuery, XSLT, XML, CSV, JSON, GraphQL, Linked Data, HyperData, Semantic Web"""@en ;
                                            schema:offers ?OfferID ;
                                            schema:relatedLink openlink-page-ssl: , uda-page-ssl: ;
                                            schema:dateModified ?dateModified ;
                                            schema:mainEntity virtuoso-ssl:this ;
                                            schema:about ?SoftwareAppID .  
                                ?SoftwareAppID  a schema:SoftwareApplication ;
                                                schema:name ?SoftwareAppName ;
                                                # schema:url ?SoftwareApp ;
                                                schema:image ?SoftwareImage ;
                                                schema:applicationSuite ?SoftwareAppSuiteName ;
                                                schema:applicationCategory ?softwareAppCategory ;
                                                schema:applicationSubCategory ?softwareAppSubCategory ;
                                                schema:operatingSystem ?softwareAppOS ;
                                                schema:softwareVersion ?softwareVersion ;
                                                schema:creator <https://www.openlinksw.com/#this> ;
                                                schema:copyrightHolder <https://www.openlinksw.com/#this> ;
                                                schema:offers ?OfferID . 
                                ?OfferID
                                    a schema:Offer ;
                                    schema:name ?OfferName ;
                                    # schema:image ?image ;
                                    schema:validFrom ?ValidFromDate ;
                                    # schema:validThrough ?ValidToDate ;
                                    schema:priceValidUntil ?ValidToDate ;
                                    schema:price ?price ;
                                    # schema:lowPrice ?specialPrice ;
                                    # schema:highPrice ?highPrice ;
                                    # schema:priceCurrency ?PriceSpecCurrency ;
                                    schema:itemOffered ?LicenseID . 
                                ?LicenseID a schema:Product ;
                                                schema:name ?LicenseName ;
                                                # schema:sameAs used as dirty owl:sameAs trick for Google solely !!
                                                # schema:sameAs ?License ;
                                                schema:image ?image ;
                                                schema:description ?LicenseDesc ;
                                                # schema:comment ?LicenseComment ;
                                                # schema:price ?price ;
                                                schema:brand ?brand ;
                                                schema:offers ?OfferID .
			}
                  
	   }
WHERE {
        GRAPH  <urn:opl:shop:offering:sponging:cache:official>  
            {
                ?Offer a schema:Offer ;
                    a oplofr:Virtuoso8Offer ;
                    schema:category ?OfferCategory ;
                    schema:name ?OfferName ;
                    schema:price ?OfferPrice ;
                    schema:image ?image ;
                    schema:itemOffered ?License ;
                    schema:validFrom ?ValidFrom ;
                    schema:validThrough ?ValidTo ;
                    schema:priceSpecification ?pricespec . 
                FILTER(?ValidFrom <= bif:curutcdatetime() and ?ValidTo >= bif:curutcdatetime()) .
                BIND(SUBSTR(str(?ValidFrom),0,10) as ?ValidFromDate)
                BIND(SUBSTR(str(?ValidTo),0,10) as ?ValidToDate)
                BIND (STR(?OfferPrice) as ?price)
                BIND (IRI(CONCAT(STR(virtuoso-ssl:),MD5(?OfferName))) AS ?OfferID)

                ?pricespec schema:price ?OfferSpecialPrice ;
                            schema:priceCurrency ?PriceSpecCurrency ;
                            oplofr:hasRetailPriceSpecification [schema:price ?OfferRetailPrice] .
                FILTER (?OfferPrice <= 1500)
                # OPTIONAL {?pricespec oplofr:hasRetailPriceSpecification [schema:price ?OfferRetailPrice]} .
                # Set Price values as Strings for Google 
                BIND (STR(?OfferSpecialPrice) as ?specialPrice)
                BIND (STR(?OfferRetailPrice) as ?retailPrice)

                ?License   opllic:productLicenseOf ?SoftwareAppRelease ;
                        schema:name ?LicenseName ;
                        schema:description ?LicenseDesc ;
                        schema:image ?LicenseImage ;
                        schema:comment ?LicenseComment . 
                BIND (IRI(CONCAT(STR(virtuoso-ssl:),MD5(?LicenseName))) AS ?LicenseID)

                BIND ('Multi-Model Data Database Management System' AS ?softwareAppCategory) .
                BIND ('Database Management System, Knowledge Graph Platform, Graph Database, Data Virtualization, Middleware' AS ?softwareAppSubCategory) .
                BIND ('Windows, macOS, Linux, Unix' AS ?softwareAppOS) .
                BIND ('OpenLink Virtuoso' AS ?brand) .

                # ?SoftwareAppRelease schema:name ?SoftwareReleaseName ;
                #                    oplfeat:hasFeature ?SoftwareAppReleaseFeature ;
                #                    oplpro:versionText ?softwareVersion ;
                #                    schema:image ?SoftwareImage .  
        }

        {
                SELECT ?SoftwareApp ?SoftwareAppRelease 
                    <https://virtuoso.openlinksw.com/> as ?Page 
                    WHERE { GRAPH ?g {
                                        ?SoftwareApp oplpro:hasRelease ?SoftwareAppRelease .
                                    }
                        }
        } 

        GRAPH <urn:data:openlink:products>
              { 
                ?SoftwareAppRelease schema:name ?SoftwareReleaseName ;
                                    oplfeat:hasFeature ?SoftwareAppReleaseFeature ;
                                    oplpro:versionText ?softwareVersion ;
                                    schema:image ?SoftwareImage .  
              }

        # BIND (IRI(CONCAT(virtuoso:,MD5(STR(?SoftwareApp)))) AS ?SoftwareAppID)
        BIND (<https://virtuoso.openlinksw.com/#this> AS ?SoftwareAppID)

        ## For HTTP to HTTPS conversion handling
        BIND(IRI(REPLACE(STR(?Page),'http:','https:')) AS ?Page_ssl)
        BIND(IRI(REPLACE(STR(?SoftwareImage),'http:','https:')) AS ?SoftwareImage_ssl)   
        BIND (now() as ?dateModified)
} ;

-- Virtuoso Pricing FAQ Page SSEO

SPARQL

PREFIX schema:  <http://schema.org/>
PREFIX opllic:  <http://www.openlinksw.com/ontology/licenses#>
PREFIX oplsof:  <http://www.openlinksw.com/ontology/software#>
PREFIX oplpro:  <http://www.openlinksw.com/ontology/products#>
PREFIX oplofr:  <http://www.openlinksw.com/ontology/offers#>
PREFIX faq-page: <http://www.openlinksw.com/data/turtle/general/virtuoso-offer-faq.>
PREFIX openlink-page: <http://www.openlinksw.com/> 
PREFIX uda-page: <http://uda.openlinksw.com/> 
PREFIX virtuoso-faq: <http://virtuoso.openlinksw.com/faq/#> 
PREFIX virtuoso-page: <http://virtuoso.openlinksw.com/#> 
PREFIX virtuoso-ssl: <https://virtuoso.openlinksw.com/#> 
PREFIX openlink-ssl: <https://www.openlinksw.com/#> 
PREFIX uda-page-ssl: <https://uda.openlinksw.com/>
PREFIX openlink-page-ssl: <https://www.openlinksw.com/> 
PREFIX virtuoso-page-ssl: <https://virtuoso.openlinksw.com/>
PREFIX uda-ssl: <https://uda.openlinksw.com/#> 
PREFIX virtuoso-ssl: <https://virtuoso.openlinksw.com/#>

# SELECT DISTINCT ?Offer ?question ?questionLabel ?answer ?answerLabel

INSERT {
            GRAPH <urn:mdata:websites:google:seo> 
                {
                    ?Page a schema:WebPage, schema:FAQPage ;
                            schema:name "Virtuoso Frequently Asked Questions & Answers Page" ;
                            schema:title "Virtuoso Frequently Asked Questions & Answers Page" ;
                            schema:mainEntity virtuoso-ssl:this ;
                            schema:about ?questionID, ?answerID, ?LicenseID, ?OfferID ;
                            schema:relatedLink virtuoso-page-ssl:, openlink-page-ssl: , uda-page-ssl: ;
                            schema:dateModified ?dateModified .

                    ?questionID a schema:Question ;
                                schema:title ?questionLabel ;
                                schema:about ?LicenseID ;
                                schema:suggestedAnswer ?answerID . 
                    
                    ?answerID a schema:Answer ;
                                schema:title ?answerLabel ;
                                schema:about ?LicenseID .

                    ?LicenseID a schema:Product ;
                                schema:name ?LicenseName ;
                                schema:image ?image ;
                                schema:description ?LicenseDesc ;
                                # schema:comment ?LicenseComment ;
                                # schema:price ?price ;
                                schema:offers ?OfferID .
                    ?OfferID
                                a schema:Offer ;
                                schema:name ?OfferName ;
                                # schema:image ?image ;
                                schema:validFrom ?ValidFromDate ;
                                # schema:validThrough ?ValidToDate ;
                                schema:priceValidUntil ?ValidToDate ;
                                schema:price ?price ;
                                # schema:lowPrice ?specialPrice ;
                                # schema:highPrice ?highPrice ;
                                # schema:priceCurrency ?PriceSpecCurrency ;
                                schema:itemOffered ?LicenseID . 

                }               
	   }
WHERE {
            GRAPH  <urn:opl:shop:offering:sponging:cache:official>  
                {
                    ?Offer a schema:Offer ;
                        a oplofr:Virtuoso8Offer ;
                        schema:category ?OfferCategory ;
                        schema:name ?OfferName ;
                        schema:price ?OfferPrice ;
                        schema:image ?image ;
                        schema:itemOffered ?License ;
                        schema:validFrom ?ValidFrom ;
                        schema:validThrough ?ValidTo ;
                        schema:priceSpecification ?pricespec . 
                    FILTER(?ValidFrom <= bif:curutcdatetime() and ?ValidTo >= bif:curutcdatetime()) .
                    BIND(SUBSTR(str(?ValidFrom),0,10) as ?ValidFromDate)
                    BIND(SUBSTR(str(?ValidTo),0,10) as ?ValidToDate)
                    BIND (STR(?OfferPrice) as ?price)
                    BIND (IRI(CONCAT(STR(virtuoso-page-ssl:),MD5(?OfferName))) AS ?OfferID)

                    ?License  opllic:productLicenseOf ?SoftwareAppRelease ;
                            schema:name ?LicenseName ;
                            schema:description ?LicenseDesc ;
                            schema:image ?LicenseImage ;
                            schema:comment ?LicenseComment . 
                    BIND (IRI(CONCAT(STR(virtuoso-page-ssl:),MD5(?LicenseName))) AS ?LicenseID)
            }

            GRAPH ?g1  {
                            ?question a schema:Question ;
                                    schema:acceptedAnswer ?answer ;
                                    schema:name ?questionLabel. 
                            FILTER (LANG(?questionLabel) = "en")

                            ?answer schema:name ?answerLabel . 
                            FILTER (LANG(?answerLabel) = "en")

                            faq-page:ttl schema:about ?question . 

                            BIND (IRI(CONCAT(STR(virtuoso-page-ssl:),MD5(?questionLabel))) AS ?questionID)
                            BIND (IRI(CONCAT(STR(virtuoso-page-ssl:),MD5(?answerLabel))) AS ?answerID)
                        }

            GRAPH ?g2 {
                            SELECT ?SoftwareApp ?SoftwareAppRelease ( <https://virtuoso.openlinksw.com/pricing/> as ?Page )
                            WHERE { 
                                    GRAPH ?g {
                                                ?SoftwareApp oplpro:hasRelease ?SoftwareAppRelease 
                                            }
                                }
                        }

            BIND (now() as ?dateModified)
        } ;

-- Virtuoso FAQ Page SSEO

SPARQL

PREFIX schema:  <http://schema.org/>
PREFIX opllic:  <http://www.openlinksw.com/ontology/licenses#>
PREFIX oplsof:  <http://www.openlinksw.com/ontology/software#>
PREFIX oplpro:  <http://www.openlinksw.com/ontology/products#>
PREFIX oplofr:  <http://www.openlinksw.com/ontology/offers#>
PREFIX faq-page: <http://www.openlinksw.com/data/turtle/general/virtuoso-offer-faq.>
PREFIX openlink-page: <http://www.openlinksw.com/> 
PREFIX uda-page: <http://uda.openlinksw.com/> 
PREFIX virtuoso-faq: <http://virtuoso.openlinksw.com/faq/#> 
PREFIX virtuoso-page: <http://virtuoso.openlinksw.com/#> 
PREFIX virtuoso-ssl: <https://virtuoso.openlinksw.com/#> 
PREFIX openlink-ssl: <https://www.openlinksw.com/#> 
PREFIX uda-page-ssl: <https://uda.openlinksw.com/>
PREFIX openlink-page-ssl: <https://www.openlinksw.com/> 
PREFIX virtuoso-page-ssl: <https://virtuoso.openlinksw.com/>
PREFIX uda-ssl: <https://uda.openlinksw.com/#> 
PREFIX virtuoso-faq-page-ssl: <https://virtuoso.openlinksw.com/faq/> 
PREFIX virtuoso-ssl: <https://virtuoso.openlinksw.com/#>

# SELECT DISTINCT ?Offer ?question ?questionLabel ?answer ?answerLabel

INSERT {
            GRAPH <urn:mdata:websites:google:seo> 
                {
                    ?Page a schema:WebPage, schema:FAQPage ;
                            schema:name "Virtuoso Frequently Asked Questions & Answers Page" ;
                            schema:title "Virtuoso Frequently Asked Questions & Answers Page" ;
                            schema:description """Collection of Questions and Answers addressing all aspects of the Virtuoso Multi-Model DBMS & Data Integration Platform""" ;
                            schema:mainEntity virtuoso-ssl:this ;  
                            schema:about ?questionID, ?answerID ;
                            schema:relatedLink virtuoso-page-ssl:, openlink-page-ssl: , uda-page-ssl: ;
                            schema:dateModified ?dateModified .

                    ?questionID a schema:Question ;
                                schema:title ?questionLabel ;
                                schema:about virtuoso-ssl:this ;
                                schema:suggestedAnswer ?answerID . 
                    
                    ?answerID a schema:Answer ;
                                schema:title ?answerLabel ;
                                schema:about virtuoso-ssl:this .

                }               
	   }
WHERE {
        GRAPH ?g  {
                        ?question a schema:Question ;
                                schema:acceptedAnswer ?answer ;
                                schema:name ?questionLabel. 
                        FILTER (LANG(?questionLabel) = "en")

                        ?answer schema:name ?answerLabel . 
                        FILTER (LANG(?answerLabel) = "en")

                        # faq-page:ttl schema:about ?question . 
                        BIND (IRI(CONCAT(STR(virtuoso-ssl:),MD5(?questionLabel))) AS ?questionID)
                        BIND (IRI(CONCAT(STR(virtuoso-ssl:),MD5(?answerLabel))) AS ?answerID)
                }
        BIND (now() as ?dateModified)
        BIND (virtuoso-faq-page-ssl: as ?Page)

      } ;

-- Cleanup 

SPARQL

PREFIX wdrs: <http://www.w3.org/2007/05/powder-s#> 

WITH <urn:mdata:websites:google:seo> 
DELETE {
          <http://data.openlinksw.com/oplweb/product/column-store-cl#this> ?p ?o .
       } 
WHERE {
          <http://data.openlinksw.com/oplweb/product/column-store-cl#this> ?p ?o .
       } 
;


--- Latest Working Solution

incleng..config_unset(null, null, 'inline_links');
incleng..config_unset(null, null, 'inline_headers');
incleng..config_unset(null, null, 'inline_jsonld');
incleng..config_unset(null, null, 'inline_rdfa');
incleng..config_unset(null, null, 'inline_rdfa_schema_only');
incleng..config_unset(null, null, 'inline_html5md');
incleng..config_unset(null, null, 'inline_jsonld_schema_only');
incleng..config_unset(null, null, 'inline_ttl_schema_only');
incleng..config_unset(null, null, 'inline_ttl');
incleng..config_unset(null, null, 'inline_html5md_schema_only');
incleng..config_unset(null, null, 'sparql_custom_query') ;
incleng..config_unset(null, null, 'custom_query') ;
incleng..config_unset(null, null, 'addthis') ;
incleng..config_unset(null, null, 'debug_level');
incleng..config_unset(null, null, 'sparql_timeout') ;
incleng..config_unset(null, null, 'search_graphs') ;
incleng..config_unset(null, null, 'Website Search');

-- Query Timeouts

incleng..config_set(null, null, 'sparql_timeout', 20000000);

-- Commented Out until JSON-LD works with Google

-- incleng..config_set (null, null, 'inline_jsonld_schema_only', 'DEFINE sql:describe-mode "CBD" DESCRIBE <{url}> ?offer ?about ?item FROM <urn:mdata:websites:google:seo>  WHERE { OPTIONAL {<{url}> schema:offers ?offer; schema:about ?about. ?offer schema:itemOffered ?item } . OPTIONAL {<{url}> schema:about ?about} . OPTIONAL {<{url}> schema:relatedLink ?related} . }');

incleng..config_set (null, null, 'inline_html5md_schema_only', 'DEFINE sql:describe-mode "CBD" DESCRIBE <{url}> ?offer ?about ?item FROM <urn:mdata:websites:google:seo>  WHERE { OPTIONAL {<{url}> schema:offers ?offer; schema:about ?about. ?offer schema:itemOffered ?item } . OPTIONAL {<{url}> schema:about ?about} . OPTIONAL {<{url}> schema:relatedLink ?related} . }');


incleng..config_set(null, null, 'inline_rdfa', 0);
incleng..config_set(null, null, 'inline_links', 0);
incleng..config_set(null, null, 'inline_headers', 0);
incleng..config_set(null, null, 'addthis',0) ;
incleng..config_set(null, null, 'inline_ttl', 0);
incleng..config_set(null, null, 'inline_jsonld', 1);
incleng..config_set(null, null, 'inline_html5md', 1);
incleng..config_set(null, null, 'search_name', 'Website Search');
select incleng..config_flush_cache() ;
