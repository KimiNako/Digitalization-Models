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


		<p>Nombre total d'UFs : <xsl:value-of select="count (//UF[./Semestre=//Semestre[./PO=$PO]/@numero])"/></p>
		
		<p>Liste des UFs</p>
		<ul><xsl:apply-templates select="//UF[./Semestre=//Semestre[./PO=$PO]/@numero]"/></ul>

		<p>Liste des UFs avec ECTS > 5 </p>
		<ul><xsl:apply-templates mode="mode1" select="//UF[(./Semestre=//Semestre[./PO=$PO]/@numero) and ECTS>=5]"/></ul>
		<p>Nombre total de cours :  <xsl:value-of select="count (//Matiere_de_l_uf[./UF=//UF[./Semestre=//Semestre[./PO=$PO]/@numero]/@code_apogee])" /></p>

		<p>Liste des cours</p>
		<ul><xsl:apply-templates select="//Matiere_de_l_uf[./UF=//UF[./Semestre=//Semestre[./PO=$PO]/@numero]/@code_apogee]"/></ul>

		<p> Liste des compétences</p>
		<ul> <xsl:apply-templates select="//Matiere_de_l_uf[./UF=//UF[./Semestre=//Semestre[./PO=$PO]/@numero]/@code_apogee]/Competence"/></ul>


</xsl:template>


<xsl:template match="//UF[./Semestre=//Semestre[./PO=$PO]/@numero]">
		<xsl:variable name="UF">
   		  <xsl:value-of select="./@code_apogee"/>
		</xsl:variable>
	<li>
		<xsl:value-of select="./Intitule"/> : 
		<ul>
			<li>Nombre d'heures : <xsl:value-of select="1.25*(sum(//Matiere_de_l_uf[./UF=$UF]/nbr_CM)+sum(//Matiere_de_l_uf[./UF=$UF]/nbr_TD))+2.5*sum(//Matiere_de_l_uf[./UF=$UF]/nbr_TP)"/> heures</li>
			<li>ECTS : <xsl:value-of select="./ECTS"/></li>
		</ul>
		<br></br>
	</li>
</xsl:template>

<xsl:template mode="mode1" match="//UF[./Semestre=//Semestre[./PO=$PO]/@numero and ECTS>=5]" >
	<li>
		<xsl:value-of select="./Intitule"/> (ECTS : <xsl:value-of select="./ECTS"/>)
	</li>
</xsl:template>

<xsl:template match="//Matiere_de_l_uf[./UF=//UF[./Semestre=//Semestre[./PO=$PO]/@numero]/@code_apogee]">
	
		<li> Nom : <xsl:value-of select="./nom"/> 	</li>
		<xsl:variable name="Respo">
     	<xsl:value-of select="./Responsable"/>
		</xsl:variable>
		<li> Responsable : <xsl:value-of select="//Personnel[./@id=$Respo]/nom"/><xsl:text> </xsl:text><xsl:value-of select="//Personnel[./@id=$Respo]/prenom"/></li>
		<li> Epreuves:  <ul><xsl:apply-templates  select=".//Epreuve/@nom"/></ul></li>

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
