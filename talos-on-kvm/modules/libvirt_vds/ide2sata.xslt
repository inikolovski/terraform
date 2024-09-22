<?xml version="1.0" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output omit-xml-declaration="yes" indent="yes"/>

  <!-- copy the whole xml doc to start with -->
  <xsl:template match="node()|@*">
     <xsl:copy>
       <xsl:apply-templates select="node()|@*"/>
     </xsl:copy>
  </xsl:template>

  <!-- replace <target dev='hdd'...> with <target dev='sda'...>  -->
  <xsl:template match="/domain/devices/disk[@device='cdrom']/target/@dev">
    <xsl:attribute name="dev">
      <xsl:value-of select="'sda'"/>
    </xsl:attribute>
  </xsl:template>

  <!-- replace <target bus='ide'...> with <target bus='sata'...>  -->
  <xsl:template match="/domain/devices/disk[@device='cdrom']/target/@bus">
    <xsl:attribute name="bus">
      <xsl:value-of select="'sata'"/>
    </xsl:attribute>
  </xsl:template>

  <!-- replace <alias...> with nothing ie delete the <alias...> element  -->
  <xsl:template match="/domain/devices/disk[@device='cdrom']/alias" />

  <!-- replace <vcpu placement='static'...> with <vcpu placement='auto'...>  -->
  <xsl:template match="/domain/vcpu[@placement='static']/@placement">
    <xsl:attribute name="placement">
      <xsl:value-of select="'auto'"/>
    </xsl:attribute>
  </xsl:template>

</xsl:stylesheet>