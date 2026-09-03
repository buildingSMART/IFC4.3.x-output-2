<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/TR/WD-xsl">

<!-- 
# XSL for Property Set Definition Layer1 (PSD1)

# Author: adachi@ai.isl.secom.co.jp (Yoshinobu Adachi)
# Version: 1.0 Beta
# Organization: International Alliance for Interoperability
# Date: 1999/06/28 0.1
        2000/03/22 0.2
	2000/03/29 0.3 delete min, max, default. change font
	2000/03/31 0.4 added TypedClass HREF
	2000/09/03 0.5 New IFC 2x. (IfcPropertySingleVlaue)
	2000/10/10 0.6
 -->

  <xsl:template match="/">
    <HTML>
      <HEAD>
      <TITLE>IFC 2x Property Set Definition Reference</TITLE>
      </HEAD>
      <BODY>
       <font face="arial"/>
       <H2>IFC <font face="Times New Roman"><b><i>2x</i></b></font> Property Set Definition Reference</H2>
       <HR size="5"/>

       <xsl:apply-templates select="PropertySetDef"/>

       <H3><FONT color="green">Property Definitions:</FONT></H3>
        <TABLE BORDER="1" WIDTH="90%">
         <TR bgcolor = "#D0D0D0" VALIGN="bottom">
            <TD WIDTH="23%" ALIGN="center"><font size="2"/><b>Name</b></TD>
            <TD WIDTH="23%" ALIGN="center"><font size="2"/><b>Property Type</b></TD>
            <TD WIDTH="23%" ALIGN="center"><font size="2"/><b>Data Type</b></TD>
            <TD WIDTH="31%" ALIGN="center"><font size="2"/><b>Definition</b></TD>
            <xsl:apply-templates select="PropertySetDef/PropertyDefs" />
          </TR>
        </TABLE>
	<HR size="5"/>
	<font size="2">Copyright (c) 1996-2020 buildingSMART International Limited</font>
      </BODY>
    </HTML>
  </xsl:template>

  <xsl:template match="PropertySetDef">
        <H3><FONT color="green">PropertySet Definition:</FONT></H3>
        <TABLE BORDER="2" WIDTH="90%">
	<TR VALIGN="top">
	  <TD bgcolor = "#C0C0F0" WIDTH="18%"><font size="2"/><b>PropertySet Name</b></TD>
	  <TD bgcolor = "#FFFFFF"><font size="2"/><xsl:value-of select="Name"/><BR/></TD>
	</TR>
	<TR VALIGN="top">
	  <TD bgcolor = "#C0C0F0" WIDTH="18%"><font size="2"/><b>Typed</b></TD>
	  <TD bgcolor = "#FFFFFF"><font size="2"/><xsl:value-of select="Typed"/><BR/></TD>
	</TR>
	<TR VALIGN="top">
	  <TD bgcolor = "#C0C0F0" WIDTH="18%"><font size="2"/><b>TypedClass</b></TD>
	  <TD bgcolor = "#FFFFFF">
		<a>
		<xsl:attribute name="HREF">
		  ../<xsl:value-of select="IfcVersion/@schema"/>/lexical/<xsl:value-of select="TypedClass"/>.html
		</xsl:attribute>
		<font size="2"/><xsl:value-of select="TypedClass"/>
		</a><BR/>
	  </TD>
	</TR>
	<TR VALIGN="top">
	  <TD bgcolor = "#C0C0F0" WIDTH="18%"><font size="2"/><b>TypeName</b></TD>
	  <TD bgcolor = "#FFFFFF"><font size="2"/><xsl:value-of select="TypeName"/><BR/></TD>
	</TR>
	<TR VALIGN="top">
	  <TD bgcolor = "#C0C0F0"><font size="2"/><b>Definition</b></TD>
	  <TD bgcolor = "#FFFFFF"><font size="2"/><xsl:value-of select="Definition"/><BR/></TD>
	</TR>
        </TABLE>
  </xsl:template>

  <xsl:template match="PropertyDefs">
       <xsl:for-each select="PropertyDef">
         <TR>
           <TD VALIGN="top">
            <font size="2">
		<xsl:value-of select="Name"/>
	      </font>
           </TD>

           <xsl:apply-templates select="PropertyType" />
	   
	   <TD ALIGN="left" VALIGN="top">
            <font size="2">
             <xsl:apply-templates select="Definition" />
	      </font>
    	   </TD>
         </TR>
       </xsl:for-each>
  </xsl:template>

  <xsl:template match="PropertyType">

      <xsl:if test="TypePropertySingleValue">
	  <xsl:apply-templates select="TypePropertySingleValue"/>
      </xsl:if>
      <xsl:if test="TypePropertyReferenceValue">
	  <xsl:apply-templates select="TypePropertyReferenceValue"/>
      </xsl:if>
      <xsl:if test="TypePropertyEnumeratedValue">
	  <xsl:apply-templates select="TypePropertyEnumeratedValue"/>
      </xsl:if>
      <xsl:if test="TypeComplexProperty">
        <TD ALIGN="left" VALIGN="top">
        <font size="2">
          IfcComplexProperty
        </font>
        </TD>
	  <xsl:apply-templates select="TypeComplexProperty/PropertyType/TypePropertySingleValue"/>
	  <xsl:apply-templates select="TypeComplexProperty/PropertyType/TypePropertyEnumeratedValue"/>
	  <xsl:apply-templates select="TypeComplexProperty/PropertyType/TypePropertyReferenceValue"/>
	  <xsl:apply-templates select="TypeComplexProperty/PropertyType/TypeLibraryReference"/>
      </xsl:if>
      <xsl:if test="TypeLibraryReference">
	IfcLibraryReference
	<TD ALIGN="left" VALIGN="top">
	  <BR/>
	</TD>
      </xsl:if>

  </xsl:template>

  <xsl:template match="TypePropertySingleValue">
    <TD ALIGN="left" VALIGN="top">
        <font size="2">
      IfcPropertySingleValue
        </font>
    </TD>
    <TD ALIGN="left" VALIGN="top">
        <font size="2">
      <xsl:apply-templates select="DataType"/>
      <xsl:apply-templates select="UnitType"/>
        </font>
    </TD>
  </xsl:template>

  <xsl:template match="TypePropertyReferenceValue">
    <TD ALIGN="left" VALIGN="top">
        <font size="2">
      IfcPropertyReferenceValue
        </font>
    </TD>
    <TD ALIGN="left" VALIGN="top">
        <font size="2">
      <xsl:value-of select="@reftype"/>
        </font>
    </TD>
  </xsl:template>

  <xsl:template match="TypePropertyEnumeratedValue">
    <TD ALIGN="left" VALIGN="top">
        <font size="2">
      IfcPropertyEnumeratedValue
        </font>
    </TD>
    <TD ALIGN="left" VALIGN="top">
        <font size="2">
      <xsl:apply-templates select="EnumList"/>
        </font>
    </TD>
  </xsl:template>

  <xsl:template match="TypeComplexProperty/PropertyType/TypePropertySingleValue">
    <TD ALIGN="left" VALIGN="top">
        <font size="2">
      IfcPropertySingleValue, 
      <xsl:apply-templates select="DataType"/>
      <xsl:apply-templates select="UnitType"/>
        </font>
    </TD>
  </xsl:template>
  <xsl:template match="TypeComplexProperty/PropertyType/TypePropertyEnumeratedValue">
    <TD ALIGN="left" VALIGN="top">
        <font size="2">
      IfcPropertyEnumeratedValue, 
      <xsl:apply-templates select="EnumList"/>
        </font>
    </TD>
  </xsl:template>
  <xsl:template match="TypeComplexProperty/PropertyType/TypePropertyReferenceValue">
    <TD ALIGN="left" VALIGN="top">
        <font size="2">
      IfcPropertyReferenceValue, 
      <xsl:value-of select="@reftype"/>
        </font>
    </TD>
  </xsl:template>

  <xsl:template match="EnumList">
    <xsl:value-of select="@name"/><ul>
    <xsl:for-each select="EnumItem">
      <li><xsl:value-of /></li> 
    </xsl:for-each>
	</ul>
     </xsl:template>



  <xsl:template match="DataType">
      <xsl:value-of select="@type"/>
  </xsl:template>

  <xsl:template match="UnitType">
      /
      <xsl:value-of select="@type"/>
  </xsl:template>


  <xsl:template match="Definition">
      <xsl:value-of />
  </xsl:template>

</xsl:stylesheet>

<!-- EOF -->
