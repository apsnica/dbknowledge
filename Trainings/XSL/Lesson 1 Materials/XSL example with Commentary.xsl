<!-- #### Obligatory lines and fields #### -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="xml" encoding="UTF-8" indent="yes" />
    
    <!-- #NAME OF THE MAP REQUEST#
  
		Source = #ATS NAME# 
        #VENDOR ID# =  #BULK POSTER#
        
		Link:
		#LINK TO JOB SOURCE#
  -->
  <!-- Calls master parent or the very first point of beginning (Which is defined as "*"). -->
    <xsl:template match="*">

        <xsl:element name="Batch">
            <xsl:element name="Header">
                <xsl:element name="Field">
                    <xsl:attribute name="name">CBVendorID</xsl:attribute>
                    <xsl:attribute name="value">1234</xsl:attribute>
                </xsl:element>
                <xsl:element name="Field">
                    <xsl:attribute name="name">CBOrigin</xsl:attribute>
                    <xsl:attribute name="value">CustomXSL</xsl:attribute>
                </xsl:element>
                <xsl:element name="Field">
                    <xsl:attribute name="name">CBReplace</xsl:attribute>
                    <xsl:attribute name="value">Yes</xsl:attribute>
                </xsl:element>
                <xsl:element name="Field">
                    <xsl:attribute name="name">CBReplyTo</xsl:attribute>
                    <xsl:attribute name="value">dpisupport@careerbuilder.com,autopublish@careerbuilder.com</xsl:attribute>
                </xsl:element>
            </xsl:element>
<!-- #### End of obligatory lines and fields #### -->
        <!-- Calls child nodes -->
            <xsl:for-each select="job">
                <xsl:element name="Job">
                    <xsl:element name="Field">
                        <xsl:attribute name="name">CBAction</xsl:attribute>
                        <xsl:attribute name="value">Add</xsl:attribute>
                    </xsl:element>
                    <xsl:element name="Field">
                        <xsl:attribute name="name">CBContactCompany</xsl:attribute>
                        <xsl:attribute name="value">WR Systems</xsl:attribute>
                    </xsl:element>
                    <xsl:element name="Field">
                        <xsl:attribute name="name">CBUserJobID</xsl:attribute>
                        <xsl:attribute name="value">
                        <!-- Calls node containing CBUserJobID and concatenates it with the required destination site tag -->
                            <xsl:value-of select="concat('US-',jobId)" />
                        </xsl:attribute>
                    </xsl:element>
                    <xsl:element name="Field">
                        <xsl:attribute name="name">CBApplyURL</xsl:attribute>
                        <xsl:attribute name="value">
                            <xsl:value-of select="concat(applyUrl,'&amp;jobboardid=82')" />
							
                        </xsl:attribute>
                    </xsl:element>
                    <xsl:element name="Field">
                        <xsl:attribute name="name">CBDisplayJobID</xsl:attribute>
                        <xsl:attribute name="value">
                            <xsl:value-of select="trackingCode" />
                        </xsl:attribute>
                    </xsl:element>
                    <xsl:element name="Field">
                        <xsl:attribute name="name">CBJobTitle</xsl:attribute>
                        <xsl:attribute name="value">
                            <xsl:value-of select="title" />
                        </xsl:attribute>
                    </xsl:element>
                    <xsl:element name="Field">
                        <xsl:attribute name="name">CBCity</xsl:attribute>
                        <xsl:attribute name="value">
                            <xsl:value-of select="jobLocation/municipality" />
                        </xsl:attribute>
                    </xsl:element>
                    <xsl:element name="Field">
                        <xsl:attribute name="name">CBState</xsl:attribute>
                        <xsl:attribute name="value">
                            <xsl:value-of select="jobLocation/region" />
                        </xsl:attribute>
                    </xsl:element>
                    <xsl:element name="Field">
                        <xsl:attribute name="name">CBCountry</xsl:attribute>
                        <xsl:attribute name="value">
                            <xsl:value-of select="jobLocation/countryCode" />
                        </xsl:attribute>
                    </xsl:element>
                    <xsl:element name="Field">
                        <xsl:attribute name="name">CBDescription</xsl:attribute>
                        <xsl:attribute name="value">
                            <xsl:value-of select="jobDescription" />
                        </xsl:attribute>
                    </xsl:element>
				                    <xsl:element name="Field">
                        <xsl:attribute name="name">CBRequirements</xsl:attribute>
                        <xsl:attribute name="value">
                            <xsl:value-of select="requiredSkills" />
                        </xsl:attribute>
                    </xsl:element>
				
					            <xsl:element name="Field">
              <xsl:attribute name="name">CBEmployeeType</xsl:attribute>
              <xsl:attribute name="value">
                <xsl:choose>
                  <xsl:when test="contains(positionType,'Full-time')">JTFT</xsl:when>
                  <xsl:when test="contains(positionType,'Part-time')">JTPT</xsl:when>
				  <xsl:when test="contains(positionType,'Per Diem')">JTPD</xsl:when>
                  <xsl:otherwise>JTFT</xsl:otherwise>
                </xsl:choose>
              </xsl:attribute>
            </xsl:element>
                </xsl:element>
                <!-- End of CB Job node -->
            </xsl:for-each>
            <!-- End of Newton entry node -->
        </xsl:element>
        <!-- End of Batch -->
    </xsl:template>
    <xsl:template name="replace_ab">
        <!-- with string s, replace substring a by string b -->
        <!-- s, a and b are parameters determined upon calling  -->
        <xsl:param name="s" />
        <xsl:param name="a" />
        <xsl:param name="b" />
        <xsl:choose>
            <xsl:when test="contains($s,$a)">
                <xsl:value-of select="substring-before($s,$a)" />
                <xsl:copy-of select="$b" />
                <xsl:call-template name="replace_ab">
                    <xsl:with-param name="s" select="substring-after($s,$a)" />
                    <xsl:with-param name="a" select="$a" />
                    <xsl:with-param name="b" select="$b" />
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$s" />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>