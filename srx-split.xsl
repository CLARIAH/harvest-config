<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:math="http://www.w3.org/2005/xpath-functions/math" xmlns="http://www.w3.org/2005/sparql-results#" exclude-result-prefixes="xs math" version="3.0">

    <xsl:variable name="HEAD" select="/*:sparql/*:head"/>
    
    <xsl:template match="text()"/>

    <xsl:template match="*:results">
        <!--<SRX>-->
            <xsl:for-each-group select="*:result" group-by="*:binding[@name = 'dataset']/*">
                <xsl:if test="position() = 1">
                    <sparql>
                        <xsl:copy-of select="$HEAD" copy-namespaces="no"/>
                        <results dataset="{current-grouping-key()}">
                            <xsl:copy-of select="current-group()" copy-namespaces="no"/>
                        </results>
                    </sparql>
                </xsl:if>
            </xsl:for-each-group>
        <!--</SRX>-->
    </xsl:template>

</xsl:stylesheet>
