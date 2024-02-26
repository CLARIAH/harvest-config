<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:math="http://www.w3.org/2005/xpath-functions/math" xmlns:cmd="http://www.clarin.eu/cmd/1"
                xmlns:cmdp="http://www.clarin.eu/cmd/1/profiles/clarin.eu:cr1:p_1650879720846"
                xmlns:sr="http://www.w3.org/2005/sparql-results#" exclude-result-prefixes="xs math sr"
                version="2.0">

    <xsl:template match="text()"/>

    <xsl:template match="sr:results">
        <cmd:CMD xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                 xmlns:cmd="http://www.clarin.eu/cmd/1"
                 xmlns:cmdp="http://www.clarin.eu/cmd/1/profiles/clarin.eu:cr1:p_1650879720846"
                 CMDVersion="1.2"
                 xsi:schemaLocation="http://www.clarin.eu/cmd/1 https://infra.clarin.eu/CMDI/1.x/xsd/cmd-envelop.xsd http://www.clarin.eu/cmd/1/profiles/clarin.eu:cr1:p_1650879720846 https://catalog.clarin.eu/ds/ComponentRegistry/rest/registry/1.x/profiles/clarin.eu:cr1:p_1650879720846/xsd">
            <cmd:Header>
                <cmd:MdCreator>sparqlresult2cmdi.xsl</cmd:MdCreator>
                <cmd:MdCreationDate><xsl:value-of select="current-date()"/></cmd:MdCreationDate>
                <cmd:MdProfile>clarin.eu:cr1:p_1650879720846</cmd:MdProfile>
                <cmd:MdSelfLink><xsl:value-of select="@dataset"/></cmd:MdSelfLink>
            </cmd:Header>
            <cmd:Resources>
                <cmd:ResourceProxyList>
                    <xsl:for-each-group
                        select="*:result/*:binding[@name = 'dataset']/*:uri" group-by=".">
                        <xsl:if test="position()=1">
                            <cmd:ResourceProxy id="ds">
                                <cmd:ResourceType>Resource</cmd:ResourceType>
                                <cmd:ResourceRef><xsl:value-of select="current-grouping-key()"/></cmd:ResourceRef>
                            </cmd:ResourceProxy>
                        </xsl:if>
                    </xsl:for-each-group>
                    <xsl:for-each-group
                        select="*:result[empty(*:binding[@name='distribution'])][*:binding[@name='p']/*:uri='http://www.w3.org/ns/dcat#landingPage']" group-by="*:binding[@name='o']/*:uri">
                        <xsl:if test="position()=1">
                            <cmd:ResourceProxy id="lp">
                                <cmd:ResourceType>LandingPage</cmd:ResourceType>
                                <cmd:ResourceRef><xsl:value-of select="current-grouping-key()"/></cmd:ResourceRef>
                            </cmd:ResourceProxy>
                        </xsl:if>
                    </xsl:for-each-group>
                    <xsl:for-each-group select="*:result/*:binding[@name = 'distribution']"
                        group-by="*">
                        <cmd:ResourceProxy id="dis-{position()}">
                            <cmd:ResourceType>Resource</cmd:ResourceType>
                            <cmd:ResourceRef><xsl:value-of select="current-grouping-key()"/></cmd:ResourceRef>
                        </cmd:ResourceProxy>
                    </xsl:for-each-group>
                </cmd:ResourceProxyList>
                <cmd:JournalFileProxyList/>
                <cmd:ResourceRelationList/>
            </cmd:Resources>
            <cmd:Components>
                <cmdp:DCat>
                    <cmdp:Dataset cmd:ref="ds">
                        <xsl:for-each-group
                            select="*:result[empty(*:binding[@name='distribution'])][*:binding[@name='p']/*:uri='http://purl.org/dc/terms/title']" group-by="*:binding[@name='o']/*:literal">
                            <cmdp:title xml:lang="{current-group()[1]/@xml:lang}">
                                <xsl:value-of select="current-grouping-key()"/>
                            </cmdp:title>
                        </xsl:for-each-group>
                        <xsl:for-each-group
                            select="*:result[empty(*:binding[@name='distribution'])][*:binding[@name='p']/*:uri='http://purl.org/dc/terms/license']" group-by="*:binding[@name='o']/*:uri">
                            <cmdp:license>
                                <xsl:value-of select="current-grouping-key()"/>
                            </cmdp:license>
                        </xsl:for-each-group>
                        <xsl:for-each-group
                                select="*:result/*:binding[@name = 'publisher']/*" group-by=".">
                            <cmdp:publisher>
                                <xsl:value-of select="current-grouping-key()"/>
                            </cmdp:publisher>
                        </xsl:for-each-group>
                        <xsl:for-each-group
                            select="*:result[empty(*:binding[@name='distribution'])][*:binding[@name='p']/*:uri='http://purl.org/dc/terms/description']" group-by="*:binding[@name='o']/*:literal">
                            <cmdp:description xml:lang="{current-group()[1]/@xml:lang}">
                                <xsl:value-of select="current-grouping-key()"/>
                            </cmdp:description>
                        </xsl:for-each-group>
                        <xsl:for-each-group
                            select="*:result[empty(*:binding[@name='distribution'])][*:binding[@name='p']/*:uri='http://www.w3.org/ns/dcat#keyword']" group-by="*:binding[@name='o']/*:literal">
                            <cmdp:keyword xml:lang="{current-group()[1]/@xml:lang}">
                                <xsl:value-of select="current-grouping-key()"/>
                            </cmdp:keyword>
                        </xsl:for-each-group>
                        <xsl:for-each-group
                            select="*:result[empty(*:binding[@name='distribution'])][*:binding[@name='p']/*:uri='http://www.w3.org/ns/dcat#landingPage']" group-by="*:binding[@name='o']/*:uri">
                            <cmdp:landingPage>
                                <xsl:value-of select="current-grouping-key()"/>
                            </cmdp:landingPage>
                        </xsl:for-each-group>
                        <xsl:for-each-group
                            select="*:result[empty(*:binding[@name='distribution'])][*:binding[@name='p']/*:uri='http://purl.org/dc/terms/source']" group-by="*:binding[@name='o']/*:uri">
                            <cmdp:source>
                                <xsl:value-of select="current-grouping-key()"/>
                            </cmdp:source>
                        </xsl:for-each-group>
                        <xsl:for-each-group
                            select="*:result[empty(*:binding[@name='distribution'])][*:binding[@name='p']/*:uri='http://purl.org/dc/terms/created']" group-by="*:binding[@name='o']/*:literal">
                            <cmdp:created>
                                <xsl:value-of select="current-grouping-key()"/>
                            </cmdp:created>
                        </xsl:for-each-group>
                        <xsl:for-each-group
                            select="*:result[empty(*:binding[@name='distribution'])][*:binding[@name='p']/*:uri='http://purl.org/dc/terms/modified']" group-by="*:binding[@name='o']/*:literal">
                            <cmdp:modified>
                                <xsl:value-of select="current-grouping-key()"/>
                            </cmdp:modified>
                        </xsl:for-each-group>
                        <xsl:for-each-group
                            select="*:result[empty(*:binding[@name='distribution'])][*:binding[@name='p']/*:uri='http://purl.org/dc/terms/issued']" group-by="*:binding[@name='o']/*:literal">
                            <cmdp:issued>
                                <xsl:value-of select="current-grouping-key()"/>
                            </cmdp:issued>
                        </xsl:for-each-group>
                        <xsl:for-each-group
                            select="*:result[empty(*:binding[@name='distribution'])][*:binding[@name='p']/*:uri='http://www.w3.org/2002/07/owlversionInfo']" group-by="*:binding[@name='o']/*:literal">
                            <cmdp:versionInfo>
                                <xsl:value-of select="current-grouping-key()"/>
                            </cmdp:versionInfo>
                        </xsl:for-each-group>
                        <xsl:for-each-group select="*:result[*:binding/@name = 'distribution']"
                            group-by="*:binding[@name='distribution']/*:uri">
                            <cmdp:Distribution ref="dis-{position()}">
                                <xsl:for-each-group
                                    select="current-group()[*:binding[@name='p']/*:uri='http://www.w3.org/ns/dcat#accessURL']" group-by="*:binding[@name='o']/*:uri">
                                    <cmdp:accessURL>
                                        <xsl:value-of select="current-grouping-key()"/>
                                    </cmdp:accessURL>
                                </xsl:for-each-group>
                                <xsl:for-each-group
                                    select="current-group()[*:binding[@name='p']/*:uri='http://www.w3.org/ns/dcat#mediaType']" group-by="*:binding[@name='o']/*:literal">
                                    <cmdp:mediaType>
                                        <xsl:value-of select="current-grouping-key()"/>
                                    </cmdp:mediaType>
                                </xsl:for-each-group>
                                <xsl:for-each-group
                                    select="current-group()[*:binding[@name='p']/*:uri='http://purl.org/dc/terms/format']" group-by="*:binding[@name='o']/*:literal">
                                    <cmdp:format>
                                        <xsl:value-of select="current-grouping-key()"/>
                                    </cmdp:format>
                                </xsl:for-each-group>
                                <xsl:for-each-group
                                    select="current-group()[*:binding[@name='p']/*:uri='ttp://purl.org/dc/terms/issued']" group-by="*:binding[@name='o']/*:literal">
                                    <cmdp:issued>
                                        <xsl:value-of select="current-grouping-key()"/>
                                    </cmdp:issued>
                                </xsl:for-each-group>
                                <xsl:for-each-group
                                    select="current-group()[*:binding[@name='p']/*:uri='http://purl.org/dc/terms/modified']" group-by="*:binding[@name='o']/*:literal">
                                    <cmdp:modified>
                                        <xsl:value-of select="current-grouping-key()"/>
                                    </cmdp:modified>
                                </xsl:for-each-group>
                                <xsl:for-each-group
                                    select="current-group()[*:binding[@name='p']/*:uri='http://purl.org/dc/terms/description']" group-by="*:binding[@name='o']/*:literal">
                                    <cmdp:description xml:lang="{current-group()[1]/@xml:lang}">
                                        <xsl:value-of select="current-grouping-key()"/>
                                    </cmdp:description>
                                </xsl:for-each-group>
                                <xsl:for-each-group
                                    select="current-group()[*:binding[@name='p']/*:uri='http://purl.org/dc/terms/license']" group-by="*:binding[@name='o']/*:literal">
                                    <cmdp:license>
                                        <xsl:value-of select="current-grouping-key()"/>
                                    </cmdp:license>
                                </xsl:for-each-group>
                                <xsl:for-each-group
                                    select="current-group()[*:binding[@name='p']/*:uri='http://purl.org/dc/terms/title']" group-by="*:binding[@name='o']/*:literal">
                                    <cmdp:title xml:lang="{current-group()[1]/@xml:lang}">
                                        <xsl:value-of select="current-grouping-key()"/>
                                    </cmdp:title>
                                </xsl:for-each-group>
                                <xsl:for-each-group
                                    select="current-group()[*:binding[@name='p']/*:uri='http://www.w3.org/ns/dcat#byteSize']" group-by="*:binding[@name='o']/*:literal">
                                    <cmdp:byteSize>
                                        <xsl:value-of select="current-grouping-key()"/>
                                    </cmdp:byteSize>
                                </xsl:for-each-group>
                            </cmdp:Distribution>
                        </xsl:for-each-group>
                    </cmdp:Dataset>
                </cmdp:DCat>
            </cmd:Components>
        </cmd:CMD>
    </xsl:template>

</xsl:stylesheet>
