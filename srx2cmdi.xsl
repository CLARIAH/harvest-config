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
            </cmd:Header>
            <cmd:Resources>
                <cmd:ResourceProxyList>
                    <cmd:ResourceProxy id="rp1">
                        <cmd:ResourceType>Resource</cmd:ResourceType>
                        <cmd:ResourceRef><xsl:value-of select="@dataset"/></cmd:ResourceRef>
                    </cmd:ResourceProxy>
                    <xsl:if test="normalize-space(*:result/*:binding[@name = 'landingPage']/*:uri)!=''">
                        <cmd:ResourceProxy id="lp">
                            <cmd:ResourceType>LandingPage</cmd:ResourceType>
                            <cmd:ResourceRef><xsl:value-of select="*:result/*:binding[@name = 'landingPage']/*:uri"/></cmd:ResourceRef>
                        </cmd:ResourceProxy>
                    </xsl:if>
                </cmd:ResourceProxyList>
                <cmd:JournalFileProxyList/>
                <cmd:ResourceRelationList/>
            </cmd:Resources>
            <cmd:Components>
                <cmdp:DCat>
                    <cmdp:Dataset cmd:ref="rp1">
                        <xsl:for-each-group
                                select="*:result/*:binding[@name = 'title']/*" group-by=".">
                            <cmdp:title xml:lang="{current-group()[1]/@xml:lang}">
                                <xsl:value-of select="current-grouping-key()"/>
                            </cmdp:title>
                        </xsl:for-each-group>
                        <xsl:for-each-group select="*:result/*:binding[@name = 'license']/*"
                                            group-by=".">
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
                                select="*:result/*:binding[@name = 'description']/*"
                                group-by=".">
                            <cmdp:description xml:lang="{current-group()[1]/@xml:lang}">
                                <xsl:value-of select="current-grouping-key()"/>
                            </cmdp:description>
                        </xsl:for-each-group>
                        <xsl:for-each-group
                                select="*:result/*:binding[@name = 'keyword']/*" group-by=".">
                            <cmdp:keyword xml:lang="{current-group()[1]/@xml:lang}">
                                <xsl:value-of select="current-grouping-key()"/>
                            </cmdp:keyword>
                        </xsl:for-each-group>
                        <xsl:for-each-group
                                select="*:result/*:binding[@name = 'landingPage']/*:uri" group-by=".">
                            <cmdp:landingPage>
                                <xsl:value-of select="current-grouping-key()"/>
                            </cmdp:landingPage>
                        </xsl:for-each-group>
                        <xsl:for-each-group
                                select="*:result/*:binding[@name = 'source']/*" group-by=".">
                            <cmdp:source>
                                <xsl:value-of select="current-grouping-key()"/>
                            </cmdp:source>
                        </xsl:for-each-group>
                        <xsl:for-each-group
                                select="*:result/*:binding[@name = 'created']/*" group-by=".">
                            <cmdp:created>
                                <xsl:value-of select="current-grouping-key()"/>
                            </cmdp:created>
                        </xsl:for-each-group>
                        <xsl:for-each-group
                                select="*:result/*:binding[@name = 'modified']/*"
                                group-by=".">
                            <cmdp:modified>
                                <xsl:value-of select="current-grouping-key()"/>
                            </cmdp:modified>
                        </xsl:for-each-group>
                        <xsl:for-each-group
                                select="*:result/*:binding[@name = 'issued']/*" group-by=".">
                            <cmdp:issued>
                                <xsl:value-of select="current-grouping-key()"/>
                            </cmdp:issued>
                        </xsl:for-each-group>
                        <xsl:for-each-group
                                select="*:result/*:binding[@name = 'version']/*:literal" group-by=".">
                            <cmdp:versionInfo>
                                <xsl:value-of select="current-grouping-key()"/>
                            </cmdp:versionInfo>
                        </xsl:for-each-group>
                        <xsl:for-each-group select="*:result/*:binding[@name = 'distribution']"
                                            group-by="*">
                            <xsl:variable name="res" select="current-group()[1]/parent::*:result"/>
                            <cmdp:Distribution>
                                <xsl:for-each-group
                                        select="$res/*:binding[@name = 'distribution_url']/*:uri"
                                        group-by=".">
                                    <cmdp:accessURL>
                                        <xsl:value-of select="current-grouping-key()"/>
                                    </cmdp:accessURL>
                                </xsl:for-each-group>
                                <xsl:for-each-group
                                        select="$res/*:binding[@name = 'distribution_mediaType']/*"
                                        group-by=".">
                                    <cmdp:mediaType>
                                        <xsl:value-of select="current-grouping-key()"/>
                                    </cmdp:mediaType>
                                </xsl:for-each-group>
                                <xsl:for-each-group
                                        select="$res/*:binding[@name = 'distribution_format']/*"
                                        group-by=".">
                                    <cmdp:format>
                                        <xsl:value-of select="current-grouping-key()"/>
                                    </cmdp:format>
                                </xsl:for-each-group>
                                <xsl:for-each-group
                                        select="$res/*:binding[@name = 'distribution_published']/*"
                                        group-by=".">
                                    <cmdp:issued>
                                        <xsl:value-of select="current-grouping-key()"/>
                                    </cmdp:issued>
                                </xsl:for-each-group>
                                <xsl:for-each-group
                                        select="$res/*:binding[@name = 'distribution_modified']/*"
                                        group-by=".">
                                    <cmdp:modified>
                                        <xsl:value-of select="current-grouping-key()"/>
                                    </cmdp:modified>
                                </xsl:for-each-group>
                                <xsl:for-each-group
                                        select="$res/*:binding[@name = 'distribution_description']/*"
                                        group-by=".">
                                    <cmdp:description xml:lang="{current-group()[1]/@xml:lang}">
                                        <xsl:value-of select="current-grouping-key()"/>
                                    </cmdp:description>
                                </xsl:for-each-group>
                                <xsl:for-each-group
                                        select="$res/*:binding[@name = 'distribution_license']/*"
                                        group-by=".">
                                    <cmdp:license>
                                        <xsl:value-of select="current-grouping-key()"/>
                                    </cmdp:license>
                                </xsl:for-each-group>
                                <xsl:for-each-group
                                        select="$res/*:binding[@name = 'distribution_title']/*"
                                        group-by=".">
                                    <cmdp:title xml:lang="{current-group()[1]/@xml:lang}">
                                        <xsl:value-of select="current-grouping-key()"/>
                                    </cmdp:title>
                                </xsl:for-each-group>
                                <xsl:for-each-group
                                        select="$res/*:binding[@name = 'distribution_size']/*"
                                        group-by=".">
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
