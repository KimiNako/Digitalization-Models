<?xml version="1.0" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" encoding="ISO-8859-1" />
<xsl:template match="/">
   <html>
      <head>
			<link href="styleSheet.css" rel="stylesheet" type="text/css"></link>
         <title>
             XSLT REQUESTS
         </title>
     </head>
    <body>
       <h1>
          
       </h1>
       <xsl:apply-templates select="//Personnel"/>
   </body>
 </html>
</xsl:template>

<xsl:template match="//Personnel">
	<h3><xsl:value-of select="./nom"/><xsl:text> </xsl:text><xsl:value-of select="./prenom"/></h3>
	<ul>
		<xsl:variable name="idPers">
			<xsl:value-of select="./@id"/>
		</xsl:variable>
		<xsl:if test="//Departement[Directeur=$idPers]">
			<li>Directeur département : <xsl:apply-templates  select="//Departement[Directeur=$idPers]"/></li>
		</xsl:if>
		<xsl:if test="//PO[Responsable=$idPers]">
			<li>Responsable de PO : <xsl:apply-templates  select="//PO[Responsable=$idPers]"/></li>
		</xsl:if>
		<xsl:if test="//UF[Responsable=$idPers]">
			<li>Responsable des UFs : <ul><xsl:apply-templates select="//UF[Responsable=$idPers]"/></ul></li>
		</xsl:if>
		<xsl:if test="//Matiere_de_l_uf[Responsable=$idPers]">
		<li>Responsable des cours :<ul><xsl:apply-templates select="//Matiere_de_l_uf[Responsable=$idPers]"/></ul></li>
		</xsl:if>
	</ul>
<br></br>
</xsl:template>

<xsl:template match="//Departement[Directeur=$idPers]">
		<xsl:value-of select="./nom"/>
</xsl:template>

<xsl:template match="//PO[Responsable=$idPers]">
		<xsl:value-of select="nom"/>
</xsl:template>

<xsl:template match="//UF[Responsable=$idPers]">
	<xsl:if test="not(preceding::Intitule/.=./Intitule)">
		<li><xsl:value-of select="./Intitule"/></li>
	</xsl:if>
</xsl:template>

<xsl:template match="//Matiere_de_l_uf[Responsable=$idPers]">
	<xsl:if test="not(preceding::nom=./nom)">
		<li><xsl:value-of select="nom"/></li>
	</xsl:if>
</xsl:template>
</xsl:stylesheet>
