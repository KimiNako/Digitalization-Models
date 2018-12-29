<?xml version="1.0" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" encoding="ISO-8859-1" />

<xsl:template match="/">
   <html>
      <head>
         <title>
             XSLT REQUESTS
         </title>
     </head>
    <body>
       <h1>
          Nombre total de PO : <xsl:value-of select="count (//POs/PO)" /> 
       </h1>
       <xsl:apply-templates select="//Semestre/PO[not(preceding::PO/. = .)]"/>
   </body>
 </html>
</xsl:template>

<xsl:template match="//Semestre/PO[not(preceding::PO/. = .)]">
 
		PO étudié :
		<xsl:variable name="PO">
     	<xsl:value-of select="."/>
		</xsl:variable>
	
		<xsl:value-of select="$PO"/>


		<p>Nombre total d'UFs : <xsl:value-of select="count (//UF[./Semestre=//Semestre[./PO=$PO]/@numero])" /></p>
<ul>
		<xsl:apply-templates select="//UF[./Semestre=//Semestre[./PO=$PO]/@numero]"/></ul>
		<p>Nombre total de cours :  + Infos sur cours (nom, responsable)</p>

</xsl:template>


<xsl:template match="//UF[./Semestre=//Semestre[./PO=$PO]/@numero]">

	<li>
		<xsl:value-of select="./Intitule"/> : ECTS : <xsl:value-of select="./ECTS"/>
	</li>
</xsl:template>
</xsl:stylesheet>
