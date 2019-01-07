<?xml version="1.0" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" encoding="ISO-8859-1" />
<xsl:template match="/">
   <html>
      <head>
			<link href="styleSheet2.css" rel="stylesheet" type="text/css"></link>
         <title>
             XSLT REQUESTS
         </title>
     </head>
    <body>
       <h1>
          
       </h1>
			<table>
			<caption>Pour chaque personne, liste de ses responsabilités (Département, UFs, Cours)</caption>
			<tr>
				<th>nom</th>
				<th>Directeur département</th>
				<th>Responsable de PO</th>
				<th>Responsable des UFs</th>
				<th>Responsable des cours</th>
			</tr>
	       		<xsl:apply-templates select="//Personnel"/>			
	</table>
   </body>
 </html>
</xsl:template>

<xsl:template match="//Personnel">
		<xsl:variable name="idPers">
			<xsl:value-of select="./@id"/>
		</xsl:variable>
			<tr>
				<td><xsl:value-of select="./nom"/><xsl:text> </xsl:text><xsl:value-of select="./prenom"/></td>
				<td><xsl:apply-templates  select="//Departement[Directeur=$idPers]"/></td>
				<td><xsl:apply-templates  select="//PO[Responsable=$idPers]"/></td>
				<td><li><xsl:apply-templates select="//UF[Responsable=$idPers]"/></li></td>
				<td><li><xsl:apply-templates select="//Matiere_de_l_uf[Responsable=$idPers]"/></li></td>
			</tr>
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
