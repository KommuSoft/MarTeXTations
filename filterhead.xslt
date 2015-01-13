<?xml version="1.0" encoding="UTF-8" standalone="no" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:plm="http://www.tcxml.org/Schemas/TCXMLSchema" version="1.0">
    <xsl:output method="xml" indent="yes" />
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()" />
        </xsl:copy>
    </xsl:template>
    <xsl:template match="h1|h2">
    </xsl:template>
</xsl:stylesheet>
