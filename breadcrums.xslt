<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" indent="yes"/>
<xsl:key name="kFollowing" match="*" use="generate-id(preceding-sibling::*[starts-with(name(),'h')][1])"/>
    <xsl:template match="/">
        <ul class="breadcrumb">
            <xsl:apply-templates select="//h1[last()]" />
	    </ul>
    </xsl:template>
    <xsl:template match="//h1">
        <li><xsl:apply-templates select="node()" /></li>
        <xsl:if test="count(following::h2[generate-id(preceding::h1[1])=generate-id(current())]) &gt; 0">
		    	<span class="divider">/</span><xsl:apply-templates select="following::h2[generate-id(preceding::h1[1])=generate-id(current())][last()]"/>
        </xsl:if>
    </xsl:template>
    <xsl:template match="//h2">
        <li><xsl:apply-templates select="node()" /></li>
    </xsl:template>
</xsl:stylesheet>
