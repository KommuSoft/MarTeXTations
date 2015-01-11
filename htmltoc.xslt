<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" indent="yes"/>
<xsl:key name="kFollowing" match="body/*" use="generate-id(preceding-sibling::*[starts-with(name(),'h')][1])"/>
    <xsl:template match="//body">
        <ul>
            <xsl:apply-templates select="//h1" />
	    </ul>
    </xsl:template>
    <xsl:template match="//h1">
        <li><xsl:apply-templates select="@*" /></li>
        <ul>
        	<xsl:apply-templates select="following::h2[generate-id(preceding::h1[1])=generate-id(current())]"/>
        </ul>
    </xsl:template>
    <xsl:template match="//h2">
        <li><xsl:apply-templates select="@*" /></li>
    </xsl:template>
</xsl:stylesheet>
