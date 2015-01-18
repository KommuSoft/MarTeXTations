<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="xml" indent="yes"/>
  <xsl:variable name="looplength" select="'1000'" /> 
  <xsl:key name="kFollowing" match="*" use="generate-id(preceding-sibling::*[starts-with(name(),'h')][1])"/>
  <xsl:template match="/">
    <html lang="en">
      <head>
        <meta charset="utf-8"/>
        <meta name="viewport" content="width=1024"/>
        <meta name="apple-mobile-web-app-capable" content="yes"/>
        <link href="presentation.css" rel="stylesheet"/>
        <link href="d3plotter/d3plotter/public_html/d3plotter.css" rel="stylesheet"/>
        <link href="custom.css" rel="stylesheet"/>
      </head>
      <body>
        <div class="fallback-message">
          <p>Your browser <b>does not support the features required</b> by impress.js, so you are presented with a simplified version of this presentation.</p>
          <p>For the best experience please use the latest <b>Chrome</b>, <b>Safari</b> or <b>Firefox</b> browser.</p>
        </div>
        <div id="impress">
          <div id="title" class="step" data-x="0" data-y="0" data-z="0" data-scale="5">
            <h1 class="supertitle">
              <center/>
            </h1>
            <span class="date">
              <center/>
            </span>
            <span class="author">
              <div class="authorby">by</div>
            </span>
            <span class="institute"/>
          </div>
          <div id="toc" class="step" data-x="0" data-y="0" data-z="-1000" data-scale="1">
            <h1 class="toctitle">
              <center>Overview</center>
            </h1>
            <div class="toctable">
              <ul>
                <xsl:apply-templates select="//h1" mode="toc"/>
              </ul>
            </div>
          </div>
          <xsl:apply-templates mode="slide" select="//hr"/>
        </div>
      </body>
    </html>
  </xsl:template>
  <xsl:template match="//hr" mode="slide">
    <div id="slide" class="step slide" data-rotate="0" data-x="{$looplength}" data-y="0" data-z="-1000">
      <ul class="breadcrumb">
        <xsl:apply-templates select="((following::hr[1])|(following::*[last()]))[1]" mode="breadcrum"/>
        <!--<li><xsl:apply-templates select="following::hr[1]/preceding::h1[1]"/></li>
        <xsl:if test="count(following::hr[1]/preceding::h2[generate-id(preceding::h1[last()])=generate-id(self/following:hr[1]/preceding::h1[last()])][last()]) &gt; 0">
		    	<span class="divider">/</span><li><xsl:apply-templates select="following::hr[1]/preceding::h2[generate-id(preceding::h1[last()])=generate-id(self/following:hr[1]/preceding::h1[last()])][last()]"/></li>
        </xsl:if>-->
      </ul>
    </div>
  </xsl:template>
  <xsl:template match="//h1" mode="toc">
    <li>
      <xsl:apply-templates select="node()"/>
    </li>
    <xsl:if test="count(following::h2[generate-id(preceding::h1[1])=generate-id(current())]) &gt; 0">
      <ul>
        <xsl:apply-templates select="following::h2[generate-id(preceding::h1[1])=generate-id(current())]" mode="toc"/>
      </ul>
    </xsl:if>
  </xsl:template>
  <xsl:template match="//h2" mode="toc">
    <li>
      <xsl:apply-templates select="node()"/>
    </li>
  </xsl:template>
  <xsl:template match="@*|node()" mode="behead">
    <xsl:if test="name() != 'h1'">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()" />
        </xsl:copy>
    </xsl:if>
    </xsl:template>
    <xsl:template match="*" mode="breadcrum">
      <xsl:apply-templates select="preceding::h1[1]" mode="breadcrum"/>
      <xsl:variable name="slidend" select="generate-id(preceding::h1[1])"/>
      <xsl:if test="count(preceding::h2[generate-id(preceding::h1[1])=$slidend]) &gt; 0">
        <span class="divider">/</span>
        <xsl:apply-templates select="preceding::h2[1]" mode="breadcrum"/>
      </xsl:if>
  </xsl:template>
  <xsl:template match="h1|h2" mode="breadcrum">
    <li>
      <xsl:apply-templates select="node()"/>
    </li>
  </xsl:template>
</xsl:stylesheet>