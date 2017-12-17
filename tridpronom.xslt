<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="xml" indent="yes" />

  <xsl:template match="/">
    <FFSignatureFile xmlns="http://www.nationalarchives.gov.uk/pronom/SignatureFile" Version="1">

      <InternalSignatureCollection>
        <InternalSignature ID="1" Specificity="Specific">
          <xsl:for-each select="TrID/FrontBlock/Pattern">
            <ByteSequence Reference="BOFoffset">
              <SubSequence MinFragLength="0" Position="1" SubSeqMaxOffset="{Pos}" SubSeqMinOffset="{Pos}">
                <Sequence><xsl:value-of select="Bytes"/></Sequence>
                <DefaultShift><xsl:value-of select="string-length(Bytes) div 2 + 1"/></DefaultShift>
                <xsl:call-template name="strSplit">
                  <xsl:with-param name="string" select="Bytes"/>
                </xsl:call-template>
              </SubSequence>
            </ByteSequence>
          </xsl:for-each>
        </InternalSignature>
      </InternalSignatureCollection>

      <FileFormatCollection>
        <FileFormat ID="{TrID/GeneralFileNum}" Name="{TrID/Info/FileType}" PUID="trid/{TrID/General/FileNum}">
          <InternalSignatureID>1</InternalSignatureID>
          <Extension><xsl:value-of select="TrID/Info/Ext"/></Extension>
        </FileFormat>
      </FileFormatCollection>

    </FFSignatureFile>
  </xsl:template>

  <xsl:template name="strSplit">
    <xsl:param name="string"/>
    <xsl:param name="counter" select="1"/>
    <xsl:param name="linelength" select="2"/>
    <xsl:variable name="stringlength" select="string-length($string)"/>
    <xsl:variable name="line" select="substring($string,$stringlength - $linelength + 1,$stringlength)"/>
    <xsl:variable name="rest" select="substring($string,1,$stringlength - $linelength)"/>
    <xsl:if test="$line">
        <Shift xmlns="http://www.nationalarchives.gov.uk/pronom/SignatureFile" Byte="{$line}">
            <xsl:value-of select="$counter"/>
        </Shift> 
    </xsl:if>
    <xsl:if test="$rest">
        <xsl:call-template name="strSplit">
            <xsl:with-param name="string" select="$rest"/>
            <xsl:with-param name="counter" select="$counter + 1"/>
            <xsl:with-param name="linelength" select="$linelength"/>
        </xsl:call-template>
    </xsl:if>   
  </xsl:template>
</xsl:stylesheet>
