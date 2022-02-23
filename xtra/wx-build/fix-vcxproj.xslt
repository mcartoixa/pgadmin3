<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns="http://schemas.microsoft.com/developer/msbuild/2003"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:msbuild="http://schemas.microsoft.com/developer/msbuild/2003"
  exclude-result-prefixes="msbuild"
>
  <xsl:output method="xml" indent="yes" />

  <xsl:template name="substring-filename">
    <xsl:param name="string" />
    <xsl:choose>
      <xsl:when test="contains($string,'\')">
        <xsl:call-template name="substring-filename">
          <xsl:with-param name="string" select="substring-after($string, '\')" />
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="substring-before($string, '.')" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>



  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="msbuild:PropertyGroup[@Condition and not(@Label)]">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()" />
      <TargetName>
        <xsl:call-template name="substring-filename">
          <xsl:with-param name="string" select="//msbuild:ItemDefinitionGroup[@Condition=current()/@Condition]/*[name()='Link' or name()='Lib']/msbuild:OutputFile" />
        </xsl:call-template>
      </TargetName>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>