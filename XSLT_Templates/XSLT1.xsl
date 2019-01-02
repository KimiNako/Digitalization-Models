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
          XSLT REQUESTS
       </h1>
       <xsl:apply-templates select="//Semestre/PO[not(preceding::PO/. = .)]"/>
   </body>
 </html>
</xsl:template>
		
<xsl:template match="//Semestre/PO[not(preceding::PO/. = .)]">

		<xsl:variable name="PO">
			<xsl:value-of select="."/>
		</xsl:variable>
		<ul>Nombre total de PO : <xsl:value-of select="count (//POs/PO)" /> </ul>
		<ul>PO étudiée : <xsl:value-of select="$PO"/></ul>
		<ul>Nombre total d'UFs : <xsl:value-of select="count (//UF[./Semestre=//Semestre[./PO=$PO]/@numero])"/></ul>
		<p>Nombre total de cours :  <xsl:value-of select="count (//Matiere_de_l_uf[./UF=//UF[./Semestre=//Semestre[./PO=$PO]/@numero]/@code_apogee])" /></p>
		<p> Liste des compétences</p>
		<ul> <xsl:apply-templates select="//Matiere_de_l_uf[./UF=//UF[./Semestre=//Semestre[./PO=$PO]/@numero]/@code_apogee]/Competence"/></ul>
		
		<table>
			<caption>Liste des UFs</caption>
			<tr>
				<th>Intitulé de l'UF</th>
				<th>Nombre d'heures</th>
				<th>ECTS</th>
			</tr>
			<xsl:apply-templates select="//UF[./Semestre=//Semestre[./PO=$PO]/@numero]"/>
		</table>
		<table>
			<caption>Liste des UFs avec ECTS > 5 </caption>
			<tr>
				<th> nom de l'UF</th>
				<th>nombre d'ECTS</th>
			</tr>
				<xsl:apply-templates mode="mode1" select="//UF[(./Semestre=//Semestre[./PO=$PO]/@numero) and ECTS>=5]"/>
		</table>
		
		<table>
			<caption>Liste des cours</caption>
			<tr>
				<th> nom du cours</th>
				<th>responsable</th>
				<th>épreuves</th>
			</tr>
			<xsl:apply-templates select="//Matiere_de_l_uf[./UF=//UF[./Semestre=//Semestre[./PO=$PO]/@numero]/@code_apogee]"/>
		</table>


</xsl:template>


<xsl:template match="//UF[./Semestre=//Semestre[./PO=$PO]/@numero]">
		<xsl:variable name="UF">
   		  <xsl:value-of select="./@code_apogee"/>
		</xsl:variable>
		<tr>
			<td><xsl:value-of select="./Intitule"/></td>
			<td><xsl:value-of select="1.25*(sum(//Matiere_de_l_uf[./UF=$UF]/nbr_CM)+sum(//Matiere_de_l_uf[./UF=$UF]/nbr_TD))+2.5*sum(//Matiere_de_l_uf[./UF=$UF]/nbr_TP)"/></td>
			<td><xsl:value-of select="./ECTS"/></td>
		</tr>
		<br></br>
</xsl:template>

<xsl:template mode="mode1" match="//UF[./Semestre=//Semestre[./PO=$PO]/@numero and ECTS>=5]" >
	<tr>
		<td><xsl:value-of select="./Intitule"/></td>
		<td><xsl:value-of select="./ECTS"/></td>
	</tr>
</xsl:template>

<xsl:template match="//Matiere_de_l_uf[./UF=//UF[./Semestre=//Semestre[./PO=$PO]/@numero]/@code_apogee]">
	<xsl:variable name="Respo">
     	<xsl:value-of select="./Responsable"/>
	</xsl:variable>
	<tr>
		<td><xsl:value-of select="./nom"/></td>
		<td><xsl:value-of select="//Personnel[./@id=$Respo]/nom"/><xsl:text> </xsl:text><xsl:value-of select="//Personnel[./@id=$Respo]/prenom"/></td>
		<td><ul><xsl:apply-templates  select=".//Epreuve/@nom"/></ul></td>
	</tr>
<br></br>

</xsl:template>
<xsl:template match="Epreuve/@nom">
     <li><xsl:value-of select="."/></li>
</xsl:template>

<xsl:template match="//Matiere_de_l_uf[./UF=//UF[./Semestre=//Semestre[./PO=$PO]/@numero]/@code_apogee]/Competence" >
	<li>
		<xsl:value-of select="./@nom"/> 
	</li>
</xsl:template>
</xsl:stylesheet>
