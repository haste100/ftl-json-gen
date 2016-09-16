<#setting number_format="######.##">
<#include "const.ftl" >
<!-- parameter map -->
<#list  objects as object >
<parameter name="${object.objectName?upper_case}_MAP" class="java.util.Map"/>
</#list>
<!-- /parameter map -->

<!-- param fields -->
<#list  objects as object >
    <parameter name="${getReportName(object)}" class="java.lang.Boolean" isForPrompting="false">
        <parameterDescription><![CDATA[Раздел ${object.name}]]></parameterDescription>
        <defaultValueExpression><![CDATA[false]]></defaultValueExpression>
    </parameter>
    <#list object.fields as field>
        <#if !isNote(field)>
            <#if isString(field) || isCombobox(field) >
    <parameter name="${getReportParamName(object, field)}" class="java.lang.String" isForPrompting="false">
        <parameterDescription><![CDATA[${getDesc(field)}]]></parameterDescription>
        <defaultValueExpression><![CDATA[]]></defaultValueExpression>
    </parameter>
            <#elseif isDate(field) >
    <parameter name="${getReportParamName(object, field)}_FROM" class="java.util.Date" isForPrompting="false">
        <parameterDescription><![CDATA[${getDesc(field)} с]]></parameterDescription>
        <defaultValueExpression><![CDATA[new Date()]]></defaultValueExpression>
    </parameter>
    <parameter name="${getReportParamName(object, field)}_TILL" class="java.util.Date" isForPrompting="false">
        <parameterDescription><![CDATA[${getDesc(field)} по]]></parameterDescription>
        <defaultValueExpression><![CDATA[new Date()]]></defaultValueExpression>
    </parameter>
            <#else>
            <!-- Undefined field type [${getType(field)}]-->
            </#if>
        </#if>
    </#list>
</#list>
<!-- /param fields -->

<!-- param subreport -->
<#list  objects as object >
<parameter name="subreport_${object.objectName?lower_case}.jrxml" class="net.sf.jasperreports.engine.JasperReport" isForPrompting="false"/>
</#list>
<!-- /param subreport -->

<!-- column header-->
<#assign x=9859 />
<#list  objects as object >
        <staticText>
            <reportElement key="${getReportName(object)}_KEY" style="Cyr Text Body" x="${x}" y="0" width="${object.width}" height="35">
                <printWhenExpression><![CDATA[$P{${getReportName(object)}} != null]]></printWhenExpression>
            </reportElement>
            <box>
                <topPen lineWidth="1.0"/>
                <leftPen lineWidth="1.0" lineStyle="Solid"/>
                <bottomPen lineWidth="1.0" lineStyle="Solid"/>
                <rightPen lineWidth="1.0"/>
            </box>
            <textElement textAlignment="Center" verticalAlignment="Middle">
                <font isBold="true"/>
            </textElement>
            <text><![CDATA[${object.header}]]></text>
        </staticText>
    <#list object.fields as field>
        <staticText>
            <reportElement style="Cyr Text Body" x="${x}" y="35" width="${getWidth(field)}" height="64">
                <printWhenExpression><![CDATA[$P{${getReportName(object)}} != null]]></printWhenExpression>
            </reportElement>
            <box>
                <topPen lineWidth="1.0"/>
                <leftPen lineWidth="1.0"/>
                <bottomPen lineWidth="0.0"/>
                <rightPen lineWidth="1.0"/>
            </box>
            <textElement textAlignment="Center" verticalAlignment="Middle">
                <font isBold="true"/>
            </textElement>
            <text><![CDATA[${getDesc(field)}]]></text>
        </staticText>
        <#assign x += getWidth(field)?number />
    </#list>
</#list>
<!-- /column header-->


<!-- frames -->
<#assign x=9859 />
<#list  objects as object >
        <frame>
            <reportElement x="${x}" y="0" width="${object.width}" height="42">
                <printWhenExpression><![CDATA[$P{${getReportName(object)}} != null]]></printWhenExpression>
            </reportElement>
            <box>
                <topPen lineWidth="1.0"/>
                <leftPen lineWidth="1.0"/>
                <bottomPen lineWidth="1.0"/>
                <rightPen lineWidth="1.0"/>
            </box>
            <subreport>
                <reportElement positionType="Float" stretchType="RelativeToBandHeight" x="0" y="0" width="${object.width}" height="42">
                    <printWhenExpression><![CDATA[$P{${getReportName(object)}} != null]]></printWhenExpression>
                </reportElement>
                <dataSourceExpression><![CDATA[(new ru.fccland.aki.universalreport.datasource.RpdDataSource($P{${object.objectName?upper_case}_MAP}.get($F{id}))).create()]]></dataSourceExpression>
                <subreportExpression class="net.sf.jasperreports.engine.JasperReport"><![CDATA[$P{subreport_${object.objectName?lower_case}.jrxml}]]></subreportExpression>
            </subreport>
        </frame>
    <#assign x += object.width?number />
</#list>
<!-- /frames -->
