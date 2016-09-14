<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="xml" encoding="UTF-8" indent="yes" />
    <!-- WR Systems-US
  
		Source = Silkroad 
        ED3K4QF5XJYYKN6P3WHS = 	bulkposterUS@wrsystems.com
        
		Link:
		https://wrsystems-openhire.silkroad.com/api/index.cfm?fuseaction=app.getJobListings&FORMAT=xml&JOBPLACEMENT=external&KEYWORD=&LANGUAGE=en&VERSION=1

  -->
    <xsl:template match="*">
        <xsl:variable name="q">"</xsl:variable>
        <xsl:variable name="lsq">“</xsl:variable>
        <xsl:variable name="rsq">”</xsl:variable>
        <xsl:variable name="sq">'</xsl:variable>
        <xsl:variable name="rssq">’</xsl:variable>
        <xsl:variable name="lf">&#xA;</xsl:variable>
        <xsl:variable name="brtag">&lt;BR /&gt;</xsl:variable>
        <xsl:element name="Batch">
            <xsl:element name="Header">
                <xsl:element name="Field">
                    <xsl:attribute name="name">CBVendorID</xsl:attribute>
                    <xsl:attribute name="value">ED3K4QF5XJYYKN6P3WHS</xsl:attribute>
                </xsl:element>
                <xsl:element name="Field">
                    <xsl:attribute name="name">CBOrigin</xsl:attribute>
                    <xsl:attribute name="value">Silkroad-CustomXSL</xsl:attribute>
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